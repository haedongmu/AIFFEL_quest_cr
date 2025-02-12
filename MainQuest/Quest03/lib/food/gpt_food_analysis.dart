import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api/api_key_loader.dart'; // ✅ API 키 로드

class GPTFoodAnalysis {
  static Future<Map<String, dynamic>> analyzeFoodImage(File imageFile) async {
    String? apiKey = await ApiKeyLoader.loadApiKey();
    if (apiKey == null || apiKey.isEmpty) {
      print("🚨 [ERROR] API 키가 비어 있습니다!");
      return {"error": "API 키 오류"};
    }

    final uri = Uri.parse("https://api.openai.com/v1/chat/completions");
    final request = http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "model": "gpt-4-turbo",
        "messages": [
          {
            "role": "system",
            "content": "이미지를 분석하여 음식 종류, 정수 개수, 칼로리를 반환하세요.\n"
                "수량이 애매한 경우 1을 반환하세요.\n"
                "음식이 아닐 경우 '이 이미지는 음식이 아닙니다.'라고 응답하세요.\n"
                "응답 형식:\n"
                "[1][음식명][정수 개수][정수 칼로리]\n"
                "[2][음식명][정수 개수][정수 칼로리]\n"
                "예시:\n"
                "[1][달걀][2][155]\n"
                "[2][카레 튀김][1][150]"
          },
          {
            "role": "user",
            "content": [
              {"type": "text", "text": "이 이미지가 음식인지 판단하고, 음식이면 종류와 칼로리를 제공하세요."},
              {
                "type": "image_url",
                "image_url": {"url": "data:image/jpeg;base64," + base64Encode(imageFile.readAsBytesSync())}
              }
            ]
          }
        ],
        "max_tokens": 150
      }),
    );

    final response = await request;

    try {
      final responseData = json.decode(utf8.decode(response.bodyBytes));
      print("✅ [GPT 응답] ${json.encode(responseData)}");

      if (response.statusCode == 200) {
        String result = responseData['choices'][0]['message']['content'];
        print("🟢 [GPT 분석 결과 Raw] $result");

        // ✅ 음식 사진이 아닐 경우 처리
        if (result.contains("음식이 아닙니다") || result.contains("음식 관련 정보를 제공할 수 없습니다")) {
          print("⚠️ 음식 사진이 아님!");
          return {
            "is_food": false,
            "message": "음식 사진이 아닙니다.",
          };
        }

        // ✅ 정규 표현식으로 음식 정보 추출
        RegExp regex = RegExp(r"\[(\d+)\]\[(.*?)\]\[(\d+)\]\[(\d+)\]");
        Iterable<Match> matches = regex.allMatches(result);

        if (matches.isEmpty) {
          print("🚨 [ERROR] GPT 응답 형식 오류");
          return {
            "is_food": false,
            "message": "음식 정보를 찾을 수 없습니다.",
          };
        }

        List<Map<String, dynamic>> foodList = [];

        for (Match match in matches) {
          String foodName = match.group(2)?.trim() ?? "알 수 없음";
          int quantity = int.tryParse(match.group(3) ?? "1") ?? 1;
          int calories = int.tryParse(match.group(4) ?? "0") ?? 0;

          print("✅ 추출된 음식: $foodName");
          print("✅ 추출된 개수: $quantity 개");
          print("✅ 추출된 칼로리: $calories kcal");

          foodList.add({
            "food_type": foodName,
            "quantity": quantity,
            "calories": calories,
          });
        }

        return {
          "is_food": true,
          "foods": foodList, // ✅ 복수의 음식 리스트 반환
        };
      } else {
        print("🚨 [ERROR] 분석 실패 - 상태 코드: ${response.statusCode}");
        print("❌ [응답 내용] ${json.encode(responseData)}");
        return {"error": "분석 실패"};
      }
    } catch (e) {
      print("🚨 [ERROR] JSON 디코딩 실패: $e");
      return {"error": "디코딩 오류"};
    }
  }
}
