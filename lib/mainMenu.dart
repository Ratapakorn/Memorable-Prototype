import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as Path;
import 'package:flutter/material.dart';
import 'package:senex/Pages/HealthPage.dart';
import 'package:senex/Pages/People.dart';
import 'package:senex/Pages/TicTacToe.dart';
import 'package:senex/Pages/edit_profile.dart';
import 'package:senex/Pages/gamePage.dart';
import 'package:senex/Pages/profile.dart';
import 'package:senex/Pages/recommendations.dart';
import 'package:senex/widget/button_widget.dart';
import 'package:senex/widget/navigation_drawer_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:senex/widget/notification_api.dart';
import 'package:senex/widget/profile_widget.dart';

// import 'Pages/FlappyBoy.dart';
import 'Pages/Pong.dart';
import 'Pages/Reminder.dart';
import 'models/User.dart';

class mainMenu extends StatefulWidget {
  const mainMenu({Key? key}) : super(key: key);
  //final String name;
  @override
  _mainMenuState createState() => _mainMenuState();
}

class _mainMenuState extends State<mainMenu> {
  //TextEditingController controller = TextEditingController();
  int? minutes;
  int curr = 0;



  @override
  void initState(){
    super.initState();
    //widget.storage.readData().then((String value) {
    //  setState(() {
    //    state = value;
    //  });
    //});
    //minutes = 0;
    NotificationApi.init();
    listenNotifications();
  }

