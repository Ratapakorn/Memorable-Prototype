import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:senex/Pages/testPage.dart';
import 'package:senex/Pages/testScore.dart';
import 'package:senex/widget/navigation_drawer_widget.dart';
import 'package:senex/widget/profile_widget.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(222, 161, 67, 1.0),
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(173, 111, 5, 1.0),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: (1/30) * MediaQuery.of(context).size.height
          ),
          Row(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
              ),
              ProfileWidget(
                imagePath: Hive.box('users').get(0).imagePath,
                hasSymbol: false,
                isEdit: false,
                center: false,
                onClicked: () {
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (context) => EditProfilePage())
                  // );
                },

              ),
            ],
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: (1/30) * MediaQuery.of(context).size.height
          ),
          SizedBox(
            height: 200,
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              padding: EdgeInsets.all(8.0),
              children: [
                ElevatedButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => testPage()));
                }, child: Text("Start", style: TextStyle(fontSize: 30, fontFamily: "Robotto"),), style: ElevatedButton.styleFrom(primary: Color.fromRGBO(173, 111, 5, 0.1)),),
                ElevatedButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => testScore()));
                }, child: Text("Test Score", style: TextStyle(fontSize: 30, fontFamily: "Robotto"),), style: ElevatedButton.styleFrom(primary: Color.fromRGBO(173, 111, 5, 0.1)),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
