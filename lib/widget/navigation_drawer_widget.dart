import 'package:flutter/material.dart';
import 'package:senex/Pages/People.dart';
import 'package:senex/Pages/profile.dart';
import 'package:senex/Pages/settings.dart';
import 'package:senex/Pages/Reminder.dart';
import 'package:senex/Pages/test.dart';
import 'package:senex/mainMenu.dart';

class NavigationDrawerWidget extends StatelessWidget {
  //const NavigationDrawerWidget({Key? key}) : super(key: key);
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
          color: Colors.black26,
         //color: Colors.teal[900],
         child: ListView(
           padding: padding,
           children: <Widget>[
             const SizedBox(height: 48,),
             buildMenuItem(
               text: 'Main Menu',
               icon: Icons.people,
               onClicked: () => selectedItem(context, 3),
             ),
             const SizedBox(height: 16,),
             buildMenuItem(
               text: 'Reminder',
               icon: Icons.assignment_sharp,
               onClicked: () => selectedItem(context, 2),
             ),
             const SizedBox(height: 16,),
             buildMenuItem(
               text: 'People',
               icon: Icons.handyman,
               onClicked: () => selectedItem(context, 4),
             ),
             const SizedBox(height: 16,),
             buildMenuItem(
               text: 'Test',
               icon: Icons.plumbing,
               onClicked: () => selectedItem(context, 5),
             ),

             SizedBox(height: 24,),
             Divider(color: Colors.white70,),
             SizedBox(height: 24,),
             buildMenuItem(
               text: 'Profile',
               icon: Icons.person,
               onClicked: () => selectedItem(context, 1),
             ),
             SizedBox(height: 24,),
             buildMenuItem(
               text: 'Settings',
               icon: Icons.settings_sharp,
               onClicked: () => selectedItem(context, 0),
             ),
           ],
         ),
      ),
    );
  }
}

Widget buildMenuItem({
 required String text,
 required IconData icon,
 VoidCallback? onClicked,
}) {
  final color = Colors.white;
  final hoverColor = Colors.white70;

  return ListTile(
    leading: Icon(icon,  color: color),
    title: Text(text, style: TextStyle(color: color, fontFamily: "Robotto", fontWeight: FontWeight.bold),),
    hoverColor: hoverColor,
    onTap: onClicked,
  );
}

void selectedItem(BuildContext context, int index){
  switch (index) {
    case 0:
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Settings()));
      break;
    case 1:
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Profile()));
      break;
    case 2:
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Reminder()));
      break;
    case 3:
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const mainMenu()));
      break;
    case 4:
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PeoplePage()));
      break;
    case 5:
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Test()));
      break;
  }
}