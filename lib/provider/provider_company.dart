import 'package:flutter/cupertino.dart';
import 'package:jjjob/model/model_company.dart';
import 'package:jjjob/model/model_school.dart';
import 'package:jjjob/model/model_team.dart';

class ProviderCompany extends ChangeNotifier {
  List<ModelCompanyInfo> modelCompanys = [];
  List<ModelTeamInfo> modelTeams = [];
  List<ModelSchoolInfo> modelSchools = [];

  getModelCompany(Map<String, dynamic> json) {
    final companyInfos = List.from(json['companies']);
    companyInfos.forEach((element) {
      ModelCompanyInfo modelCompanyInfo = ModelCompanyInfo();
      modelCompanyInfo.name = element['name'];
      modelCompanyInfo.enScore = element['enScore'];
      modelCompanyInfo.eduGrade = element['eduGrade'];
      modelCompanyInfo.salary = element['salary'];
      modelCompanyInfo.contents = element['contents'];
      modelCompanys.add(modelCompanyInfo);
    });
  }

  getModelTeam(Map<String, dynamic> json) {
    final teamInfos = List.from(json['teams']);
    teamInfos.forEach((element) {
      ModelTeamInfo modelTeamInfo = ModelTeamInfo();
      modelTeamInfo.name = element['name'];
      modelTeamInfo.type = element['type'];

      modelTeams.add(modelTeamInfo);
    });
  }

  getModelSchool(Map<String, dynamic> json) {
    final schoolInfos = List.from(json['schools']);
    schoolInfos.forEach((element) {
      ModelSchoolInfo modelSchoolInfo = ModelSchoolInfo();
      modelSchoolInfo.name = element['name'];
      modelSchoolInfo.grade = element['grade'];

      modelSchools.add(modelSchoolInfo);
    });
  }
}
