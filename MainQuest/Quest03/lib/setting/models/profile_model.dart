class ProfileModel {
  String? profileName;
  String? profileImage; // ✅ Null 허용
  String? gender;
  String? birthYear;
  String? birthMonth;
  String? birthDay;

  String? heightWhole;
  String? heightDecimal;
  String? weightWhole;
  String? weightDecimal;

  ProfileModel({
    this.profileName,
    this.profileImage,
    this.gender,
    this.birthYear,
    this.birthMonth,
    this.birthDay,
    this.heightWhole,
    this.heightDecimal,
    this.weightWhole,
    this.weightDecimal,
  });

  double? get height => _combineToDouble(heightWhole, heightDecimal);
  double? get weight => _combineToDouble(weightWhole, weightDecimal);

  String? get dateOfBirth => _combineToDateOfBirth(birthYear, birthMonth, birthDay);

  double? _combineToDouble(String? whole, String? decimal) {
    if ((whole == null || whole.isEmpty) && (decimal == null || decimal.isEmpty)) {
      return null;
    }
    String combined = (whole != null && whole.isNotEmpty ? whole : "0") +
        (decimal != null && decimal.isNotEmpty ? ".$decimal" : ".0");
    return double.tryParse(combined);
  }

  bool isValidYear(String? year) {
    if (year == null || year.isEmpty) return true;
    final intYear = int.tryParse(year);
    return intYear != null && intYear >= 1900 && intYear <= 2025;
  }

  bool isValidMonth(String? month) {
    if (month == null || month.isEmpty) return true;
    final intMonth = int.tryParse(month);
    return intMonth != null && intMonth >= 1 && intMonth <= 12;
  }

  String? _combineToDateOfBirth(String? year, String? month, String? day) {
    if ((year == null || year.isEmpty) || (month == null || month.isEmpty) || (day == null || day.isEmpty)) {
      return null;
    }
    return "${year}년 ${month}월 ${day}일";
  }

  /// 📌 JSON 변환 (저장 시 사용)
  Map<String, dynamic> toJson() {
    return {
      'profileName': profileName,
      'profileImage': profileImage,
      'gender': gender,
      'birthYear': birthYear,
      'birthMonth': birthMonth,
      'birthDay': birthDay,
      'heightWhole': heightWhole,
      'heightDecimal': heightDecimal,
      'weightWhole': weightWhole,
      'weightDecimal': weightDecimal,
    };
  }

  /// 📌 JSON에서 객체 변환 (불러오기 시 사용)
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      profileName: json['profileName'],
      profileImage: json['profileImage'],
      gender: json['gender'],
      birthYear: json['birthYear'],
      birthMonth: json['birthMonth'],
      birthDay: json['birthDay'],
      heightWhole: json['heightWhole'],
      heightDecimal: json['heightDecimal'],
      weightWhole: json['weightWhole'],
      weightDecimal: json['weightDecimal'],
    );
  }
}
