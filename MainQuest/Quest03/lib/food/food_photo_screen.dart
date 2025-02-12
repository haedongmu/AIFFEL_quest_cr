import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../common/custom_app_bar.dart';
import '../common/custom_nav_bar.dart';
import '../common/app_drawer.dart';
import 'gpt_food_analysis.dart';
import 'food_analysis_result.dart';
import 'food_diary_storage.dart';
import 'editable_food_table.dart'; // ✅ 반드시 추가!

class FoodPhotoScreen extends StatefulWidget {
  @override
  _FoodPhotoScreenState createState() => _FoodPhotoScreenState();
}

class _FoodPhotoScreenState extends State<FoodPhotoScreen> {
  File? _image;
  final picker = ImagePicker();
  List<Map<String, dynamic>> _analysisResult = [];
  bool _showRegisterButton = false;
  bool _isAnalyzing = false;
  String _analysisMessage = "";
  IconData _messageIcon = Icons.info_outline; // ✅ 메시지 아이콘 추가
  final GlobalKey<EditableFoodTableState> _tableKey = GlobalKey(); // ✅ 반드시 필요!

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _analysisResult = [];
        _showRegisterButton = false;
        _analysisMessage = "";
        _messageIcon = Icons.info_outline; // 아이콘 초기화
      });
      await _analyzeImage();
    }
  }

  Future<void> _analyzeImage() async {
    if (_image == null) return;

    setState(() {
      _isAnalyzing = true;
      _analysisMessage = "🟡 음식 분석 중...";
      _messageIcon = Icons.hourglass_empty; // 분석 중 아이콘
    });

    var analysis = await GPTFoodAnalysis.analyzeFoodImage(_image!);

    setState(() {
      _isAnalyzing = false;
      if (analysis["is_food"] == false) {
        _analysisResult = [];
        _showRegisterButton = false;
        _analysisMessage = "⚠️ 음식 사진이 아님!";
        _messageIcon = Icons.warning_amber_rounded; // ⚠️ 경고 아이콘
      } else {
        _analysisResult = List<Map<String, dynamic>>.from(analysis["foods"]);
        _showRegisterButton = true;
        _analysisMessage = "✅ 음식 분석 완료!";
        _messageIcon = Icons.check_circle_outline; // ✅ 성공 아이콘
      }
    });

    // ✅ `EditableFoodTable`이 빌드된 후 `_tableKey.currentState`가 null이 아니도록 보장
    Future.delayed(Duration.zero, () {
      if (_tableKey.currentState != null) {
        _tableKey.currentState!.updateFoods(_analysisResult);
      } else {
        print("⚠️ _tableKey.currentState가 아직 null 상태임 (재시도 필요)");
      }
    });
  }

  Future<void> _saveFoodDiary() async {
    // ✅ _tableKey.currentState가 null이면 경고 메시지를 출력하고 함수 호출 중단
    if (_tableKey.currentState == null) {
      print("⚠️ _tableKey.currentState가 null이므로 getUpdatedFoods() 호출 불가! 재시도...");
      await Future.delayed(Duration(milliseconds: 300)); // 0.3초 대기 후 다시 시도
    }

    // ✅ 다시 확인 후에도 null이면 종료
    if (_tableKey.currentState == null) {
      print("❌ _tableKey.currentState가 null 상태에서 종료됨.");
      return;
    }

    // ✅ 표 데이터를 가져옴
    List<Map<String, dynamic>> updatedFoods = _tableKey.currentState?.getUpdatedFoods() ?? [];

    print("📌 가져온 표 데이터:");
    print(updatedFoods);

    if (updatedFoods.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("⚠️ 저장할 음식 데이터가 없습니다."), duration: Duration(seconds: 2)),
      );
      return;
    }

    // ✅ 저장 함수 호출
    await FoodDiaryStorage.saveFoodDiary(updatedFoods);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("✅ 음식일기가 저장되었습니다!"), duration: Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '🍽️ 음식 촬영'),
      drawer: AppDrawer(),
      backgroundColor: Colors.grey[100], // ✅ 배경색 추가
      body: SingleChildScrollView( // ✅ SingleChildScrollView로 감싸서 세로 스크롤 가능하게 합니다.
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40), // ✅ 상단 여백 추가

            // 📸 이미지 업로드 카드
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Container(
                height: 320,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      if (_image != null)
                        Positioned.fill(
                          child: Image.file(
                            _image!,
                            height: 320,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      if (_image == null)
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.photo_camera, size: 50,
                                  color: Colors.grey),
                              SizedBox(height: 10),
                              Text(
                                '음식 사진을 촬영해주세요',
                                style: TextStyle(fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),

                      // ✅ `_image == null`일 때만 오른쪽 하단에 이미지 추가
                      if (_image == null)
                        Positioned(
                          bottom: 10, // 아래쪽 여백 조절 가능
                          right: 10,  // 오른쪽 여백 조절 가능
                          child: Image.asset(
                            'images/food/food_placeholder.png',  // 🔹 원하는 이미지 경로 입력
                            width: 60,  // 🔹 크기 조절 가능
                            height: 60, // 🔹 크기 조절 가능
                            fit: BoxFit.contain,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // 🔍 분석 메시지 카드
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(_messageIcon, color: _analysisMessage.contains("⚠️") ? Colors.red : Colors.green, size: 24),
                    SizedBox(width: 8),
                    Text(
                      _analysisMessage,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _analysisMessage.contains("⚠️") ? Colors.red : Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),

            // 📷 사진 촬영 버튼
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: Icon(Icons.camera_alt, size: 24),
              label: Text('사진 촬영'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                backgroundColor: Colors.orangeAccent,
                foregroundColor: Colors.white,
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),

            // 📝 음식일기 저장 버튼
            if (_showRegisterButton)
              ElevatedButton.icon(
                onPressed: _saveFoodDiary,
                icon: Icon(Icons.save_alt, size: 24),
                label: Text('음식일기 등록'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            SizedBox(height: 20),

            // 📌 음식 분석 결과 테이블 추가 (오직 _analysisResult가 있을 때만 표시)
            if (_analysisResult.isNotEmpty)
              EditableFoodTable(key: _tableKey, initialFoods: _analysisResult),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: 1,
        onTap: (index) {},
      ),
    );
  }
}