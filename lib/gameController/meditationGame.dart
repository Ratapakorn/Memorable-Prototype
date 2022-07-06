import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class meditationGame extends StatefulWidget {
  const meditationGame({Key? key}) : super(key: key);

  @override
  State<meditationGame> createState() => _meditationGameState();
}

class _meditationGameState extends State<meditationGame> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _showDialog();
  }

  _showDialog() async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(context: context, builder: (BuildContext cxt){
      return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                20.0,
              ),
            ),
          ),
          contentPadding: EdgeInsets.only(
            top: 0.0,
          ),
          title: Text("Select Duration"),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.10,
            width: 50,
            child: GridView.count(crossAxisCount: 2, children: [
              TextButton(onPressed: () async {
                Navigator.pop(context);
              }, child: Align(alignment: Alignment.topCenter,child: Text('yes', style: TextStyle(fontFamily: "Robotto", fontSize: MediaQuery.of(context).size.height * 0.05, color: Colors.white),)),),
              TextButton(onPressed: () async {
                Navigator.pop(context);
              }, child: Align(alignment: Alignment.topCenter, child: Text('no', style: TextStyle(fontFamily: "Robotto" , fontSize: MediaQuery.of(context).size.height * 0.05, color: Colors.white ),)),),
            ],),
          )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }


}
