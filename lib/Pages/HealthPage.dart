import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:senex/Pages/gamePage.dart';
import 'package:senex/Pages/test.dart';
import 'package:senex/Pages/testPage.dart';
import 'package:senex/widget/navigation_drawer_widget.dart';
import 'package:senex/widget/profile_widget.dart';

class healthPage extends StatefulWidget {
  const healthPage({Key? key}) : super(key: key);

  @override
  _healthPageState createState() => _healthPageState();
}

class _healthPageState extends State<healthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(28, 66, 83, 1.0),
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(3, 44, 52, 1.0),
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
                  //print(DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch));
                  //Navigator.of(context).push(MaterialPageRoute(builder: (context) => testPage()));
                }, child: Icon(Icons.food_bank_outlined, size: 100), style: ElevatedButton.styleFrom(primary: Color.fromRGBO( //Text("Food", style: TextStyle(fontSize: 30, fontFamily: "Robotto"),)
                    182, 113, 8, 0.5)),),
                ElevatedButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Test()));
                }, child: Icon(Icons.paste, size: 100), style: ElevatedButton.styleFrom(primary: Color.fromRGBO(173, 111, 5, 0.5)),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
