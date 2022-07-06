import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:senex/Pages/People.dart';
import 'package:senex/Pages/Reminder.dart';
import 'package:senex/utils/user_simple_preferences.dart';
import 'package:senex/widget/button_widget.dart';
import 'package:senex/widget/navigation_drawer_widget.dart';

class createPeople extends StatefulWidget {
  final int index;
  const createPeople({Key? key, required this.index}) : super(key: key);

  @override
  _createPeopleState createState() => _createPeopleState();
}

class _createPeopleState extends State<createPeople> {
  String sub = "";
  final controller = TextEditingController();
  String path = "";
  File? image;
  bool change = false;
  List<String>? namePeople = UserSimplePreferences.getPeopleName() ?? [];
  List<String>? picPeople = UserSimplePreferences.getPeoplePic() ?? [];
  List<String>? agePeople = UserSimplePreferences.getPeopleAge() ?? [];
  int age = 0;

  @override
  void initState(){
    super.initState();
    widget.index != -1 ? controller.text = namePeople![widget.index]
    : controller.text = "";

    widget.index != -1 ? sub = namePeople![widget.index]
        : sub = "";

    widget.index != -1 ? path = picPeople![widget.index]
        : path = "";

    widget.index != -1 ? image = File(picPeople![widget.index])
        : image = null;

    if(widget.index != -1 && picPeople![widget.index] == ""){
      change = true;
    }else{
      change = false;
    }

    if(widget.index != -1){
      print(agePeople);
    }

    widget.index != -1 ? age = int.parse(agePeople![widget.index])
        : age = 0;
  }

