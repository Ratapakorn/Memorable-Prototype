import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:senex/Pages/create_pep.dart';
import 'package:senex/Pages/specPeople.dart';
import 'package:senex/utils/user_simple_preferences.dart';
import 'package:senex/widget/button_widget.dart';
import 'package:senex/widget/navigation_drawer_widget.dart';
import 'dart:io';

import '../mainMenu.dart';

class PeoplePage extends StatefulWidget {
  const PeoplePage({Key? key}) : super(key: key);

  @override
  _PeoplePageState createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  int? numPeople = UserSimplePreferences.getPeopleNum() ?? 0;
  List<String>? namePeople = UserSimplePreferences.getPeopleName() ?? [];
  List<String>? picPeople = UserSimplePreferences.getPeoplePic() ?? [];

  @override
  void initState(){
    super.initState();

    print(numPeople);
    print(namePeople);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(54, 87, 47, 1.0),
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(17, 57, 5, 1.0),
          title: Text("People"),
        ),
        body: SingleChildScrollView(
          child: Stack(
              children: <Widget>[
                Container(
                  color: const Color.fromRGBO(54, 87, 47, 1.0),
                ),
                Column(
                  children: [
                    for (var i = 0; i < numPeople!; i++)

                      ListView(
                        shrinkWrap: true,
                        children: [
                          Container(
                            height: 10,

                          ),

                          Stack(
                            children: [
                              MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => specificPeople(index: i,)));
                                },
                                child: Row(
                                  children: [
                                    picPeople![i] != "" ? ClipRRect(borderRadius: BorderRadius.circular(100.0), child: Image.file(File(picPeople![i]), width: 50, height: 50, fit: BoxFit.cover)) : Icon(
                                      Icons.people_alt_outlined,
                                      size: 50,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.1,
                                    ),
                                    Text(namePeople![i], style: TextStyle(fontFamily: "Robotto", fontSize: 30),),
                                    Container(
                                      width: 50,

                                    ),
                                  ],
                                ),
                                //style: ButtonStyle(padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(8.0))),
                              ),



                              Positioned(
                                right: 5,
                                child: RawMaterialButton(
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => createPeople(index: i,)));
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    size: 20
                                  ),
                                  shape: CircleBorder(),
                                  //padding: EdgeInsets.all(15.0),
                                  fillColor: Color.fromRGBO(138, 215, 123, 1.0),
                                ),
                              ),
                            ],
                          ),



                          // Container(
                          //   height: 10,
                          //
                          // ),


                        ],
                      ),



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

        floatingActionButton: FloatingActionButton(child: Icon(Icons.add, color: const Color.fromRGBO(
            119, 163, 111, 1.0),), backgroundColor: const Color.fromRGBO(
            83, 102, 70, 1.0) ,onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const createPeople(index: -1,)));
        })
    );
  }
}