  void listenNotifications() =>
      NotificationApi.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) {
    // Navigator.of(context).push(MaterialPageRoute(
    //   builder: (context) => mainMenu(),
    // ));
  }


  final userBox = Hive.box('users');
  String name = Hive.box('users').get(0).name;


  // Find the Documents path
  // Future<String> _getDirPath() async {
  //   final _dir = await getApplicationDocumentsDirectory();
  //   return _dir.path;
  // }

  // This function is triggered when the "Read" button is pressed
  // Future<void> _readData() async {
  //   final _dirPath = await _getDirPath();
  //   // final _myFile = File('$_dirPath/name.txt');
  //   final _myFile = File('$_dirPath/name.txt');
  //   final _data = await _myFile.readAsString(encoding: utf8);
  //   setState(() {
  //     _content = _data;
  //   });
  // }

  // TextField controller
  // This function is triggered when the "Write" buttion is pressed
  // write(String text) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final File file = File('${directory.path}/name.txt');
  //   await file.writeAsString(text);
  // }

  // Future get _localPath async {
  //   // Application documents directory: /data/user/0/{package_name}/{app_name}
  //   final applicationDirectory = await getApplicationDocumentsDirectory();
  //
  //   // External storage directory: /storage/emulated/0
  //   final externalDirectory = await getExternalStorageDirectory();
  //
  //   // Application temporary directory: /data/user/0/{package_name}/cache
  //   final tempDirectory = await getTemporaryDirectory();
  //
  //   return applicationDirectory.path;
  // }
  //
  // Future get _localFile async {
  //   final path = await _localPath;
  //
  //   return File('$path/name.txt');
  // }
  //
  // Future _writeToFile(String text) async {
  //   // if (!_allowWriteFile) {
  //   //   return null;
  //   // }
  //
  //   final file = await _localFile;
  //
  //   // Write the file
  //   File result = await file.writeAsString('$text');
  // }


  // Future<bool> hasName() async {
  //   if(readcontent() != 'Error!'){
  //     return false;
  //   }else if(readcontent() != ''){
  //     return false;
  //   }
  //   return true;
  // }



  void refreshName() {
    setState(() {
      name = Hive.box('users').get(0).name;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    //String name = widget.name;
    //context.read<FileController>().readText();
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        backgroundColor: Colors.black26,
        //title: Text(""),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              color: Color.fromRGBO(88, 88, 88, 1.0),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: (1/30) * MediaQuery.of(context).size.height
                  ),
                  ProfileWidget(
                    imagePath: Hive.box('users').get(0).imagePath,
                    hasSymbol: false,
                    isEdit: false,
                    onClicked: () {
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context) => EditProfilePage())
                      // );
                    },

                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: (1/50) * MediaQuery.of(context).size.height
                  ),
                  // if(readcontent() != "Error")
                  //final user =  as User;
                  Center(child: Text("Welcome back, $name", style: const TextStyle(fontSize: 25, fontFamily: "Robotto", fontWeight: FontWeight.bold),)),
                  const SizedBox(
                      height: 20,
                  ),

                  SizedBox(
                    height: (1/2) * MediaQuery.of(context).size.height,
                    //width: (1/4) * MediaQuery.of(context).size.width,
                    child: GridView.count(
                      padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      crossAxisCount: 2,
                      children: [
                        ElevatedButton(onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Profile()));
                        },
                          child: SizedBox(width: MediaQuery.of(context).size.width * 0.3, height: MediaQuery.of(context).size.height * 0.1, child: Center(child: FittedBox(
                            fit: BoxFit.cover,
                            child: Text("Me", style: TextStyle(fontFamily: "Robotto", color: Color.fromRGBO(
                                255, 255, 255, 1.0), fontSize: 25, fontWeight: FontWeight.bold),),
                          )),),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(127, 127, 127, 1.0),
                            onPrimary: Color.fromRGBO(94, 7, 7, 1.0),
                          )),
                        ElevatedButton(onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => PeoplePage()));
                        },
                            child: SizedBox(width: MediaQuery.of(context).size.width * 0.3, height: MediaQuery.of(context).size.height * 0.1, child: Center(child: Text("Family", style: TextStyle(fontFamily: "Robotto", color: Color.fromRGBO(
                                255, 255, 255, 1.0), fontSize: 25, fontWeight: FontWeight.bold),)),),
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromRGBO(127, 127, 127, 1.0),
                              onPrimary: Color.fromRGBO(94, 7, 7, 1.0),
                            )),
                        ElevatedButton(onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => healthPage()));
                        },
                            child: SizedBox(width: MediaQuery.of(context).size.width * 0.3, height: MediaQuery.of(context).size.height * 0.1, child: Center(child: Text("Health", style: TextStyle(fontFamily: "Robotto", color: Color.fromRGBO(
                                255, 255, 255, 1.0), fontSize: 25, fontWeight: FontWeight.bold),)),),
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromRGBO(127, 127, 127, 1.0),
                              onPrimary: Color.fromRGBO(94, 7, 7, 1.0),
                            )),
                        ElevatedButton(onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => gamePage()));
                        },
                            child: SizedBox(width: MediaQuery.of(context).size.width * 0.3, height: MediaQuery.of(context).size.height * 0.1, child: Center(child: Text("Exercise", style: TextStyle(fontFamily: "Robotto", color: Color.fromRGBO(
                                255, 255, 255, 1.0), fontSize: 25, fontWeight: FontWeight.bold),)),),
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromRGBO(127, 127, 127, 1.0),
                              onPrimary: Color.fromRGBO(94, 7, 7, 1.0),
                            )),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      //height: 39,
                      width: MediaQuery.of(context).size.width - 16,
                      child: ElevatedButton(onPressed: () {
                          minutes = 0;
                          showDialog(
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                    builder: (context, setState) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(
                                              20.0,
                                            ),
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.only(
                                          top: 10.0,
                                        ),
                                        title: Text(
                                          "Quick Question",
                                          style: TextStyle(fontSize: 24.0),
                                        ),
                                        content: Container(
                                          height: 210,
                                          child: SingleChildScrollView(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "How many minutes do you have right now? ",
                                                    //style: TextStyle(),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                // Container(
                                                //   padding: const EdgeInsets.all(8.0),
                                                //   child: TextField(
                                                //     controller: controller,
                                                //     decoration: InputDecoration(
                                                //         border: OutlineInputBorder(),
                                                //         hintText: 'Time in minutes',
                                                //         labelText: 'Time'),
                                                //   ),
                                                // ),
                                                Container(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: NumberPicker(
                                                      value: minutes!,
                                                      minValue: 0,
                                                      maxValue: 100,
                                                      onChanged: (value){
                                                        setState(() {

                                                          curr = value;
                                                          minutes = curr;
                                                        });
                                                        //minutes = value;
                                                      },
                                                      axis: Axis.horizontal,
                                                      haptics: true,
                                                      //infiniteLoop: true,
                                                    )
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  height: 60,
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      // if(minutes! <= 5){
                                                      //   //print("lessthan=to5");
                                                      // }else if(minutes! <= 15){
                                                      //   //print("lessthan=to15");
                                                      // }else{
                                                      //   //print("lessthan=else");
                                                      // }
                                                      print(minutes!);
                                                      // Navigator.of(context).pop();
                                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Recommend(timeLeft: minutes!)));
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      primary: Colors.black,
                                                      // fixedSize: Size(250, 50),
                                                    ),
                                                    child: Text(
                                                      "Submit",
                                                    ),
                                                  ),
                                                ),
                                                // Container(
                                                //   padding: const EdgeInsets.all(8.0),
                                                //   child: Text('Note'),
                                                // ),
                                                // Padding(
                                                //   padding: const EdgeInsets.all(8.0),
                                                //   child: Text(
                                                //     'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt'
                                                //         ' ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud'
                                                //         ' exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'
                                                //         ' Duis aute irure dolor in reprehenderit in voluptate velit esse cillum '
                                                //         'dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident,'
                                                //         ' sunt in culpa qui officia deserunt mollit anim id est laborum.',
                                                //     style: TextStyle(fontSize: 12),
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                );
                              });

                      },
                          // child: SizedBox(width: MediaQuery.of(context).size.width * 0.3, height: MediaQuery.of(context).size.height * 0.1, child: Center(child: Text("Exercise", style: TextStyle(fontFamily: "Robotto", color: Color.fromRGBO(
                          //     255, 255, 255, 1.0), fontSize: 25, fontWeight: FontWeight.bold),)),),
                          child: SizedBox(width: MediaQuery.of(context).size.width * 0.3, height: MediaQuery.of(context).size.height * 0.1, child: Icon(Icons.question_answer, size: 30, color: Colors.white,),),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(127, 127, 127, 1.0),
                            onPrimary: Color.fromRGBO(94, 7, 7, 1.0),
                          )),
                    ),
                  ),


                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   //border: TableBorder.all(),
                  //   children: [
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //
                  //         ElevatedButton(onPressed: () {},
                  //             child: SizedBox(width: MediaQuery.of(context).size.width * 0.3, height: MediaQuery.of(context).size.height * 0.1, child: Center(child: Text("My", style: TextStyle(fontFamily: "Robotto", color: Color.fromRGBO(
                  //                 255, 242, 210, 1.0), fontSize: 25, fontWeight: FontWeight.bold),)),),
                  //             style: ElevatedButton.styleFrom(
                  //               primary: Color.fromRGBO(0, 0, 0, 1.0),
                  //               onPrimary: Color.fromRGBO(94, 7, 7, 1.0),
                  //             )),
                  //         Container(
                  //           width: MediaQuery.of(context).size.width * 0.05,
                  //         ),
                  //         ElevatedButton(onPressed: () {
                  //           Navigator.of(context).push(MaterialPageRoute(builder: (context) => PeoplePage()));
                  //         },
                  //             child: SizedBox(width: MediaQuery.of(context).size.width * 0.3, height: MediaQuery.of(context).size.height * 0.1, child: Center(child: Text("Family", style: TextStyle(fontFamily: "Robotto", color: Color.fromRGBO(
                  //                 255, 242, 210, 1.0), fontSize: 25, fontWeight: FontWeight.bold),)),),
                  //             style: ElevatedButton.styleFrom(
                  //               primary: Color.fromRGBO(0, 0, 0, 1.0),
                  //               onPrimary: Color.fromRGBO(130, 66, 7, 1.0),
                  //             )),
                  //
                  //       ]
                  //     ),
                  //
                  //     Container(
                  //       height: MediaQuery.of(context).size.height * 0.02,
                  //       width: MediaQuery.of(context).size.width * 0.2,
                  //     ),
                  //
                  //     Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         children: [
                  //
                  //           ElevatedButton(onPressed: () {},
                  //               child: SizedBox(width: MediaQuery.of(context).size.width * 0.3, height: MediaQuery.of(context).size.height * 0.1, child: Center(child: Text("Health", style: TextStyle(fontFamily: "Robotto", color: Color.fromRGBO(
                  //                   255, 242, 210, 1.0), fontSize: 25, fontWeight: FontWeight.bold),)),),
                  //             style: ElevatedButton.styleFrom(
                  //               primary: Color.fromRGBO(0, 0, 0, 1.0),
                  //               onPrimary: Color.fromRGBO(75, 111, 8, 1.0),
                  //             )),
                  //           Container(
                  //             width: MediaQuery.of(context).size.width * 0.05,
                  //           ),
                  //           ElevatedButton(onPressed: () {},
                  //               child: SizedBox(width: MediaQuery.of(context).size.width * 0.3, height: MediaQuery.of(context).size.height * 0.1, child: Center(child: Text("Exercise", style: TextStyle(fontFamily: "Robotto", color: Color.fromRGBO(
                  //                   255, 242, 210, 1.0), fontSize: 25, fontWeight: FontWeight.bold),)),),
                  //               style: ElevatedButton.styleFrom(
                  //                 primary: Color.fromRGBO(0, 0, 0, 1.0),
                  //                 onPrimary: Color.fromRGBO(8, 101, 111, 1.0),
                  //               )),
                  //
                  //         ]
                  //     )
                  //   ],
                  // )

                  // const Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 10),
                  //   child: const Text("Daily Challenges: ", style: TextStyle(fontSize: 17, fontFamily: "Robotto"),),
                  // ),
                  //
                  // const SizedBox(
                  //   height: 10,
                  // ),

                  // Center(child: ButtonWidget(text: "Play a Game", onClicked: () {
                  //   Navigator.of(context).push(
                  //       MaterialPageRoute(builder: (context) => TicToe())
                  //   );
                  // })),

                  // const SizedBox(
                  //   height: 10,
                  // ),
                  //
                  // Center(child: ButtonWidget(text: "Play a Game", onClicked: () {
                  //   Navigator.of(context).push(
                  //       MaterialPageRoute(builder: (context) => Pong())
                  //   );
                  // })),




                  // const SizedBox(height: 20,),
                  // const Text("Change your name below", style: TextStyle(fontSize: 20, fontFamily: "Robotto"),),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                  //   child: TextField(
                  //     controller: controller,
                  //     decoration: const InputDecoration(
                  //       border: OutlineInputBorder(),
                  //       hintText: 'Enter your name',
                  //     ),
                  //   ),
                  // ),
                  // ElevatedButton(onPressed: () {
                  //   final currUser = User(name: controller.text, about: Hive.box('users').get(0).about, imagePath: Hive.box('users').get(0).imagePath);
                  //   userBox.put(0, currUser);
                  //   refreshName();
                  // }, child: const Text("Enter")),
                  // ElevatedButton(onPressed: () {
                  //   Navigator.of(context).push(_createRoute());
                  // }, child: const Text("Next"))
                  // ElevatedButton(onPressed: writeData
                  // , child: const Text("Enter")),
                  //
                  // ElevatedButton(onPressed: getAppDirectory
                  // , child: const Text("Path")),
                  //
                  // Text(state ?? "File is Empty"),
                  //
                  // FutureBuilder<Directory>(
                  //   future: _appDocDir,
                  //   builder: (BuildContext context, AsyncSnapshot<Directory> snapshot) {
                  //     Text text = Text('');
                  //     if(snapshot.connectionState == ConnectionState.done) {
                  //       if(snapshot.hasError){
                  //         text = Text('Error: ${snapshot.error}');
                  //       }else if (snapshot.hasData) {
                  //         text = Text('Error: ${snapshot.data?.path}');
                  //       }else{
                  //         text = Text('Unavailabie');
                  //       }
                  //     }
                  //     return Container(
                  //       child: text,
                  //     );
                  //   },
                  // )
                ],
              )
            ),

          ],
        ),
      )
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const EditProfilePage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      final tween = Tween(begin: begin, end: end);
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: curve,
      );

      return SlideTransition(
        position: tween.animate(curvedAnimation),
        child: child,
      );
    },
  );
}