  Widget getUser(){
    if(change || (widget.index == -1 && image == null)){
      return Icon(Icons.account_circle, size: 100,);
    }

    if(image != null){
      return Stack(children: [
        ClipRRect(borderRadius: BorderRadius.circular(100.0), child: Image.file(image!, width: 100, height: 100, fit: BoxFit.cover)),
        Positioned(
            bottom: -2,
            right: -23,
            child: RawMaterialButton(
              shape: CircleBorder(),
              fillColor: Colors.white,
              onPressed: (){
                setState(() {
                  //image = null;
                  path = "";
                  change = true;
                });

              },
              child: Icon(Icons.cancel, size: 40, color: Color.fromRGBO(
                  227, 43, 43, 1.0),),
            )
        ),

      ]
      );
    }

    if(picPeople![widget.index] == ""){
      return Icon(Icons.account_circle, size: 100,);
    }

    if(image == null && picPeople![widget.index] == ""){
      return Icon(Icons.account_circle, size: 100,);
    }
    else if(image != null && change){
      return Stack(children: [
        ClipRRect(borderRadius: BorderRadius.circular(100.0), child: Image.file(image!, width: 100, height: 100, fit: BoxFit.cover)),
        Positioned(
            bottom: -2,
            right: -23,
            child: RawMaterialButton(
              shape: CircleBorder(),
              fillColor: Colors.white,
              onPressed: (){
                setState(() {
                  //image = null;
                  change = true;
                  path = "";
                });

              },
              child: Icon(Icons.cancel, size: 40, color: Color.fromRGBO(
                  227, 43, 43, 1.0),),
            )
        ),

      ]
      );
    }
    else{
      return Stack(children: [
        ClipRRect(borderRadius: BorderRadius.circular(100.0), child: Image.file(image!, width: 100, height: 100, fit: BoxFit.cover)),
        Positioned(
            bottom: -2,
            right: -23,
            child: RawMaterialButton(
              shape: CircleBorder(),
              fillColor: Colors.white,
              onPressed: (){
                setState(() {
                  change = true;
                  path = "";
                });

              },
              child: Icon(Icons.cancel, size: 40, color: Color.fromRGBO(
                  227, 43, 43, 1.0),),
            )
        ),

      ]
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      backgroundColor: const Color.fromRGBO(54, 87, 47, 1.0),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(17, 57, 5, 1.0),
        //backgroundColor: Colors.black26,
        title: Text(widget.index == -1 ? "Add Contacts" : "Edit " + namePeople![widget.index], style: TextStyle(color: Colors.white, )),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                height: 10
            ),
            // Center(
            //   child: Text(widget.index == -1 ? "Add Contacts" : "Edit " + namePeople![widget.index], style: TextStyle(color: Colors.white, fontSize: 30, fontFamily: "DreamOrphans")),
            // ),
            Container(
                height: 10
            ),
            Center(
              child: RawMaterialButton(
                onPressed: () async {
                  try{

                    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
                    if (image == null) return; else{
                      change = false;
                    }

                    final imageTemporary = File(image.path);
                    path = image.path;
                    setState(() {
                      this.image = imageTemporary;
                      if(widget.index == -1){
                        UserSimplePreferences.addPeoplePic(path);
                      }else{
                        UserSimplePreferences.editPeoplePic(path, widget.index);
                      }
                    });
                  } on PlatformException catch (e) {
                    print('Failed to pick image: $e');
                  }

                },
                child: getUser(),
                //borderRadius: BorderRadius.circular(8.0),
                // child: this.image == null || picPeople![widget.index] == ""
                //     ? Icon(Icons.account_circle, size: 100)
                //     : widget.index == -1 ? Stack(children: [
                //       ClipRRect(borderRadius: BorderRadius.circular(100.0), child: Image.file(image!, width: 100, height: 100, fit: BoxFit.cover)),
                //       Positioned(
                //           bottom: -2,
                //           right: -23,
                //           child: RawMaterialButton(
                //             shape: CircleBorder(),
                //             fillColor: Colors.white,
                //             onPressed: (){
                //               setState(() {
                //                 image = null;
                //                 path = "";
                //               });
                //
                //             },
                //             child: Icon(Icons.cancel, size: 40, color: Color.fromRGBO(
                //                 227, 43, 43, 1.0),),
                //           )
                //       ),
                //     ],)//ClipRRect(borderRadius: BorderRadius.circular(100.0), child: Image.file(image!, width: 100, height: 100, fit: BoxFit.cover))
                //
                //     //:  ? Icon(Icons.account_circle, size: 100)
                //     : Stack(children: [
                //   ClipRRect(borderRadius: BorderRadius.circular(100.0), child: Image.file(File(picPeople![widget.index]), width: 100, height: 100, fit: BoxFit.cover)),
                //   Positioned(
                //       bottom: -2,
                //       right: -23,
                //       child: RawMaterialButton(
                //         shape: CircleBorder(),
                //         fillColor: Colors.white,
                //         onPressed: (){
                //           setState(() async {
                //             await UserSimplePreferences.editPeoplePic("", widget.index);
                //             image = null;
                //             path = "";
                //           });
                //         },
                //         child: Icon(Icons.cancel, size: 40, color: Color.fromRGBO(
                //             227, 43, 43, 1.0),),
                //       )
                //   ),
                // ],)
              )
              //final image = await ImagePicker().pickImage(source: ImageSource.gallery);
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Basic Information",
                style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.04, fontFamily: "Robotto"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 0, right: 15),
              child: TextFormField(
                controller: controller,
                maxLength: 13,
                onChanged: (controller){
                  sub = controller.toString();
                },
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
            ),

            // Container(
            //     height: 5
            // ),

            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Text("Age", style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.07 / 2, fontFamily: "Robotto"),),
                  Container(width: 20,),
                  Container(
                    //color: Colors.black,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(100)
                    ),
                    child: NumberPicker(
                      value: age,
                      minValue: 0,
                      maxValue: 130,
                      onChanged: (value) {
                        setState(() {
                          age = value;
                        });
                      },
                      axis: Axis.horizontal,
                      itemWidth: 50,
                      itemHeight: MediaQuery.of(context).size.height * 0.07,
                    ),
                  ),
                ],
              ),
            ),

            Container(
                height: 10
            ),

            // ElevatedButton(onPressed: (){
            //   print(age);
            // }, child: Text("sgsesg")),
            //
            // Container(
            //     height: 10
            // ),

            Center(
              child: ButtonWidget(onClicked: () async {
                await UserSimplePreferences.resetAll();
                print(UserSimplePreferences.getReminderNum());
                print(UserSimplePreferences.getReminderName());
                print(UserSimplePreferences.getReminderBool());
                print(UserSimplePreferences.getReminderTime());
                //Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Reminder()));
              },
                text: 'Reset',
                colR: 255,
                colG: 255,
                colB: 255,
              ),
            ),

            Container(
                height: 10
            ),
            Center(
              child: ButtonWidget(text: "Save", onClicked: () async {
                if(widget.index == -1){
                  await UserSimplePreferences.addPeopleNum();
                  await UserSimplePreferences.addPeopleName(sub);
                  await UserSimplePreferences.addPeoplePic(path);
                  await UserSimplePreferences.addAllPicsEnd(path);
                  await UserSimplePreferences.addPeopleAge(age.toString());
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PeoplePage()));
                }else{
                  await UserSimplePreferences.editPeopleName(sub, widget.index);
                  await UserSimplePreferences.editPeoplePic(path, widget.index);
                  await UserSimplePreferences.editOnePics(path, widget.index, 0);
                  await UserSimplePreferences.editPeopleAge(age.toString(), widget.index);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PeoplePage()));
                }

              }),
            ),

            Container(
                height: 10
            ),

            widget.index != -1 ? Center(
              child: ButtonWidget(text: "Delete", onClicked: () {
                UserSimplePreferences.deletePeople(widget.index);
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PeoplePage()));
              }),
            )
            : Container(),
          ],
        ),
      ),
    );
  }
}
