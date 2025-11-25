import 'package:shared_preferences/shared_preferences.dart';

class HiddenVideosService {
  static const String _hiddenVideosKey = 'hidden_videos';

  Future<void> hideVideo(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final hiddenList = prefs.getStringList(_hiddenVideosKey) ?? [];
    if (!hiddenList.contains(userId)) {
      hiddenList.add(userId);
      await prefs.setStringList(_hiddenVideosKey, hiddenList);
    }
  }

  Future<List<String>> getHiddenVideos() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_hiddenVideosKey) ?? [];
  }

  Future<bool> isVideoHidden(String userId) async {
    final hiddenList = await getHiddenVideos();
    return hiddenList.contains(userId);
  }

  Future<void> showVideo(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final hiddenList = prefs.getStringList(_hiddenVideosKey) ?? [];
    hiddenList.remove(userId);
    await prefs.setStringList(_hiddenVideosKey, hiddenList);
  }
}

