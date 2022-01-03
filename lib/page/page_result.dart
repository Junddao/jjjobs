import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.selectedSchool),
          Text(widget.selectedGrade),
          Text(widget.selectedMajor),
        ],
      ),
    );
  }
}
