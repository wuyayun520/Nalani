import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/dubbing_user.dart';
import '../services/blocked_users_service.dart';
import 'user_detail_page.dart';
import 'nalani_wallet_screen.dart';

class PopularUsersPage extends StatefulWidget {
  const PopularUsersPage({super.key});

  @override
  State<PopularUsersPage> createState() => _PopularUsersPageState();
}

class _PopularUsersPageState extends State<PopularUsersPage> {
  List<DubbingUser> _allUsers = [];
  List<String> _blockedUsers = [];
  String _selectedCategory = 'Anime';
  bool _isLoading = true;
  AudioPlayer? _audioPlayer;
  String? _playingUserId;
  bool _isPlaying = false;
  bool _isPreparingAudio = false;
  StreamSubscription? _playerStateSubscription;
  final BlockedUsersService _blockedUsersService = BlockedUsersService();
  static const int _unlockCost = 48; // 解锁一个用户消耗48金币
  static const String _unlockedUsersKey = 'unlocked_users';

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  @override
  void dispose() {
    _playerStateSubscription?.cancel();
    _audioPlayer?.stop();
    _audioPlayer?.dispose();
    _audioPlayer = null;
    super.dispose();
  }

  Future<void> _loadUsers() async {
    try {
      final String response = await rootBundle.loadString('assets/BaseRestriction/dubbing_users.json');
      final List<dynamic> data = json.decode(response);
      final users = data.map((json) => DubbingUser.fromJson(json)).toList();
      final blockedUsers = await _blockedUsersService.getBlockedUsers();

      setState(() {
        _allUsers = users;
        _blockedUsers = blockedUsers;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _refreshBlockedUsers() async {
    final blockedUsers = await _blockedUsersService.getBlockedUsers();
    setState(() {
      _blockedUsers = blockedUsers;
    });
  }

  // 获取当前金币余额
  Future<int> _getCoinBalance() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('nalaniCoins') ?? prefs.getInt('nalaniDiamonds') ?? 0;
  }

  // 检查用户是否已解锁
  Future<bool> _isUserUnlocked(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final unlockedUsers = prefs.getStringList(_unlockedUsersKey) ?? [];
    return unlockedUsers.contains(userId);
  }

  // 解锁用户
  Future<bool> _unlockUser(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final unlockedUsers = prefs.getStringList(_unlockedUsersKey) ?? [];
    if (!unlockedUsers.contains(userId)) {
      unlockedUsers.add(userId);
      await prefs.setStringList(_unlockedUsersKey, unlockedUsers);
      
      // 扣除金币
      final currentBalance = await _getCoinBalance();
      await prefs.setInt('nalaniCoins', currentBalance - _unlockCost);
      return true;
    }
    return false;
  }

  // 检查并处理用户解锁
  Future<bool> _checkAndUnlockUser(DubbingUser user) async {
    // 检查是否已解锁
    final isUnlocked = await _isUserUnlocked(user.userId);
    if (isUnlocked) {
      return true; // 已解锁，直接返回true
    }

    // 获取最新余额
    final balance = await _getCoinBalance();
    
    // 检查余额是否足够
    if (balance < _unlockCost) {
      // 余额不足，显示确认对话框
      final shouldRecharge = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Insufficient Balance'),
          content: Text('Unlocking this user requires $_unlockCost coins. Your current balance is $balance coins.\nWould you like to recharge?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Recharge'),
            ),
          ],
        ),
      );

      if (shouldRecharge == true) {
        // 跳转到钱包页面
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const WalletScreen(),
          ),
        );
      }
      return false;
    }

    // 余额足够，解锁用户
    await _unlockUser(user.userId);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unlocked successfully! Spent $_unlockCost coins'),
          backgroundColor: const Color(0xFFFF9538),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
    return true;
  }

  List<DubbingUser> get _filteredUsers {
    return _allUsers
        .where((user) => user.dubbingType == _selectedCategory && !_blockedUsers.contains(user.userId))
        .toList();
  }

  Future<void> _togglePlayPause(DubbingUser user) async {
    if (_isPreparingAudio) {
      return;
    }

    try {
      final bool isCurrentUser = _playingUserId == user.userId && _audioPlayer != null;

      // 点击当前用户 -> 切换播放/暂停
      if (isCurrentUser) {
        if (_isPlaying) {
          await _audioPlayer!.pause();
          if (mounted) {
            setState(() {
              _isPlaying = false;
            });
          }
        } else {
          _audioPlayer!.play();
          if (mounted) {
            setState(() {
              _isPlaying = true;
            });
          }
        }
        return;
      }

      _isPreparingAudio = true;

      // 停止并清理当前播放器
      _playerStateSubscription?.cancel();
      _playerStateSubscription = null;
      await _audioPlayer?.stop();
      await _audioPlayer?.dispose();

      _audioPlayer = AudioPlayer();
      await _audioPlayer!.setAsset(user.workPath);

      _playerStateSubscription = _audioPlayer!.playerStateStream.listen((state) {
        if (!mounted) return;

        if (state.processingState == ProcessingState.completed) {
          setState(() {
            _playingUserId = null;
            _isPlaying = false;
          });
        }
      });

      if (mounted) {
        setState(() {
          _playingUserId = user.userId;
          _isPlaying = true;
        });
      }

      _audioPlayer!.play();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('播放失败: $e')),
        );
        setState(() {
          _playingUserId = null;
          _isPlaying = false;
        });
      }
    } finally {
      _isPreparingAudio = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            _buildCategoryCards(),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _buildUserList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              _audioPlayer?.stop();
              _audioPlayer?.dispose();
              Navigator.of(context).pop();
            },
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFFF9538),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/nalani_user_popular.webp',
                width: 179,
                height: 38,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Text(
                    'Popular dubbing',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 44),
        ],
      ),
    );
  }

  Widget _buildCategoryCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildCategoryCard(
              'Anime',
              'assets/nalani_popular_anime_pre.webp',
              isSelected: _selectedCategory == 'Anime',
              onTap: () {
                setState(() {
                  _selectedCategory = 'Anime';
                });
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildCategoryCard(
              'Game',
              'assets/nalani_popular_game_nor.webp',
              isSelected: _selectedCategory == 'Game',
              onTap: () {
                setState(() {
                  _selectedCategory = 'Game';
                });
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildCategoryCard(
              'Lines',
              'assets/nalani_popular_lines_nor.webp',
              isSelected: _selectedCategory == 'Lines',
              onTap: () {
                setState(() {
                  _selectedCategory = 'Lines';
                });
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildCategoryCard(
              'Mood',
              'assets/nalani_popular_mood_nor.webp',
              isSelected: _selectedCategory == 'Mood',
              onTap: () {
                setState(() {
                  _selectedCategory = 'Mood';
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String label, String imagePath, {required bool isSelected, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFF9538) : const Color(0xFFFFF9E6),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imagePath,
              width: 50,
              height: 50,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 50,
                  height: 50,
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.image,
                    size: 30,
                    color: Color(0xFFFF9538),
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : const Color(0xFF333333),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserList() {
    final users = _filteredUsers;
    
    if (users.isEmpty) {
      return const Center(
        child: Text(
          'No users found in this category',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF666666),
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: users.length,
      itemBuilder: (context, index) {
        return _buildUserCard(users[index], index);
      },
    );
  }

  Widget _buildUserCard(DubbingUser user, int index) {
    final isLeft = index % 2 == 0;
    final backgroundColor = isLeft 
        ? const Color(0xFFE6D5F5)  // 粉紫色
        : const Color(0xFFB3E5FC);  // 浅蓝色
    final isCurrentPlaying = _playingUserId == user.userId && _isPlaying;

    return GestureDetector(
      onTap: () async {
        // 停止当前播放
        _audioPlayer?.stop();
        setState(() {
          _playingUserId = null;
          _isPlaying = false;
        });
        
        // 检查并解锁用户
        final canAccess = await _checkAndUnlockUser(user);
        if (!canAccess) {
          return; // 无法访问，可能是余额不足或用户取消了充值
        }
        
        // 跳转到用户详情页面
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserDetailPage(user: user),
          ),
        );
        // 如果用户被拉黑，刷新列表
        if (result == true) {
          _refreshBlockedUsers();
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        height: 200,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
        children: [
          // 背景图片（可选）
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  Container(color: backgroundColor),
                  Positioned.fill(
                    child: Align(
                      alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
                      child: Image.asset(
                        isLeft ? 'assets/nalani_popular_card_left.webp' : 'assets/nalani_popular_card_right.webp',
                        width: 300,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 内容
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (isLeft) ...[
                    // 左侧：大头像
                    Expanded(
                      flex: 6,
                      child: _buildUserImage(user, isLeft, isCurrentPlaying),
                    ),
                    const SizedBox(width: 16),
                    // 右侧：信息
                    Expanded(
                      flex: 3,
                      child: _buildUserStats(user, isLeft),
                    ),
                  ] else ...[
                    // 左侧：信息
                    Expanded(
                      flex: 3,
                      child: _buildUserStats(user, isLeft),
                    ),
                    const SizedBox(width: 16),
                    // 右侧：大头像
                    Expanded(
                      flex: 6,
                      child: _buildUserImage(user, isLeft, isCurrentPlaying),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildUserImage(DubbingUser user, bool isLeft, bool isCurrentPlaying) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              user.coverPath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.person, size: 80, color: Colors.grey),
                );
              },
            ),
          ),
          // 播放按钮（左侧在左下角，右侧在右下角）
          Positioned(
            left: isLeft ? 12 : null,
            right: isLeft ? null : 12,
            bottom: 12,
            child: GestureDetector(
              onTap: () => _togglePlayPause(user),
              child: Image.asset(
                isCurrentPlaying
                    ? 'assets/nalani_community_voice_stop.webp'
                    : 'assets/nalani_community_voice_play.webp',
                width: 120,
                height: 40,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF6B9D), Color(0xFFFF9538)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isCurrentPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.graphic_eq, color: Colors.white, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          '${(user.experienceYears * 4 + 12)}"',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserStats(DubbingUser user, bool isLeft) {
    return Column(
      crossAxisAlignment: isLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 用户名
        Text(
          user.displayName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: isLeft ? TextAlign.left : TextAlign.right,
        ),
      ],
    );
  }
}
