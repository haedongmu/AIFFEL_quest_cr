import 'package:flutter/services.dart' show rootBundle;

class ApiKeyLoader {
  static Future<String?> loadApiKey() async {
    try {
      String key = await rootBundle.loadString('api/gpt_api.txt');
      return key.trim();
    } catch (e) {
      print("❌ API 키 로드 실패: $e");
      return null;
    }
  }
}
