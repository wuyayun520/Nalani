import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

class LikesService {
  static const String _likesPrefix = 'likes_';
  static const String _selectedEmojiPrefix = 'selected_emoji_';
  static const String _initializedKey = 'likes_initialized';

  Future<void> initializeLikes(List<String> userIds) async {
    final prefs = await SharedPreferences.getInstance();
    final isInitialized = prefs.getBool(_initializedKey) ?? false;

    if (!isInitialized) {
      final random = Random();
      for (var userId in userIds) {
        for (int i = 0; i < 4; i++) {
          final randomLikes = 10 + random.nextInt(91);
          await prefs.setInt('$_likesPrefix${userId}_$i', randomLikes);
        }
      }
      await prefs.setBool(_initializedKey, true);
    } else {
      for (var userId in userIds) {
        for (int i = 0; i < 4; i++) {
          final key = '$_likesPrefix${userId}_$i';
          if (prefs.getInt(key) == null) {
            final random = Random();
            final randomLikes = 10 + random.nextInt(91);
            await prefs.setInt(key, randomLikes);
          }
        }
      }
    }
  }

  Future<int> getLikes(String userId, int emojiType) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('$_likesPrefix${userId}_$emojiType') ?? 0;
  }

  Future<void> setLikes(String userId, int emojiType, int likes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('$_likesPrefix${userId}_$emojiType', likes);
  }

  Future<int?> getSelectedEmoji(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final selected = prefs.getInt('$_selectedEmojiPrefix$userId');
    return selected;
  }

  Future<void> setSelectedEmoji(String userId, int? emojiType) async {
    final prefs = await SharedPreferences.getInstance();
    if (emojiType == null) {
      await prefs.remove('$_selectedEmojiPrefix$userId');
    } else {
      await prefs.setInt('$_selectedEmojiPrefix$userId', emojiType);
    }
  }

  Future<void> toggleEmoji(String userId, int emojiType) async {
    final currentSelected = await getSelectedEmoji(userId);
    final currentLikes = await getLikes(userId, emojiType);

    if (currentSelected == emojiType) {
      await setSelectedEmoji(userId, null);
      await setLikes(userId, emojiType, currentLikes - 1);
    } else {
      if (currentSelected != null) {
        final previousLikes = await getLikes(userId, currentSelected);
        await setLikes(userId, currentSelected, previousLikes - 1);
      }
      await setSelectedEmoji(userId, emojiType);
      await setLikes(userId, emojiType, currentLikes + 1);
    }
  }
}

