import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

class UserProfileService {
  static const String _nameKey = 'user_name';
  static const String _ageKey = 'user_age';
  static const String _avatarKey = 'user_avatar';
  static const String _avatarFileName = 'profile_avatar.jpg';
  static const String _voiceTagsKey = 'voice_tags';

  // 可选的声音标签列表
  static const List<String> availableVoiceTags = [
    'Protagonist',
    'Deep&powerful',
    'Soft&gentle',
    'Energetic',
    'Mysterious',
    'Warm',
    'Cool',
    'Playful',
    'Mature',
    'Youthful',
    'Narrator',
    'Villain',
    'Hero',
    'Romantic',
    'Comedy',
  ];

  // 获取用户名
  Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_nameKey) ?? 'Julie';
  }

  // 保存用户名
  Future<void> saveUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nameKey, name);
  }

  // 获取年龄
  Future<int> getUserAge() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_ageKey) ?? 26;
  }

  // 保存年龄
  Future<void> saveUserAge(int age) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_ageKey, age);
  }

  // 获取头像路径
  Future<String?> getAvatarPath() async {
    final prefs = await SharedPreferences.getInstance();
    final hasCustomAvatar = prefs.getBool(_avatarKey) ?? false;
    
    if (hasCustomAvatar) {
      final directory = await getApplicationDocumentsDirectory();
      final avatarPath = '${directory.path}/$_avatarFileName';
      if (await File(avatarPath).exists()) {
        return avatarPath;
      }
    }
    return null;
  }

  // 保存头像
  Future<String> saveAvatar(File imageFile) async {
    final directory = await getApplicationDocumentsDirectory();
    final avatarPath = '${directory.path}/$_avatarFileName';
    
    // 复制图片到沙盒目录
    await imageFile.copy(avatarPath);
    
    // 标记已有自定义头像
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_avatarKey, true);
    
    return avatarPath;
  }

  // 获取沙盒目录路径
  Future<String> getSandboxPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // 获取声音标签
  Future<List<String>> getVoiceTags() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_voiceTagsKey) ?? ['Protagonist', 'Deep&powerful'];
  }

  // 保存声音标签
  Future<void> saveVoiceTags(List<String> tags) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_voiceTagsKey, tags);
  }
}

