import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:senex/themes.dart';
import 'package:senex/mainMenu.dart';



AppBar buildAppBar(BuildContext context, bool backBegin){
  final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
  final icon = CupertinoIcons.moon_stars;
  final ValueNotifier<ThemeMode> _notifier = ValueNotifier(ThemeMode.light);

  Widget backBeginning(bool logic){
    if(!(logic)){
      //print("check");
      return const BackButton();
    }
    return BackButton(onPressed: () {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => mainMenu())
      );
    },);
  }

  return AppBar(
    leading: backBeginning(backBegin),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      // IconButton(onPressed: () {
      //   print("changed");
      //   final theme = isDarkMode ? MyThemes.lightTheme : MyThemes.darkTheme;
      //   print(theme.toString());
      //   ThemeSwitcher.of(context).changeTheme(theme: MyThemes.lightTheme);
      //   _notifier.value;
      //   //final switcher = ThemeSwitcher.of(context).changeTheme(theme: MyThemes.lightTheme);
      //   //switcher.changeTheme(theme: theme);
      // }, icon: Icon(icon))
      IconButton(onPressed: () {},
        //_notifier.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
        icon: Icon(icon))
    ],
  );
}