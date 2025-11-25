import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/dubbing_user.dart';
import '../services/likes_service.dart';
import '../services/hidden_videos_service.dart';
import '../services/blocked_users_service.dart';
import 'video_player_page.dart';
import 'ai_character_page.dart';
import 'popular_users_page.dart';
import 'nalani_vip_screen.dart';

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({super.key});

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  List<DubbingUser> _users = [];
  bool _isLoading = true;
  String _selectedGender = 'male';
  final LikesService _likesService = LikesService();
  final HiddenVideosService _hiddenVideosService = HiddenVideosService();
  final BlockedUsersService _blockedUsersService = BlockedUsersService();
  Map<String, Map<int, int>> _userLikes = {};
  Map<String, int?> _userSelectedEmoji = {};
  List<String> _hiddenVideos = [];
  List<String> _blockedUsers = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  List<DubbingUser> get _filteredUsers {
    return _users
        .where((user) => 
            user.sex == _selectedGender && 
            !_hiddenVideos.contains(user.userId) &&
            !_blockedUsers.contains(user.userId))
        .toList();
  }

  Future<void> _loadUsers() async {
    try {
      final String response = await rootBundle.loadString('assets/BaseRestriction/dubbing_users.json');
      final List<dynamic> data = json.decode(response);
      final users = data.map((json) => DubbingUser.fromJson(json)).toList();
      
      final userIds = users.map((u) => u.userId).toList();
      await _likesService.initializeLikes(userIds);
      final hiddenVideos = await _hiddenVideosService.getHiddenVideos();
      final blockedUsers = await _blockedUsersService.getBlockedUsers();
      
      final likes = <String, Map<int, int>>{};
      final selectedEmoji = <String, int?>{};
      for (var user in users) {
        likes[user.userId] = {};
        selectedEmoji[user.userId] = await _likesService.getSelectedEmoji(user.userId);
        for (int i = 0; i < 4; i++) {
          likes[user.userId]![i] = await _likesService.getLikes(user.userId, i);
        }
      }
      
      setState(() {
        _users = users;
        _userLikes = likes;
        _userSelectedEmoji = selectedEmoji;
        _hiddenVideos = hiddenVideos;
        _blockedUsers = blockedUsers;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _handleEmojiTap(String userId, int emojiType) async {
    await _likesService.toggleEmoji(userId, emojiType);
    final newSelectedEmoji = await _likesService.getSelectedEmoji(userId);
    
    final updatedLikes = <int, int>{};
    for (int i = 0; i < 4; i++) {
      updatedLikes[i] = await _likesService.getLikes(userId, i);
    }
    
    setState(() {
      _userLikes[userId] = updatedLikes;
      _userSelectedEmoji[userId] = newSelectedEmoji;
    });
  }

  // 检查VIP状态
  Future<bool> _checkVipStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isVip = prefs.getBool('nalaniIsVip') ?? false;
    
    if (!isVip) {
      return false;
    }
    
    // 检查VIP是否过期
    final expiryStr = prefs.getString('nalaniVipExpiry');
    if (expiryStr != null) {
      final expiry = DateTime.tryParse(expiryStr);
      if (expiry != null && expiry.isBefore(DateTime.now())) {
        // VIP已过期
        await prefs.setBool('nalaniIsVip', false);
        return false;
      }
    }
    
    return true;
  }

  // 检查并处理VIP访问视频
  Future<void> _checkAndNavigateToVideo(DubbingUser user) async {
    final isVip = await _checkVipStatus();
    
    if (isVip) {
      // VIP用户，直接跳转
      if (mounted) {
        final result = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => VideoPlayerPage(
              videoPath: user.videoPath,
              userDisplayName: user.displayName,
              postTitle: user.postTitle,
              userId: user.userId,
            ),
          ),
        );
        if (result == true) {
          final hiddenVideos = await _hiddenVideosService.getHiddenVideos();
          if (mounted) {
            setState(() {
              _hiddenVideos = hiddenVideos;
            });
          }
        }
      }
    } else {
      // 非VIP用户，显示确认对话框
      if (mounted) {
        final shouldSubscribe = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('VIP Required'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'This feature requires Nalani Premium subscription.\nWould you like to subscribe?',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3D0),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFFFF9538),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Subscription Plans:',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text(
                            '• Weekly: ',
                            style: TextStyle(fontSize: 12, color: Color(0xFF666666)),
                          ),
                          const Text(
                            '\$12.99/week',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFF9538),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Text(
                            '• Monthly: ',
                            style: TextStyle(fontSize: 12, color: Color(0xFF666666)),
                          ),
                          const Text(
                            '\$49.99/month',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFF9538),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF9538),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'POPULAR',
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Subscribe'),
              ),
            ],
          ),
        );

        if (shouldSubscribe == true && mounted) {
          // 跳转到VIP订阅页面
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const VipScreen(),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 180),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: 100,
                height: 36,
                child: Image.asset(
                  'assets/nalani_home_explore.webp',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(Icons.error_outline, size: 20),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const PopularUsersPage(),
                          ),
                        );
                      },
                      child: _buildImage('assets/nalani_home_popular.webp'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const AICharacterPage(),
                          ),
                        );
                      },
                      child: _buildImage('assets/nalani_home_ai.webp'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: SizedBox(
                  width: 179,
                  height: 38,
                  child: Image.asset(
                    'assets/nalani_home_featured.webp',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.error_outline, size: 20),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildGenderTabs(),
            const SizedBox(height: 20),
            if (_isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: CircularProgressIndicator(),
                ),
              )
            else
              _buildUserList(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String imagePath) {
    return Image.asset(
      imagePath,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: 100,
          color: Colors.grey[300],
          child: const Center(
            child: Icon(Icons.error_outline),
          ),
        );
      },
    );
  }

  Widget _buildGenderTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedGender = 'male';
                });
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: _selectedGender == 'male'
                      ? const Color(0xFFFF9538)
                      : const Color(0xFFFFD4A3),
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(25),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Knight's Tale",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _selectedGender == 'male' ? Colors.white : Colors.grey[600],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedGender = 'female';
                });
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: _selectedGender == 'female'
                      ? const Color(0xFFFF9538)
                      : const Color(0xFFFFD4A3),
                  borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(25),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Lady's Legend",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _selectedGender == 'female' ? Colors.white : Colors.grey[600],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: _filteredUsers.map((user) => _buildUserCard(user)).toList(),
      ),
    );
  }

  Widget _buildUserCard(DubbingUser user) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: GestureDetector(
                onTap: () => _checkAndNavigateToVideo(user),
                child: Stack(
                  children: [
                    Image.asset(
                      user.coverPath,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.image, size: 50),
                        );
                      },
                    ),
                    Positioned(
                      bottom: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFAF69).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '#${user.postTitle}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Image.asset(
                        'assets/nalani_home_play.webp',
                        width: 60,
                        height: 60,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.play_circle_fill,
                            size: 60,
                            color: Color(0xFFFF9538),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: 12,
                      right: 12,
                      child: CircleAvatar(
                        radius: 24,
                        backgroundImage: AssetImage(user.avatarPath),
                        onBackgroundImageError: (_, __) {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: _buildEmojiButton(user.userId, 0, '😆', _userLikes[user.userId]?[0] ?? 0),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildEmojiButton(user.userId, 1, '🤣', _userLikes[user.userId]?[1] ?? 0),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildEmojiButton(user.userId, 2, '😢', _userLikes[user.userId]?[2] ?? 0),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildEmojiButton(user.userId, 3, '🥺', _userLikes[user.userId]?[3] ?? 0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmojiButton(String userId, int emojiType, String emoji, int count) {
    final isSelected = _userSelectedEmoji[userId] == emojiType;
    
    return GestureDetector(
      onTap: () => _handleEmojiTap(userId, emojiType),
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFFF9538).withOpacity(0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFFF9538)
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                emoji,
                style: TextStyle(
                  fontSize: isSelected ? 24 : 20,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                '$count',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected
                      ? const Color(0xFFFF9538)
                      : Colors.black87,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

