import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:senex/gameController/meditationGame.dart';
import 'package:senex/widget/navigation_drawer_widget.dart';

import '../gameController/memoryGame1/memoryGameFirst.dart';

class gamePage extends StatefulWidget {
  const gamePage({Key? key}) : super(key: key);

  @override
  _gamePageState createState() => _gamePageState();
}

class _gamePageState extends State<gamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(2, 3, 5, 1),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Brain Exercises",
                  style: TextStyle(fontFamily: "Robotto", fontSize: MediaQuery.of(context).size.height * 0.04),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text("Memory Games", style: TextStyle(fontFamily: "Robotto", fontSize: MediaQuery.of(context).size.height * 0.03),),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => memG1()));
                  }, child: Icon(Icons.square, size: 65, color: Colors.white,), //style: TextButton.styleFrom(),),
            ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => meditationGame()));
                  }, child: Icon(Icons.timer, size: 65, color: Colors.white), //style: TextButton.styleFrom(),),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
