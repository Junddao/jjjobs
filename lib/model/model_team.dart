import 'dart:convert';

class ModelTeamInfo {
  String? name;
  int? type;
  ModelTeamInfo({
    this.name,
    this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
    };
  }

  factory ModelTeamInfo.fromMap(Map<String, dynamic> map) {
    return ModelTeamInfo(
      name: map['name'],
      type: map['type']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelTeamInfo.fromJson(String source) =>
      ModelTeamInfo.fromMap(json.decode(source));
}
