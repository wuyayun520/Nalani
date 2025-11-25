import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import '../models/dubbing_user.dart';
import '../services/blocked_users_service.dart';
import 'video_player_page.dart';
import 'user_chat_page.dart';

class UserDetailPage extends StatefulWidget {
  final DubbingUser user;

  const UserDetailPage({super.key, required this.user});

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  List<DubbingUser> _userWorks = [];
  bool _isLoading = true;
  bool _isBlocked = false;
  final BlockedUsersService _blockedUsersService = BlockedUsersService();

  @override
  void initState() {
    super.initState();
    _loadUserWorks();
    _checkBlockStatus();
  }

  Future<void> _checkBlockStatus() async {
    final isBlocked = await _blockedUsersService.isBlocked(widget.user.userId);
    setState(() {
      _isBlocked = isBlocked;
    });
  }

  Future<void> _toggleBlock() async {
    if (_isBlocked) {
      await _blockedUsersService.unblockUser(widget.user.userId);
      setState(() {
        _isBlocked = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User unblocked')),
        );
      }
    } else {
      await _blockedUsersService.blockUser(widget.user.userId);
      setState(() {
        _isBlocked = true;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User blocked')),
        );
        // 拉黑后返回上一页
        Navigator.of(context).pop(true);
      }
    }
  }

  void _showReportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Report User'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildReportOption('Inappropriate content'),
            _buildReportOption('Harassment'),
            _buildReportOption('False information'),
            _buildReportOption('Copyright infringement'),
            _buildReportOption('Other reasons'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Widget _buildReportOption(String reason) {
    return ListTile(
      title: Text(reason),
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Report submitted: $reason')),
        );
      },
    );
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ListTile(
              leading: Icon(
                _isBlocked ? Icons.person_add : Icons.block,
                color: _isBlocked ? Colors.green : Colors.red,
              ),
              title: Text(
                _isBlocked ? 'Unblock User' : 'Block User',
                style: TextStyle(
                  color: _isBlocked ? Colors.green : Colors.red,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                _showBlockConfirmDialog();
              },
            ),
            ListTile(
              leading: const Icon(Icons.flag, color: Colors.orange),
              title: const Text('Report User'),
              onTap: () {
                Navigator.pop(context);
                _showReportDialog();
              },
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.cancel, color: Colors.grey),
              title: const Text('Cancel'),
              onTap: () => Navigator.pop(context),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _showBlockConfirmDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(_isBlocked ? 'Unblock User' : 'Block User'),
        content: Text(
          _isBlocked
              ? 'Are you sure you want to unblock ${widget.user.displayName}?'
              : 'Are you sure you want to block ${widget.user.displayName}? You will no longer see content from this user.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _toggleBlock();
            },
            child: Text(
              'Confirm',
              style: TextStyle(
                color: _isBlocked ? Colors.green : Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _loadUserWorks() async {
    try {
      final String response = await rootBundle.loadString('assets/BaseRestriction/dubbing_users.json');
      final List<dynamic> data = json.decode(response);
      final allUsers = data.map((json) => DubbingUser.fromJson(json)).toList();
      
      // 筛选出当前用户的所有作品
      final userWorks = allUsers.where((user) => user.userId == widget.user.userId).toList();
      
      setState(() {
        _userWorks = userWorks;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9E6),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildCoverSection(context),
            _buildUserInfoSection(),
            _buildDubbingWorkSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildCoverSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Stack(
      children: [
        // 封面图片
        SizedBox(
          width: screenWidth,
          height: screenWidth * 1.1,
          child: Image.asset(
            widget.user.coverPath,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[300],
                child: const Icon(Icons.person, size: 120, color: Colors.grey),
              );
            },
          ),
        ),
        // 返回按钮
        Positioned(
          top: MediaQuery.of(context).padding.top + 10,
          left: 16,
          child: GestureDetector(
            onTap: () {
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
        ),
        // 右上角更多按钮
        Positioned(
          top: MediaQuery.of(context).padding.top + 10,
          right: 16,
          child: GestureDetector(
            onTap: _showMoreOptions,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.more_horiz,
                color: Color(0xFF333333),
                size: 24,
              ),
            ),
          ),
        ),
        // 右侧消息按钮
        Positioned(
          top: MediaQuery.of(context).padding.top + 100,
          right: 16,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserChatPage(user: widget.user),
                ),
              );
            },
            child: Image.asset(
              'assets/nalani_message.webp',
              width: 72,
              height: 72,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.message,
                    color: Color(0xFFFF9538),
                    size: 32,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserInfoSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFFFFF9E6),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      transform: Matrix4.translationValues(0, -30, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 用户头像、名称和关注按钮
          Row(
            children: [
              // 头像
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    widget.user.avatarPath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.person, color: Colors.grey),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // 用户名
              Text(
                widget.user.displayName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
             
            ],
          ),
          const SizedBox(height: 16),
          // 标签
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.user.tags.map((tag) => _buildTag(tag)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String tag) {
    // 根据标签名称选择不同颜色
    Color tagColor;
    switch (tag.toLowerCase()) {
      case 'game':
        tagColor = const Color(0xFF4CAF50);
        break;
      case 'anime otaku':
      case 'anime':
        tagColor = const Color(0xFF9C27B0);
        break;
      case 'cardio':
        tagColor = const Color(0xFFE91E63);
        break;
      case 'rising star':
        tagColor = const Color(0xFF2196F3);
        break;
      case 'comedy queen':
      case 'comedy':
        tagColor = const Color(0xFFFF9800);
        break;
      default:
        tagColor = const Color(0xFFE91E63);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: tagColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        tag,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildDubbingWorkSection() {
    return Container(
      transform: Matrix4.translationValues(0, -20, 0),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题
          const Text(
            'Dubbing work',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 16),
          // 动态列表
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _userWorks.isEmpty
                  ? const Center(
                      child: Text(
                        'No works found',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF666666),
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _userWorks.length,
                      itemBuilder: (context, index) {
                        return _buildDubbingWorkCard(_userWorks[index]);
                      },
                    ),
        ],
      ),
    );
  }

  Widget _buildDubbingWorkCard(DubbingUser work) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoPlayerPage(
              videoPath: work.videoPath,
              userDisplayName: work.displayName,
              postTitle: work.postTitle,
              userId: work.userId,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF3D0),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 用户信息行
            Row(
              children: [
                // 头像
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      work.avatarPath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.person, size: 24, color: Colors.grey),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // 用户名和时间
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        work.username,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                      ),
                      Text(
                        '19:35',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // 视频缩略图
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset(
                  work.coverPath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.video_library, size: 60, color: Colors.grey),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            // 配音内容
            Text(
              work.postContent,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF333333),
                height: 1.5,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

