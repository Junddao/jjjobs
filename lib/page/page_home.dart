import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jjjob/model/model_company.dart';
import 'package:jjjob/model/model_school.dart';
import 'package:jjjob/model/model_team.dart';
import 'package:jjjob/page/page_result.dart';
import 'package:jjjob/provider/provider_company.dart';
import 'package:jjjob/style/textstyles.dart';
import 'package:jjjob/util/admob_service.dart';
import 'package:provider/provider.dart';

class PageHome extends StatefulWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  String? selectedSchool = '서울대';
  String? selectedMajor = '이과';
  String? selectedGrade = '최상';
  bool isLoading = false;

  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  int maxFailedLoadAttempts = 3;

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('11111111');
        ad.dispose();
        _createInterstitialAd();
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => PageResult(
                    selectedSchool: selectedSchool,
                    selectedGrade: selectedGrade,
                    selectedMajor: selectedMajor,
                  )),
        );
        isLoading = false;
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('22222222');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdShowedFullScreenContent: (InterstitialAd ad) => print('333333333'),
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  void _createInterstitialAd() {
    String adId = AdMobService().getInterstitialAdId()!;
    // String adId = 'ca-app-pub-3940256099942544/1033173712';
    InterstitialAd.load(
        adUnitId: adId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
              _createInterstitialAd();
            }
          },
        ));
  }

  @override
  void initState() {
    _createInterstitialAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: isLoading == true ? CircularProgressIndicator() : _body(),
      bottomSheet: isLoading == true
          ? SizedBox.shrink()
          : InkWell(
              onTap: () {
                _showInterstitialAd();
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.red[500],
                  ),
                  height: 50,
                  width: double.infinity,
                  child: Center(
                    child: Text('나의 미래 직장은??',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                  ),
                ),
              ),
            ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text('선택창'),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Column(
          children: [
            // 학교 입력
            SchoolWidget(),
            SizedBox(height: 16),
            // 이과 / 문과
            MajorWidget(),
            SizedBox(height: 16),
            // 영어점수 입력
            LanguageScoreWidget(),
          ],
        ),
      ),
    );
  }

  SchoolWidget() {
    List<String> schools = [];
    List<ModelSchoolInfo> modelSchoolInfo =
        context.read<ProviderCompany>().modelSchools;
    modelSchoolInfo.forEach((element) {
      schools.add(element.name!);
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('지금 혹은 미래의 나의 대학교는?.', style: MTextStyles.bold16Black),
        SizedBox(height: 8),
        DropdownSearch<String>(
            mode: Mode.MENU,
            showSelectedItems: true,
            items: schools,
            dropdownSearchDecoration: InputDecoration(
              hintText: '대학교를 선택하세요',
              // labelText: '대학교',
            ),
            onChanged: (value) {
              selectedSchool = value;
            },
            selectedItem: selectedSchool),
      ],
    );
  }

  MajorWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('이과? 문과? 예체능?.', style: MTextStyles.bold16Black),
        SizedBox(height: 8),
        DropdownSearch<String>(
            mode: Mode.MENU,
            showSelectedItems: true,
            items: ["이과", "문과", "예체능"],
            dropdownSearchDecoration: InputDecoration(
              hintText: '전공을 선택하세요.',
              // labelText: '대학교',
            ),
            onChanged: (value) {
              selectedMajor = value;
            },
            selectedItem: selectedMajor),
      ],
    );
  }

  LanguageScoreWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('지금 혹은 미래의 어학 등급은?', style: MTextStyles.bold16Black),
        SizedBox(height: 8),
        DropdownSearch<String>(
            mode: Mode.MENU,
            showSelectedItems: true,
            items: ["최상", '상', "중", "히", '점수없음'],
            dropdownSearchDecoration: InputDecoration(
              hintText: '등급을 선택하세요.',
              // labelText: '대학교',
            ),
            popupItemDisabled: (String s) => s.startsWith('I'),
            onChanged: (value) {
              selectedGrade = value;
            },
            selectedItem: selectedGrade),
        SizedBox(height: 8),
        Text('TOEIC', style: MTextStyles.regular12WarmGrey),
        Text('최상(830이상) / 상(780이상) / 중(730이상) / 하(660이상) / 최하(660미만)',
            style: MTextStyles.regular10WarmGrey),
        SizedBox(height: 8),
        Text('OPIC', style: MTextStyles.regular12WarmGrey),
        Text('최상(AL이상) / 상(IM3이상) / 중(IM2이상) / 하(IM1이상) / 최하(IM1미만)',
            style: MTextStyles.regular10WarmGrey),
        SizedBox(height: 8),
        Text('TOEIC SPEAKING', style: MTextStyles.regular12WarmGrey),
        Text('최상(170이상) / 상(150이상) / 중(130이상) / 하(100이상) / 최하(100미만)',
            style: MTextStyles.regular10WarmGrey),
        SizedBox(height: 8),
        Text('* 기타 언어(중국어 / 일본어 등)은 양심에 맞게 선택하시면 됩니다.',
            style: MTextStyles.regular10WarmGrey),
      ],
    );
  }
}
