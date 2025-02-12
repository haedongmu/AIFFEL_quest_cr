import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'models/profile_model.dart';
import 'widgets/profile_form.dart';

class ProfileSettingsScreen extends StatefulWidget {
  @override
  _ProfileSettingsScreenState createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  ProfileModel profile = ProfileModel();

  void _saveProfile() {
    print("프로필 정보 저장: ${profile.profileName}, ${profile.gender}, ${profile.dateOfBirth}");
  }

  void _resetSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // ✅ SharedPreferences 전체 삭제

    setState(() {
      profile = ProfileModel(); // ✅ UI 초기화
    });

    print("🔄 모든 설정 초기화 완료");
  }

  void _confirmResetSettings() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("모든 데이터 초기화"),
          content: Text("정말로 모든 설정과 프로필 정보를 초기화하시겠습니까?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // 취소
              child: Text("취소"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // 다이얼로그 닫기
                _resetSettings(); // ✅ 초기화 실행
              },
              child: Text("확인", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("개인 설정"), backgroundColor: Colors.green),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildSection(
                title: "프로필 등록",
                description: "이름, 성별, 생년월일, 키, 몸무게를 입력하세요.",
                child: ProfileForm(profile: profile, onSave: _saveProfile),
              ),
              SizedBox(height: 16),
              _buildSection(
                title: "정보 초기화",
                description: "입력한 정보를 모두 초기화합니다.",
                child: Center(
                  child: ElevatedButton(
                    onPressed: _confirmResetSettings, // ✅ 초기화 확인 다이얼로그 호출
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    ),
                    child: Text("초기화 실행", style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String description, required Widget child}) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text(description, style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
          SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}
