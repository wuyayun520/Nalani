import 'dart:convert';
import 'package:http/http.dart' as http;

class ZhipuAIService {
  static const String _apiKey = '570661f6f47742ba92c8dc5a96588f41.LyJEq6jdXDRj2Nd0';
  static const String _baseUrl = 'https://open.bigmodel.cn/api/paas/v4/chat/completions';
  static const String _model = 'glm-4-flash';

  /// 发送消息到智谱AI并获取回复
  /// 
  /// [messages] 对话历史，格式为: [{"role": "user", "content": "..."}, ...]
  /// 返回AI的回复内容，如果出错则返回null
  Future<String?> sendMessage(List<Map<String, String>> messages) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: json.encode({
          'model': _model,
          'messages': messages,
          'temperature': 0.7,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['choices'] != null && 
            data['choices'].isNotEmpty && 
            data['choices'][0]['message'] != null) {
          return data['choices'][0]['message']['content'] as String?;
        }
      } else {
        print('ZhipuAI API Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('ZhipuAI Service Error: $e');
    }
    return null;
  }
}

