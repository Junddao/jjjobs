import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jjjob/page_home.dart';

class PageSplash extends StatefulWidget {
  const PageSplash({Key? key}) : super(key: key);

  @override
  _PageSplashState createState() => _PageSplashState();
}

class _PageSplashState extends State<PageSplash> {
  @override
  void initState() {
    Future.microtask(() async {
      await Future.delayed(Duration(milliseconds: 2000), () {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('PageHome', (route) => false);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/choice.svg',
                width: MediaQuery.of(context).size.width * 0.5,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 50),
              Text('AI 미래 직장 분석',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
