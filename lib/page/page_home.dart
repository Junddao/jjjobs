import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:jjjob/style/textstyles.dart';

class PageHome extends StatefulWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  String? selectedValue = '0';
  var _valueList = ['0', '1', '2'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
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
            // 영어점수 입력
            LanguageScoreWidget(),
          ],
        ),
      ),
    );
  }

  SchoolWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('대학교를 선택하세요.', style: MTextStyles.bold16Black),
        SizedBox(height: 8),
        DropdownSearch<String>(
            mode: Mode.MENU,
            showSelectedItems: true,
            items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
            dropdownSearchDecoration: InputDecoration(
              hintText: '대학교를 선택하세요',
              // labelText: '대학교',
            ),
            popupItemDisabled: (String s) => s.startsWith('I'),
            onChanged: print,
            selectedItem: "Brazil"),
      ],
    );
  }

  MajorWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('전공을 선택하세요.', style: MTextStyles.bold16Black),
        SizedBox(height: 8),
        DropdownSearch<String>(
            mode: Mode.MENU,
            showSelectedItems: true,
            items: ["이과", "문과", "예체능"],
            dropdownSearchDecoration: InputDecoration(
              hintText: '전공을 선택하세요.',
              // labelText: '대학교',
            ),
            popupItemDisabled: (String s) => s.startsWith('I'),
            onChanged: print,
            selectedItem: "이과"),
      ],
    );
  }

  LanguageScoreWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('전공을 선택하세요.', style: MTextStyles.bold16Black),
        SizedBox(height: 8),
        DropdownSearch<String>(
            mode: Mode.MENU,
            showSelectedItems: true,
            items: ["최상", '상', "중", "히", '최하'],
            dropdownSearchDecoration: InputDecoration(
              hintText: '등급을 선택하세요.',
              // labelText: '대학교',
            ),
            popupItemDisabled: (String s) => s.startsWith('I'),
            onChanged: print,
            selectedItem: "최상"),
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
        Text('기타 언어(중국어 / 일본어 등)은 양심에 맞게 선택하시면 됩니다.',
            style: MTextStyles.regular10WarmGrey),
      ],
    );
  }
}
