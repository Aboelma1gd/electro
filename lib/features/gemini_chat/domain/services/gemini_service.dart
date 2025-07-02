import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  static const String _apiKey = 'AIzaSyCJC4n-PZrv4l2k7_uNXZw7FN7x_-PtW_c';
  late final GenerativeModel _model;
  late final ChatSession _chat;

  GeminiService() {
    _model = GenerativeModel(
      model: 'models/gemini-1.5-pro-002',
      apiKey: _apiKey,
    );
    _chat = _model.startChat();
  }

  Future<String> sendMessage(String message) async {
    try {
      final response = await _chat.sendMessage(
        Content.text(message),
      );
      final responseText = response.text;
      if (responseText == null || responseText.isEmpty) {
        throw Exception('No response from Gemini API');
      }
      return responseText;
    } catch (e) {
      final errorMessage = e.toString();
      if (errorMessage.contains('quota')) {
        throw Exception('API quota exceeded. Please try again later.');
      }
      throw Exception('Error: $errorMessage');
    }
  }

  void resetChat() {
    _chat = _model.startChat();
  }
} 