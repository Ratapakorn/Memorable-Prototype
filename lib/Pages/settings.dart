import 'package:flutter/material.dart';
import 'package:senex/main.dart';
import 'package:senex/widget/navigation_drawer_widget.dart';
//import 'package:cupertino_setting_control/cupertino_setting_control.dart';
import 'package:senex/mainMenu.dart';
import 'package:flutter/cupertino.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        backgroundColor: Colors.black26,
        //title: Text("Settings"),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: const Color.fromRGBO(154, 205, 50, 1),
          ),
          Column(


          ),

          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     SizedBox(height: (1/20) * MediaQuery.of(context).size.height,),
          //     Center( child: Text("Settings", style: TextStyle(color: Colors.white, fontSize: 30, fontFamily: "DreamOrphans"),)),
          //     Text("  ACCOUNT", style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: "DreamOrphans")),
          //     SizedBox(height: (1/20) * MediaQuery.of(context).size.height,),
          //
          //     Text("  SOUNDS & NOTIFICATION", style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: "DreamOrphans")),
          //     SizedBox(height: (1/20) * MediaQuery.of(context).size.height,),
          //
          //     Text("  ICLOUD", style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: "DreamOrphans")),
          //     SizedBox(height: (1/20) * MediaQuery.of(context).size.height,),
          //   ],
          // ),
        ]
      ),
    );
  }
}
