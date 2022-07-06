import 'package:flutter/material.dart';
import 'package:senex/Pages/create_rem.dart';
import 'package:senex/main.dart';
import 'package:senex/utils/user_simple_preferences.dart';
import 'package:senex/widget/button_widget.dart';
import 'package:senex/widget/navigation_drawer_widget.dart';
//import 'package:cupertino_setting_control/cupertino_setting_control.dart';
import 'package:senex/mainMenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:senex/widget/notification_api.dart';
//

class Reminder extends StatefulWidget {
  const Reminder({Key? key}) : super(key: key);

  @override
  _ReminderState createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {
  int? numReminder = UserSimplePreferences.getReminderNum() ?? 0;
  List<String>? remList = UserSimplePreferences.getReminderName();
  List<String>? timeList = UserSimplePreferences.getReminderTime();
  List<String>? boolList = UserSimplePreferences.getReminderBool();

  @override
  void initState(){
    super.initState();
    for (var i = 0; i < numReminder!; i++) {
      if(boolList![i] == "1") {
        NotificationApi.showScheduledNotification(
          title: "Reminder of the day",
          body: remList![i],
          payload: "Sarhah",
          hour: int.parse(timeList![i].split(':')[0]),
          minute: int.parse(timeList![i].split(':')[1].split(' ')[0]),

        );
      }else{
        NotificationApi.showNonEScheduledNotification(
          title: "Reminder of the day",
          body: remList![i],
          payload: "Sarhah",
          hour: int.parse(timeList![i].split(':')[0]),
          minute: int.parse(timeList![i].split(':')[1].split(' ')[0]),

        );
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          backgroundColor: Colors.black26,
          //title: Text("Settings"),
        ),
        body: SingleChildScrollView(
          child: Stack(
              children: <Widget>[
                Container(
                  color: const Color.fromRGBO(85, 87, 83, 1.0),
                ),
                Column(
                  children: [
                    for (var i = 0; i < numReminder!; i++)

                    ListView(
                      shrinkWrap: true,
                      children: [
                        Container(
                          height: 15,

                        ),

                        MaterialButton(
                          onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => createReminder(index: i,)));},
                          child: Row(
                            children: [
                              const Icon(
                                Icons.timer,
                                size: 50,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                              ),
                              Text(remList![i], style: TextStyle(fontFamily: "Robotto", fontSize: 30),),
                            ],
                          ),
                          //style: ButtonStyle(padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(8.0))),
                        )



                        // Row(
                        //   children: [
                        //     RawMaterialButton(
                        //       child: const Icon(
                        //         Icons.timer,
                        //         size: 50,
                        //       ),
                        //       onPressed: () {
                        //         Navigator.of(context).push(MaterialPageRoute(builder: (context) => createReminder(index: i,)));
                        //       },
                        //     ),
                        //     Container(
                        //       width: MediaQuery.of(context).size.width * 0.2,
                        //     ),
                        //     Text(remList![i], style: TextStyle(fontFamily: "Robotto", fontSize: 30),),
                        //   ],
                        // ),

                        // ButtonWidget(
                        //   text: remList![i],
                        //   hor: 32.0,
                        //   vert: 20.0,
                        //   // child: Container(
                        //   //   margin: EdgeInsets.all(5),
                        //   //   height: 50,
                        //   //   child: Center(child: Text('One', style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'DreamOrphans'))),
                        //   //   color: Color.fromRGBO(145, 151, 161, 1.0),
                        //   // ),
                        //   onClicked: () {
                        //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => createReminder(index: i,)));
                        //   },
                        // )
                      ],
                    ),

                    Container(
                      height: 10,

                    ),
                    //
                    // ListView(
                    //   shrinkWrap: true,
                    //   children: [
                    //     ButtonWidget(
                    //       text: "one",
                    //       hor: 32.0,
                    //       vert: 20.0,
                    //       // child: Container(
                    //       //   margin: EdgeInsets.all(5),
                    //       //   height: 50,
                    //       //   child: Center(child: Text('One', style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'DreamOrphans'))),
                    //       //   color: Color.fromRGBO(145, 151, 161, 1.0),
                    //       // ),
                    //       onClicked: () {
                    //         Navigator.of(context).push(MaterialPageRoute(builder: (context) => const mainMenu()));
                    //       },
                    //     )
                    //   ],
                    // ),

                  ],


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
        ),

        floatingActionButton: FloatingActionButton(child: Icon(Icons.add), backgroundColor: Colors.grey ,onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const createReminder(index: -1,)));
        })
    );

  }
}