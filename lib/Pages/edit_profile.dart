import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:senex/Pages/profile.dart';
import 'package:senex/models/User.dart';
import 'package:senex/widget/appbar_widget.dart';
import 'package:senex/widget/button_widget.dart';
import 'package:senex/widget/profile_widget.dart';
import 'package:hive/hive.dart';
import 'package:senex/widget/textfield_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';


class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  void refreshValues() {
    setState(() {
      final thisUser = Hive.box('users').get(0);
      Hive.box('users').put(0, thisUser);
    });
  }

  @override
  Widget build(BuildContext context) {
    String path = Hive.box('users').get(0).imagePath.toString();
    final userBox = Hive.box('users').get(0);
    final Box = Hive.box('users');
    String name = Hive.box('users').get(0).name;

    return Scaffold(
      appBar: buildAppBar(context, false),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: path,
            // imagePath: Hive.box('users').get(0).imagePath.toString(),
            isEdit: true,
            onClicked: () async{
              final image = await ImagePicker().pickImage(source: ImageSource.gallery);

              if(image == null) return;

              final directory = await getApplicationDocumentsDirectory();
              final name = basename(image.path);

              final imageFile = File('${directory.path}/$name');
              final newImage = await File(image.path).copy(imageFile.path);
              final thisUser = User(name: userBox.name, about: userBox.about, imagePath: newImage.path);
              Box.put(0, thisUser);

              setState(() {
                path = Hive.box('users').get(0).imagePath.toString();
              });

            },
          ),
          SizedBox(
            height: 24,
          ),
          TextFieldWidget(
            label: "Name",
            text: userBox.name,
            onChanged: (nameField) {
              final thisUser = User(name: nameField, about: userBox.about, imagePath: userBox.imagePath);
              Box.put(0, thisUser);
            },
          ),
          SizedBox(
            height: 24,
          ),
          TextFieldWidget(
            label: "About",
            text: userBox.about,
            maxLines: 5,
            onChanged: (aboutField) {
              final thisUser = User(name: userBox.name, about: aboutField, imagePath: userBox.imagePath);
              Box.put(0, thisUser);
            },
          ),
          const SizedBox(
            height: 24,
          ),
          ButtonWidget(
            text: "Save",
            onClicked: () {
              refreshValues();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Profile())
              );
            },
          ),
        ],
      ),
    );
  }
}
