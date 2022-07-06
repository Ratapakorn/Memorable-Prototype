import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:senex/widget/navigation_drawer_widget.dart';

class testScore extends StatefulWidget {
  const testScore({Key? key}) : super(key: key);

  @override
  _testScoreState createState() => _testScoreState();
}

class _testScoreState extends State<testScore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(222, 161, 67, 1.0),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(173, 111, 5, 1.0),
      ),
      // body: ,
    );
  }
}
