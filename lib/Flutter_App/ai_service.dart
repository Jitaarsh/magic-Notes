import 'package:google_generative_ai/google_generative_ai.dart';

class AIService {
 
  static const _apiKey = 'AIzaSyDTxZTAr39tP69BMzUM_nKCwvi_NuLB0RU'; 

  final _model = GenerativeModel(
    model: "gemini-3-flash-preview", 
    apiKey: _apiKey,
  );

  Future<String> summarize(String content) async {
    if (content.isEmpty) return "No content provided.";
  
    try {
      final prompt = "Summarize the following note concisely in one short sentence: $content";
      final response = await _model.generateContent([Content.text(prompt)]);
      return response.text ?? "Summary generation failed.";
    } catch (e) {
      return "AI Error: $e";
    }
  }
}