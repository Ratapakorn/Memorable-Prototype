import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:senex/Pages/People.dart';
import 'package:senex/Pages/gamePage.dart';
import 'package:senex/utils/user_simple_preferences.dart';
import 'package:senex/widget/navigation_drawer_widget.dart';

class specificPeople extends StatefulWidget {
  final int index;
  const specificPeople({Key? key, required int this.index}) : super(key: key);

  @override
  _specificPeopleState createState() => _specificPeopleState();
}

class _specificPeopleState extends State<specificPeople> {
  List<String>? picPeople = UserSimplePreferences.getPeoplePic() ?? [];
  List<String>? namePeople = UserSimplePreferences.getPeopleName() ?? [];
  List<String>? picPersonalPeople = UserSimplePreferences.getPeoplePicPersonal() ?? [];
  List<String> picPath = [];
  List<String>? agePeople = UserSimplePreferences.getPeopleAge() ?? [];
  int currPic = -1;
  bool black = false;

  List<String> getNum(){
    List<String> replace = [];
    for(int i = 0; i < UserSimplePreferences.getPeoplePicPersonal()![widget.index].split("|||").length; i++){
      if(UserSimplePreferences.getPeoplePicPersonal()![widget.index].split("|||")[i] != ""){
        replace.add(UserSimplePreferences.getPeoplePicPersonal()![widget.index].split("|||")[i]);
      }
    }
    return replace;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // drawer: TextButton(onPressed: (){
        //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PeoplePage()));
        // }, child: Icon(Icons.arrow_back_outlined),),//NavigationDrawerWidget(),
        backgroundColor: const Color.fromRGBO(54, 87, 47, 1.0),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(17, 57, 5, 1.0),
          title: Text("Information"),
          leading: TextButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PeoplePage()));
          }, child: Icon(Icons.arrow_back_outlined, color: Colors.white,),),
        //title: Text("Settings"),
        ),
        body: black == true ? Stack(
          children: [
            Container(
              color: const Color.fromRGBO(54, 87, 47, 1.0),
            ),

            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Image.file(File(getNum()[currPic]), height: MediaQuery.of(context).size.height * 0.6,),
                ),
                Center(
                  //bottom: 10,
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.19,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: GridView.count(
                            crossAxisCount: 2,
                            children: [
                              TextButton(onPressed: () {
                                print(widget.index);
                                print(currPic);
                                setState(() {
                                  black = false;
                                });
                              }, child: Icon(Icons.keyboard_return, size: 50, color: Colors.white,),),
                              TextButton(onPressed: () async {
                                showDialog(context: context, builder: (BuildContext cxt) {
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
                                    title: Text("Are you sure you want to delete it?"),
                                    content: SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.10,
                                      width: 50,
                                      child: GridView.count(crossAxisCount: 2, children: [
                                        TextButton(onPressed: () async {
                                          Navigator.pop(context);
                                          await UserSimplePreferences.deleteOnePic(widget.index, currPic);
                                          setState(() {
                                            black = false;
                                          });
                                        }, child: Align(alignment: Alignment.topCenter,child: Text('yes', style: TextStyle(fontFamily: "Robotto", fontSize: MediaQuery.of(context).size.height * 0.05, color: Colors.white),)),),
                                        TextButton(onPressed: () async {
                                          Navigator.pop(context);
                                        }, child: Align(alignment: Alignment.topCenter, child: Text('no', style: TextStyle(fontFamily: "Robotto" , fontSize: MediaQuery.of(context).size.height * 0.05, color: Colors.white ),)),),
                                      ],),
                                    )
                                  );
                                });

                              }, child: Icon(IconData(0xf4c4, fontFamily: CupertinoIcons.iconFont, fontPackage: CupertinoIcons.iconFontPackage), size: 50, color: Colors.white),)
                            ]
                        ),
                      ),
                    )
                )
              ],
            ),
            // Center(
            //     //bottom: 10,
            //     child: GridView.count(
            //         crossAxisCount: 2,
            //         children: [
            //           TextButton(onPressed: () {}, child: Text("shit"),),
            //           TextButton(onPressed: () {}, child: Text("shit"),)
            //         ]
            //     )
            // )
          ]
        )
          : SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                  color: const Color.fromRGBO(54, 87, 47, 1.0),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 20,),
                  picPeople![widget.index] == "" ? Center(child: Icon(Icons.account_circle, size: 150,))
                  : Center(child: ClipRRect(borderRadius: BorderRadius.circular(100.0), child: Image.file(File(picPeople![widget.index]), width: 150, height: 150, fit: BoxFit.cover))),
                  Container(height: 10,),
                  Center(child: namePeople![widget.index] != "" ? Text(namePeople![widget.index], maxLines: 1, style: TextStyle(fontFamily: "Robotto", fontSize: 40),) : Text("Unknown Name", maxLines: 1, style: TextStyle(fontFamily: "Robotto", fontSize: 40),)),
                  Container(height: 10,),
                  Row(
                    children: [
                      Container(width: 10,),
                      Text("Basic Info", style: TextStyle(fontFamily: "Robotto", fontSize: 25),),
                    ],
                  ),
                  //Container(height: 10,),
                  // ElevatedButton(onPressed: () {UserSimplePreferences.resetPics();
                  // print(UserSimplePreferences.getPeoplePicPersonal());}, child: Text("tesmp")),
                  // ElevatedButton(onPressed: () {print(UserSimplePreferences.getPeoplePicPersonal());
                  // print(getNum().length);}, child: Text("tesmp")),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10, left: 25),
                    child: Text("Age: " + agePeople![widget.index], style: TextStyle(fontSize: 20, fontFamily: "Robotto"),),
                  ),
                  //Container(height: 10,),
                  Row(
                    children: [
                      Container(width: 10,),
                      Text("Photos", style: TextStyle(fontFamily: "Robotto", fontSize: 25),),
                    ],
                  ),
                  Container(height: 10,),
                  Row(
                    children: [
                      Container(width: MediaQuery.of(context).size.width * 0.05,),
                      SizedBox(
                        height: 100000000,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: GridView.count(
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          crossAxisCount: 4,
                          children: <Widget>[
                            ElevatedButton(onPressed: () async {
                              try{

                                final image = await ImagePicker().pickImage(source: ImageSource.gallery);
                                if (image == null) return;

                                final imageTemporary = File(image.path);
                                //path = image.path;
                                if(picPersonalPeople == []){
                                  UserSimplePreferences.addAllPicsEnd(image.path);
                                }else{
                                  UserSimplePreferences.addOnePics(image.path, widget.index);
                                }
                                print(UserSimplePreferences.getPeoplePicPersonal());
                                //print(UserSimplePreferences.getPeoplePicPersonal()![widget.index].split("|||").length);
                                setState(() => picPath.add(imageTemporary.path));
                              } on PlatformException catch (e) {
                                print('Failed to pick image: $e');
                              }

                            }, child: Icon(Icons.add_a_photo)),

                            for(int i = 0; i < getNum().length; i++) //UserSimplePreferences.getPeoplePicPersonal()![widget.index].split("|||").length
                              // TextButton(onPressed: () {
                              //   print("tapped");
                              // }, style: ButtonStyle(padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero)),child: Image.file(File(picPath[i]), fit: BoxFit.fill,)),

                              InkWell(
                                onTap: () {
                                  setState(() {
                                    black = true;
                                    currPic = i;
                                  });
                                }, // Handle your callback.
                                splashColor: Colors.brown.withOpacity(0.5),
                                child: Ink(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: FileImage(File(getNum()[i])), //AssetImage('your_image_asset'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              )

                          ],
                        ),
                      ),

                    ],
                  ),



                ],
              )
            ],
          ),
        ),
    );
  }
}
