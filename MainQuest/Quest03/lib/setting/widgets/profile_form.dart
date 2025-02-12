import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // JSON 파싱을 위해 필요
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart'; // 이미지 선택 기능 추가
import '../models/profile_model.dart';
import '../actions/profile_actions.dart'; // 👈 버튼 액션 로직 불러오기

class ProfileForm extends StatefulWidget {
  final ProfileModel profile;
  final VoidCallback onSave;

  ProfileForm({required this.profile, required this.onSave});

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  File? _profileImage; // 선택한 프로필 이미지
  late TextEditingController _nameController;
  late TextEditingController _yearController;
  late TextEditingController _monthController;
  late TextEditingController _dayController;
  late TextEditingController _heightWholeController;
  late TextEditingController _heightDecimalController;
  late TextEditingController _weightWholeController;
  late TextEditingController _weightDecimalController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _yearController = TextEditingController();
    _monthController = TextEditingController();
    _dayController = TextEditingController();
    _heightWholeController = TextEditingController();
    _heightDecimalController = TextEditingController();
    _weightWholeController = TextEditingController();
    _weightDecimalController = TextEditingController();

    checkProfileData(); // ✅ 저장된 정보 확인
    _loadSavedProfileImage(); // ✅ 저장된 프로필 이미지 불러오기
    _loadSavedProfileData(); // ✅ 저장된 프로필 불러오기
  }

  @override
  void dispose() {
    _nameController.dispose(); // 🔹 메모리 해제
    _yearController.dispose();
    _monthController.dispose();
    _dayController.dispose();
    _heightWholeController.dispose();
    _heightDecimalController.dispose();
    _weightWholeController.dispose();
    _weightDecimalController.dispose();
    super.dispose();
  }

  /// 📌 저장된 프로필 이미지 불러오기
  Future<void> _loadSavedProfileImage() async {
    File? savedImage = await loadSavedProfileImage(widget.profile);
    if (savedImage != null) {
      setState(() {
        _profileImage = savedImage;
      });
    }
  }

  /// 📌 저장된 프로필 정보 불러오기 (이름 + 성별 포함)
  Future<void> _loadSavedProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    final savedData = prefs.getString('profile_data');
    if (savedData != null) {
      final loadedProfile = ProfileModel.fromJson(jsonDecode(savedData));
      setState(() {
        widget.profile.profileName = loadedProfile.profileName;
        _nameController.text = loadedProfile.profileName ?? ""; // ✅ 이름 적용
        widget.profile.gender = loadedProfile.gender; // ✅ 성별 적용
        widget.profile.birthYear = loadedProfile.birthYear;
        widget.profile.birthMonth = loadedProfile.birthMonth;
        widget.profile.birthDay = loadedProfile.birthDay;
        widget.profile.heightWhole = loadedProfile.heightWhole;
        widget.profile.heightDecimal = loadedProfile.heightDecimal;
        widget.profile.weightWhole = loadedProfile.weightWhole;
        widget.profile.weightDecimal = loadedProfile.weightDecimal;
        widget.profile.profileImage = loadedProfile.profileImage; // ✅ 프로필 이미지 경로 추가

        _nameController.text = loadedProfile.profileName ?? "";
        _yearController.text = loadedProfile.birthYear ?? "";
        _monthController.text = loadedProfile.birthMonth ?? "";
        _dayController.text = loadedProfile.birthDay ?? "";
        _heightWholeController.text = loadedProfile.heightWhole ?? "";
        _heightDecimalController.text = loadedProfile.heightDecimal ?? "";
        _weightWholeController.text = loadedProfile.weightWhole ?? "";
        _weightDecimalController.text = loadedProfile.weightDecimal ?? "";

        // ✅ 프로필 이미지 파일 적용
        if (loadedProfile.profileImage != null && loadedProfile.profileImage!.isNotEmpty) {
          _profileImage = File(loadedProfile.profileImage!);
        }
      });
    }
  }

  /// 📌 프로필 사진 선택 함수
  Future<void> _pickProfileImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
        widget.profile.profileImage = _profileImage?.path; // 모델에 이미지 경로 저장
      });
    }
  }

  /// 📌 프로필 정보 저장 함수
  void _saveProfile() async {
    print("📌 저장된 프로필 정보:");
    print("이름: ${widget.profile.profileName}");
    print("성별: ${widget.profile.gender}");
    print("생년월일: ${widget.profile.birthYear}-${widget.profile.birthMonth}-${widget.profile.birthDay}");
    print("키: ${widget.profile.heightWhole}.${widget.profile.heightDecimal} cm");
    print("몸무게: ${widget.profile.weightWhole}.${widget.profile.weightDecimal} kg");
    print("프로필 이미지 경로: ${widget.profile.profileImage ?? '없음'}");

    try {
      await saveProfile(widget.profile);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("프로필 정보가 저장되었습니다!")),
      );
    } catch (e) {
      print("❌ 프로필 저장 실패: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("프로필 저장 중 오류가 발생했습니다.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildProfileImagePicker(),
        SizedBox(height: 16),
        _buildTextField("이름 입력", _nameController),
        SizedBox(height: 16),
        _buildGenderSelection(),
        SizedBox(height: 16),
        _buildDateOfBirthInput(),
        SizedBox(height: 16),
        _buildHeightWeightInput(
          label: "키 (cm)",
          wholeController: _heightWholeController, // 🔹 기존 wholeValue → 컨트롤러로 변경
          decimalController: _heightDecimalController, // 🔹 기존 decimalValue → 컨트롤러로 변경
          onWholeChanged: (value) => widget.profile.heightWhole = value,
          onDecimalChanged: (value) => widget.profile.heightDecimal = value,
        ),
        SizedBox(height: 16),
        _buildHeightWeightInput(
          label: "몸무게 (kg)",
          wholeController: _weightWholeController, // 🔹 기존 wholeValue → 컨트롤러로 변경
          decimalController: _weightDecimalController, // 🔹 기존 decimalValue → 컨트롤러로 변경
          onWholeChanged: (value) => widget.profile.weightWhole = value,
          onDecimalChanged: (value) => widget.profile.weightDecimal = value,
        ),
        SizedBox(height: 24),
        ElevatedButton(
          onPressed: _saveProfile, // ✅ 저장 기능 추가
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          ),
          child: Text("프로필 정보 저장", style: TextStyle(fontSize: 16, color: Colors.white)),
        ),
      ],
    );
  }

  /// 📌 프로필 사진 등록 UI
  Widget _buildProfileImagePicker() {
    return GestureDetector(
      onTap: _pickProfileImage, // 클릭 시 이미지 선택
      child: CircleAvatar(
        radius: 50,
        backgroundImage: _profileImage != null
            ? FileImage(_profileImage!) // 선택한 이미지 표시
            : AssetImage('images/profile_placeholder.png') as ImageProvider, // 기본 이미지
        child: _profileImage == null
            ? Icon(Icons.camera_alt, size: 40, color: Colors.white)
            : null,
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller, // 🔹 컨트롤러 적용
      decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
      onChanged: (value) {
        widget.profile.profileName = value; // 🔹 입력값 변경 시 ProfileModel 업데이트
      },
    );
  }

  Widget _buildGenderSelection() {
    return Row(
      children: <Widget>[
        Text('성별 선택: '),
        Radio<String>(
          value: '남성',
          groupValue: widget.profile.gender,
          onChanged: (value) => setState(() => widget.profile.gender = value),
        ),
        Text('남성'),
        Radio<String>(
          value: '여성',
          groupValue: widget.profile.gender,
          onChanged: (value) => setState(() => widget.profile.gender = value),
        ),
        Text('여성'),
      ],
    );
  }

  Widget _buildDateOfBirthInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _yearController, // ✅ 컨트롤러 적용
            decoration: InputDecoration(
              labelText: '년 (YYYY)',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number, // 숫자 키패드 사용
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly // 숫자만 입력 가능
            ],
            maxLength: 4, // 4자리 숫자로 제한
            onChanged: (value) => setState(() => widget.profile.birthYear = value),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: TextField(
            controller: _monthController, // ✅ 컨트롤러 적용
            decoration: InputDecoration(
              labelText: '월 (MM)',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number, // 숫자 키패드 사용
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly // 숫자만 입력 가능
            ],
            maxLength: 2, // 2자리 숫자로 제한
            onChanged: (value) => setState(() => widget.profile.birthMonth = value),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: GestureDetector(
            onTap: () => _showDatePickerForDay(context), // "일" 클릭 시 캘린더 실행
            child: AbsorbPointer(
              child: TextField(
                decoration: InputDecoration(
                  labelText: '일 (DD)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number, // 숫자 키패드 사용
                inputFormatters: [FilteringTextInputFormatter.digitsOnly], // 숫자만 입력 가능
                maxLength: 2, // 2자리 숫자로 제한
                controller: TextEditingController(text: widget.profile.birthDay),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showDatePickerForDay(BuildContext context) async {
    int? year = int.tryParse(widget.profile.birthYear ?? '');
    int? month = int.tryParse(widget.profile.birthMonth ?? '');

    if (year == null || month == null || month < 1 || month > 12) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('올바른 연도와 월을 입력하세요.')),
      );
      return;
    }

    DateTime firstDate = DateTime(year, month, 1);
    DateTime lastDate = DateTime(year, month + 1, 0); // 해당 월의 마지막 날짜

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: firstDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null) {
      setState(() {
        widget.profile.birthDay = pickedDate.day.toString().padLeft(2, '0');
      });
    }
  }

  /// 📌 키 & 몸무게 입력 필드 (정수 + 소수점 입력)
  Widget _buildHeightWeightInput({
    required String label,
    required TextEditingController wholeController,
    required TextEditingController decimalController,
    required ValueChanged<String> onWholeChanged,
    required ValueChanged<String> onDecimalChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: wholeController, // ✅ 컨트롤러 적용
                decoration: InputDecoration(border: OutlineInputBorder(), hintText: '정수'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textAlign: TextAlign.center,
                maxLength: 3,
                onChanged: onWholeChanged,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('.', style: TextStyle(fontSize: 24)),
            ),
            SizedBox(
              width: 60,
              child: TextField(
                controller: decimalController, // ✅ 컨트롤러 적용
                decoration: InputDecoration(border: OutlineInputBorder(), hintText: '소수'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textAlign: TextAlign.center,
                maxLength: 2,
                onChanged: onDecimalChanged,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
