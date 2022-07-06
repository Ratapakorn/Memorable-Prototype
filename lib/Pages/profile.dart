import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:senex/Pages/edit_profile.dart';
import 'package:senex/widget/appbar_widget.dart';
import 'package:hive/hive.dart';
import 'package:senex/widget/profile_widget.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final userBox = Hive.box('users');
  String name = Hive.box('users').get(0).name;
  //String about = Hive.box('users').get(0).about;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: buildAppBar(context, true),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: Hive.box('users').get(0).imagePath,
            onClicked: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EditProfilePage())
              );
            },
          ),
          const SizedBox(
            height: 24,
          ),
          buildName(),
          const SizedBox(
            height: 24,
          ),
          buildAbout(),
        ],
      ),
    );
  }

  Widget buildName() => Column(
    children: [
      Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Robotto", fontSize: 24),)
    ],
  );

  Widget buildAbout() => Container(
    padding: EdgeInsets.symmetric(horizontal: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('About', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Robotto", fontSize: 24),),
        const SizedBox(
          height: 16,
        ),
        Text(getAbout(), style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Robotto", fontSize: 16, height: 1.4),),
      ],
    ),
  );

  String getAbout() {
    if(Hive.box('users').get(0).about == null){
      return "You can enter your information about you here :)";
    }
    return Hive.box('users').get(0).about;
  }
}
