import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/profile_model.dart';

/// 📌 저장된 프로필 정보 확인
Future<void> checkProfileData() async {
  final prefs = await SharedPreferences.getInstance();
  final profileData = prefs.getString('profile_data');

  if (profileData != null) {
    print("✅ 저장된 프로필 정보가 있습니다: $profileData"); // ✅ 실제 저장된 데이터 출력
  } else {
    print("❌ 저장된 프로필 정보가 없습니다.");
  }
}

/// 📌 프로필 정보 저장 (SharedPreferences 사용)
Future<void> saveProfile(ProfileModel profile) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final profileData = jsonEncode(profile.toJson());
    await prefs.setString('profile_data', profileData);
    print("✅ 프로필 정보가 저장되었습니다.");

    // 📌 저장 후 즉시 불러와서 확인
    final savedData = prefs.getString('profile_data');
    if (savedData != null) {
      final loadedProfile = ProfileModel.fromJson(jsonDecode(savedData));
      print("🔄 저장된 프로필 데이터: $loadedProfile");
    } else {
      print("⚠ 저장된 데이터 없음");
    }
  } catch (e) {
    print("❌ 프로필 저장 중 오류 발생: $e");
  }
}

/// 📌 저장된 프로필 정보 불러오기
Future<ProfileModel> loadProfile() async {
  final prefs = await SharedPreferences.getInstance();
  final profileData = prefs.getString('profile_data');

  if (profileData != null) {
    return ProfileModel.fromJson(jsonDecode(profileData));
  }
  return ProfileModel(); // 기본값 반환
}

/// 📌 선택한 이미지를 앱의 내부 저장소에 영구 저장
Future<String?> saveImageToPermanentStorage(File imageFile) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final String newPath = '${directory.path}/profile_image.jpg';
    final File newImage = await imageFile.copy(newPath);
    return newImage.path;
  } catch (e) {
    print("이미지 저장 실패: $e");
    return null;
  }
}

/// 📌 프로필 사진 선택 및 저장 처리
Future<void> pickProfileImage(BuildContext context, ProfileModel profile, Function(File?) updateImage) async {
  try {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      String? savedPath = await saveImageToPermanentStorage(imageFile);

      if (savedPath != null) {
        updateImage(File(savedPath));
        profile.profileImage = savedPath;

        // ✅ 프로필 정보 저장 (await 사용 가능)
        await saveProfile(profile);
      }
    }
  } catch (e) {
    print("❌ 프로필 이미지 선택 중 오류 발생: $e");
  }
}

/// 📌 저장된 프로필 이미지 불러오기
Future<File?> loadSavedProfileImage(ProfileModel profile) async {
  final directory = await getApplicationDocumentsDirectory();
  final String savedPath = '${directory.path}/profile_image.jpg';
  File savedImage = File(savedPath);

  if (await savedImage.exists()) {
    profile.profileImage = savedPath;
    return savedImage;
  }
  return null;
}
