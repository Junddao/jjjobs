import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:jjjob/model/model_company.dart';
import 'package:jjjob/model/model_school.dart';
import 'package:jjjob/model/model_team.dart';

import 'package:jjjob/provider/provider_company.dart';
import 'package:jjjob/style/textstyles.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:provider/provider.dart';

class PageResult extends StatefulWidget {
  const PageResult(
      {Key? key, this.selectedSchool, this.selectedMajor, this.selectedGrade})
      : super(key: key);

  final selectedSchool;
  final selectedGrade;
  final selectedMajor;

  @override
  _PageResultState createState() => _PageResultState();
}

class _PageResultState extends State<PageResult> {
  late Future<bool> isLoading;
  bool isVisible = true;

  int? myGrade;
  int? myEnScore;

  ModelCompanyInfo? selectedCompany;
  ModelTeamInfo? selectedTeam;

  List<ModelCompanyInfo> newComapanies = [];
  List<ModelTeamInfo> newTeams = [];

  double visibleFlag1 = 0;
  double visibleFlag2 = 0;
  double visibleFlag3 = 0;
  double visibleFlag4 = 0;

  @override
  void initState() {
    Future.microtask(() {
      // 학교 등급 가져오기
      List<ModelSchoolInfo>? schools =
          context.read<ProviderCompany>().modelSchools;
      schools.forEach((element) {
        if (element.name == widget.selectedSchool) {
          myGrade = element.grade;
        }
      });

      // 어학 점수 가져오기
      if (widget.selectedGrade == "최상")
        myEnScore = 830;
      else if (widget.selectedGrade == "상")
        myEnScore = 760;
      else if (widget.selectedGrade == "중")
        myEnScore = 730;
      else if (widget.selectedGrade == "하")
        myEnScore = 660;
      else
        myEnScore = 0;

      // 학교 등급으로 회사 1차 정리
      List<ModelCompanyInfo>? companies =
          context.read<ProviderCompany>().modelCompanys;
      companies.forEach((element) {
        if (element.enScore! <= myEnScore! && element.eduGrade! <= myGrade!) {
          newComapanies.add(element);
        }
      });

      // 가져온 리스트중 랜덤돌리기
      int companyIndex = Random().nextInt(newComapanies.length);
      selectedCompany = newComapanies[companyIndex];

      // 문과 / 이과 로 부서 리스트 가져오기
      int major = 0;
      if (widget.selectedMajor == "이과") major = 2;
      if (widget.selectedMajor == "문과") major = 1;
      List<ModelTeamInfo>? teams = context.read<ProviderCompany>().modelTeams;
      teams.forEach((element) {
        if (element.type == major || element.type == 0) {
          newTeams.add(element);
        }
      });

      // 가져온 리스트중 랜덤돌리기
      int teamIndex = Random().nextInt(newTeams.length);
      selectedTeam = newTeams[teamIndex];

      // 대학 못가고 영어 성적도 엉망이면 그냥 취준으로 박자
      if (myEnScore! <= 660 && myGrade! == 0) {
        newComapanies.forEach((element) {
          if (element.name == "취업준비중") {
            selectedCompany = element;
          }
        });
      }
    });

    isLoading = Future.delayed(Duration(seconds: 3), () {
      return false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      bottomSheet: FutureBuilder(
          initialData: true,
          future: isLoading,
          builder: (context, snapshot) {
            return snapshot.data == true
                ? SizedBox.shrink()
                : InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          'PageHome', (route) => false);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 18),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.red[500],
                        ),
                        height: 50,
                        width: double.infinity,
                        child: Center(
                          child: Text('다시하기',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                        ),
                      ),
                    ),
                  );
          }),
    );
  }

  Widget _body() {
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: FutureBuilder(
          initialData: true,
          future: isLoading,
          builder: (context, snapshot) {
            return snapshot.data == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [isVisible ? getAniText() : getAniText2()],
                    ),
                  );
          }),
    );
  }

  void getSchoolGrade() {}

  Widget getAniText() {
    if (selectedCompany!.name == '취업준비중') {
      return AnimatedTextKit(
        animatedTexts: [
          TypewriterAnimatedText(
            '당신은 ',
            textStyle: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
            speed: const Duration(milliseconds: 100),
          ),
          TypewriterAnimatedText(
            selectedCompany!.name!,
            textStyle: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
            speed: const Duration(milliseconds: 100),
          ),
          TypewriterAnimatedText(
            '${selectedCompany!.contents!}',
            textStyle: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
            speed: const Duration(milliseconds: 100),
          ),
        ],
        totalRepeatCount: 1,
        onFinished: () {
          setState(() {
            isVisible = false;
            Future.delayed(Duration(milliseconds: 500), () {
              setState(() {
                visibleFlag1 = 1;
              });
            });
            Future.delayed(Duration(milliseconds: 1000), () {
              setState(() {
                visibleFlag2 = 1;
              });
            });
            Future.delayed(Duration(milliseconds: 1500), () {
              setState(() {
                visibleFlag3 = 1;
              });
            });
            Future.delayed(Duration(milliseconds: 2000), () {
              setState(() {
                visibleFlag4 = 1;
              });
            });
          });
        },
      );
    } else {
      return AnimatedTextKit(
        animatedTexts: [
          TypewriterAnimatedText(
            '당신이 다니게 될 회사는',
            textStyle: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
            speed: const Duration(milliseconds: 80),
          ),
          TypewriterAnimatedText(
            selectedCompany!.name!,
            textStyle: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
            speed: const Duration(milliseconds: 80),
          ),
          TypewriterAnimatedText(
            '소속팀은',
            textStyle: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
            speed: const Duration(milliseconds: 80),
          ),
          TypewriterAnimatedText(
            selectedTeam!.name!,
            textStyle: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
            speed: const Duration(milliseconds: 80),
          ),
          TypewriterAnimatedText(
            '예상 초봉은',
            textStyle: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
            speed: const Duration(milliseconds: 80),
          ),
          TypewriterAnimatedText(
            '${selectedCompany!.salary!}',
            textStyle: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
            speed: const Duration(milliseconds: 80),
          ),
          TypewriterAnimatedText(
            '이 회사를 한문장으로 요약하면',
            textStyle: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
            speed: const Duration(milliseconds: 80),
          ),
          TypewriterAnimatedText(
            '${selectedCompany!.contents!}',
            textStyle: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
            speed: const Duration(milliseconds: 80),
          ),
        ],
        totalRepeatCount: 1,
        onFinished: () {
          setState(() {
            isVisible = false;
            Future.delayed(Duration(milliseconds: 500), () {
              setState(() {
                visibleFlag1 = 1;
              });
            });
            Future.delayed(Duration(milliseconds: 1000), () {
              setState(() {
                visibleFlag2 = 1;
              });
            });
            Future.delayed(Duration(milliseconds: 1500), () {
              setState(() {
                visibleFlag3 = 1;
              });
            });
            Future.delayed(Duration(milliseconds: 2000), () {
              setState(() {
                visibleFlag4 = 1;
              });
            });
          });
        },
      );
    }
  }

  Widget getAniText2() {
    if (selectedCompany!.name == '취업준비중') {
      return Column(
        children: [
          AnimatedOpacity(
            duration: Duration(seconds: 1),
            opacity: visibleFlag1,
            child: Text('${selectedCompany!.name!}',
                style: MTextStyles.bold18Black),
          ),
          SizedBox(height: 24),
          AnimatedOpacity(
            duration: Duration(seconds: 1),
            opacity: visibleFlag2,
            child: Text('${selectedCompany!.contents!}',
                style: MTextStyles.bold14Black),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          AnimatedOpacity(
            duration: Duration(seconds: 1),
            opacity: visibleFlag1,
            child: Text('${selectedCompany!.name!}',
                style: MTextStyles.bold18Black),
          ),
          SizedBox(height: 24),
          AnimatedOpacity(
            duration: Duration(seconds: 1),
            opacity: visibleFlag2,
            child:
                Text('${selectedTeam!.name!}', style: MTextStyles.bold18Black),
          ),
          SizedBox(height: 24),
          AnimatedOpacity(
            duration: Duration(seconds: 1),
            opacity: visibleFlag3,
            child: Text('${selectedCompany!.salary!}만원',
                style: MTextStyles.bold18Black),
          ),
          SizedBox(height: 48),
          AnimatedOpacity(
            duration: Duration(seconds: 1),
            opacity: visibleFlag4,
            child: Text('${selectedCompany!.contents!}',
                style: MTextStyles.bold14Black),
          ),
        ],
      );
    }
  }
}
