import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FoodDiaryStorage {
  static const String _key = "food_diary";

  /// 📌 음식일기 저장
  static Future<void> saveFoodDiary(List<Map<String, dynamic>> foods) async {
    final prefs = await SharedPreferences.getInstance();

    // ✅ 현재 날짜 및 시간 기반 ID 생성
    DateTime now = DateTime.now();
    String id = "${now.year}${_twoDigits(now.month)}${_twoDigits(now.day)}_${_twoDigits(now.hour)}${_twoDigits(now.minute)}${_twoDigits(now.second)}";
    String date = "${now.year}-${_twoDigits(now.month)}-${_twoDigits(now.day)}";
    String time = "${_twoDigits(now.hour)}:${_twoDigits(now.minute)}:${_twoDigits(now.second)}";

    // ✅ 새로운 일기 객체 생성
    Map<String, dynamic> newDiary = {
      "id": id,
      "date": date,
      "time": time,
      "foods": foods
    };

    // ✅ 기존 저장된 데이터 불러오기
    String? storedData = prefs.getString(_key);
    List<dynamic> diaryList = storedData != null ? jsonDecode(storedData) : [];

    // ✅ 새 데이터 추가
    diaryList.add(newDiary);

    print(newDiary);

    // ✅ SharedPreferences에 다시 저장
    await prefs.setString(_key, jsonEncode(diaryList));
  }

  /// 📌 저장된 음식일기 불러오기
  static Future<List<Map<String, dynamic>>> loadFoodDiary() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedData = prefs.getString(_key);
    if (storedData != null) {
      List<dynamic> diaryList = jsonDecode(storedData);
      return diaryList.cast<Map<String, dynamic>>();
    }
    return [];
  }

  /// 📌 숫자를 2자리로 변환 (01, 02 등)
  static String _twoDigits(int n) {
    return n.toString().padLeft(2, '0');
  }
}
