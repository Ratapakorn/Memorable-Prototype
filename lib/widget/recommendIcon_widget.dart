import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:senex/Pages/Reminder.dart';
import 'package:senex/Pages/test.dart';
import 'package:senex/mainMenu.dart';

class recommendIcon extends StatefulWidget {
  final String name;
  final String Description;
  final int minutes;
  final String page;
  const recommendIcon({Key? key, required this.name, required this.Description, required this.minutes, required this.page}) : super(key: key);

  @override
  _recommendIconState createState() => _recommendIconState();
}

class _recommendIconState extends State<recommendIcon> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      //style: TextButton.styleFrom(textStyle: ),
      onPressed: (){
        //Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget.page));
        switch(widget.page.toLowerCase().trim()){
          case("mainmenu"):
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => mainMenu()));
            break;
          case("test"):
            //print("hello");
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Test()));
            break;
          case("reminder"):
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Reminder()));
            break;
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Divider(color: Colors.white70,),
          // SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 5),
            child: Text(widget.name, style: TextStyle(fontFamily: "Robotto", fontSize: MediaQuery.of(context).size.height * 0.02, fontWeight: FontWeight.bold, color: Colors.white),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 5),
            child: Text("Description: " + widget.Description, style: TextStyle(fontFamily: "Robotto", fontSize: MediaQuery.of(context).size.height * 0.017, fontWeight: FontWeight.bold, color: Colors.white),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text("Approximate Time: ~ " + widget.minutes.toString() + " minutes", style: TextStyle(fontFamily: "Robotto", fontSize: MediaQuery.of(context).size.height * 0.017, fontWeight: FontWeight.bold, color: Colors.white),),
          ),
          SizedBox(height: 10,),
          Divider(color: Colors.white70,),
        ],
      ),
    );
  }
}
