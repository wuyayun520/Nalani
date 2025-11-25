import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

class ChatMessage {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final String type; // 'text' or 'image'
  final DateTime timestamp;
  final bool isSentByMe;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.type,
    required this.timestamp,
    required this.isSentByMe,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'content': content,
      'type': type,
      'timestamp': timestamp.toIso8601String(),
      'isSentByMe': isSentByMe,
    };
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] as String,
      senderId: json['senderId'] as String,
      receiverId: json['receiverId'] as String,
      content: json['content'] as String,
      type: json['type'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isSentByMe: json['isSentByMe'] as bool,
    );
  }
}

class ChatService {
  static const String _messagesKeyPrefix = 'chat_messages_';

  // 获取聊天消息
  Future<List<ChatMessage>> getMessages(String chatId) async {
    final prefs = await SharedPreferences.getInstance();
    final String? messagesJson = prefs.getString('$_messagesKeyPrefix$chatId');
    
    if (messagesJson == null) {
      return [];
    }

    final List<dynamic> messagesList = json.decode(messagesJson);
    return messagesList.map((json) => ChatMessage.fromJson(json)).toList();
  }

  // 保存消息
  Future<void> saveMessage(String chatId, ChatMessage message) async {
    final messages = await getMessages(chatId);
    messages.add(message);
    
    final prefs = await SharedPreferences.getInstance();
    final messagesJson = json.encode(messages.map((m) => m.toJson()).toList());
    await prefs.setString('$_messagesKeyPrefix$chatId', messagesJson);
  }

  // 保存图片到本地并返回路径
  Future<String> saveImage(File imageFile) async {
    final directory = await getApplicationDocumentsDirectory();
    final imagesDir = Directory('${directory.path}/chat_images');
    
    if (!await imagesDir.exists()) {
      await imagesDir.create(recursive: true);
    }
    
    final fileName = 'img_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final savedImage = await imageFile.copy('${imagesDir.path}/$fileName');
    
    return savedImage.path;
  }

  // 生成唯一消息ID
  String generateMessageId() {
    return 'msg_${DateTime.now().millisecondsSinceEpoch}';
  }

  // 生成聊天ID
  String generateChatId(String myId, String otherUserId) {
    final ids = [myId, otherUserId]..sort();
    return '${ids[0]}_${ids[1]}';
  }
}

