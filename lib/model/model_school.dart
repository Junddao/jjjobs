import 'dart:convert';

class ModelSchoolInfo {
  String? name;
  int? grade;
  ModelSchoolInfo({
    this.name,
    this.grade,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'grade': grade,
    };
  }

  factory ModelSchoolInfo.fromMap(Map<String, dynamic> map) {
    return ModelSchoolInfo(
      name: map['name'],
      grade: map['grade']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelSchoolInfo.fromJson(String source) =>
      ModelSchoolInfo.fromMap(json.decode(source));
}
