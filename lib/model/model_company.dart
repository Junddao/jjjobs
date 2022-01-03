import 'dart:convert';

class ModelCompanyInfo {
  String? companyId;
  String? name;
  int? enScore;
  int? eduGrade;
  int? salary;
  String? contents;
  ModelCompanyInfo({
    this.companyId,
    this.name,
    this.enScore,
    this.eduGrade,
    this.salary,
    this.contents,
  });

  Map<String, dynamic> toMap() {
    return {
      'companyId': companyId,
      'name': name,
      'enScore': enScore,
      'eduGrade': eduGrade,
      'salary': salary,
      'contents': contents,
    };
  }

  factory ModelCompanyInfo.fromMap(Map<String, dynamic> map) {
    return ModelCompanyInfo(
      companyId: map['companyId'],
      name: map['name'],
      enScore: map['enScore']?.toInt(),
      eduGrade: map['eduGrade']?.toInt(),
      salary: map['salary']?.toInt(),
      contents: map['contents'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelCompanyInfo.fromJson(String source) =>
      ModelCompanyInfo.fromMap(json.decode(source));
}
