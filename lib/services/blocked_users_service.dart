import 'package:shared_preferences/shared_preferences.dart';

class BlockedUsersService {
  static const String _blockedUsersKey = 'blocked_users';

  // 获取所有被拉黑的用户ID
  Future<List<String>> getBlockedUsers() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_blockedUsersKey) ?? [];
  }

  // 拉黑用户
  Future<void> blockUser(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final blockedUsers = prefs.getStringList(_blockedUsersKey) ?? [];
    if (!blockedUsers.contains(userId)) {
      blockedUsers.add(userId);
      await prefs.setStringList(_blockedUsersKey, blockedUsers);
    }
  }

  // 取消拉黑用户
  Future<void> unblockUser(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final blockedUsers = prefs.getStringList(_blockedUsersKey) ?? [];
    blockedUsers.remove(userId);
    await prefs.setStringList(_blockedUsersKey, blockedUsers);
  }

  // 检查用户是否被拉黑
  Future<bool> isBlocked(String userId) async {
    final blockedUsers = await getBlockedUsers();
    return blockedUsers.contains(userId);
  }
}

