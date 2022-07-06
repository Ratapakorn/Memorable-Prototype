import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static late SharedPreferences _preferences;

  //Reminder Keys

  static const _keyNum = 'numRem';
  static const _keyName = 'nameRem';
  static const _keyEvery = 'everyRem';
  static const _keyTime = 'everyTime';

  //People Keys

  static const _keyNumP = 'numPep';
  static const _keyNameP = 'namePep';
  static const _keyPicP = 'picPep';
  static const _keyPicPersonal = 'picPepPersonal';
  static const _keyAgeP = 'agePep';

  //Daily Keys

  static const _keyLastAccess = 'keyLA';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  //Reminder Page

  static Future addReminderNum() async {
    if(getReminderNum() == null){
      await _preferences.setInt(_keyNum, 1);
    }else{
      await _preferences.setInt(_keyNum, getReminderNum()! + 1);
    }

  }

  static Future addReminderBool(String bool) async {
    if(getReminderBool() == null){
      await _preferences.setStringList(_keyEvery, [bool]);
    }else{
      List<String>? newList = getReminderBool();
      newList?.add(bool);
      await _preferences.setStringList(_keyEvery, newList!);
    }
  }

  static Future editReminderBool(String bool, int index) async {
    List<String>? newList = getReminderBool();
    List<String> replace = [];
    for(int i = 0; i < index; i++){
      replace.add(newList![i]);
    }
    replace.add(bool);
    for(int i = index + 1; i < newList!.length; i++){
      replace.add(newList[i]);
    }

    await _preferences.setStringList(_keyEvery, replace);
  }

  static Future addReminderName(String name) async {
    if(getReminderName() == null){
      await _preferences.setStringList(_keyName, [name]);
    }else{
      List<String>? newList = getReminderName();
      newList?.add(name);
      await _preferences.setStringList(_keyName, newList!);
    }
  }

  static Future editReminderName(String name, int index) async {
    List<String>? newList = getReminderName();
    List<String> replace = [];
    for(int i = 0; i < index; i++){
      replace.add(newList![i]);
    }
    replace.add(name);
    for(int i = index + 1; i < newList!.length; i++){
      replace.add(newList[i]);
    }

    await _preferences.setStringList(_keyName, replace);
  }

  static List<String>? getReminderName() => _preferences.getStringList(_keyName);
  static List<String>? getReminderBool() => _preferences.getStringList(_keyEvery);

  static Future addReminderTime(String time) async {
    if(getReminderTime() == null){
      await _preferences.setStringList(_keyTime, [time]);
    }else{
      List<String>? newList = getReminderTime();
      newList?.add(time);
      await _preferences.setStringList(_keyTime, newList!);
    }
  }

  static Future editReminderTime(String time, int index) async {
    List<String>? newList = getReminderTime();
    List<String> replace = [];
    for(int i = 0; i < index; i++){
      replace.add(newList![i]);
    }
    replace.add(time);
    for(int i = index + 1; i < newList!.length; i++){
      replace.add(newList[i]);
    }

    await _preferences.setStringList(_keyTime, replace);
  }

  static List<String>? getReminderTime() => _preferences.getStringList(_keyTime);

  static Future resetAll() async {
    await _preferences.setInt(_keyNum, 0);
    await _preferences.setInt(_keyNumP, 0);
    await _preferences.setStringList(_keyName, []);
    await _preferences.setStringList(_keyEvery, []);
    await _preferences.setStringList(_keyTime, []);
    await _preferences.setStringList(_keyNameP, []);
    await _preferences.setStringList(_keyPicP, []);
    await _preferences.setStringList(_keyAgeP, []);
    resetPics();
  }

  static int? getReminderNum() => _preferences.getInt(_keyNum);

  // People Page

  static Future addPeopleNum() async {
    if(getPeopleNum() == null){
      await _preferences.setInt(_keyNumP, 0);
    }else{
      await _preferences.setInt(_keyNumP, getPeopleNum()! + 1);
    }

  }

  static int? getPeopleNum() => _preferences.getInt(_keyNumP);

  static Future addPeopleName(String name) async {
    if(getPeopleName() == null){
      await _preferences.setStringList(_keyNameP, [name]);
    }else{
      List<String>? newList = getPeopleName();
      newList?.add(name);
      await _preferences.setStringList(_keyNameP, newList!);
    }
  }

  static List<String>? getPeopleName() => _preferences.getStringList(_keyNameP);

  static Future addPeopleAge(String age) async {
    if(getPeopleAge() == null){
      await _preferences.setStringList(_keyAgeP, [age]);
    }else{
      List<String>? newList = getPeopleAge();
      newList?.add(age);
      await _preferences.setStringList(_keyAgeP, newList!);
    }
  }

  static List<String>? getPeopleAge() => _preferences.getStringList(_keyAgeP);

  static Future addPeoplePic(String path) async {
    if(getPeoplePic() == null){
      await _preferences.setStringList(_keyPicP, [path]);
    }else{
      List<String>? newList = getPeoplePic();
      newList?.add(path);
      await _preferences.setStringList(_keyPicP, newList!);
    }
  }

  static List<String>? getPeoplePic() => _preferences.getStringList(_keyPicP);

  static Future editPeopleName(String name, int index) async {
    List<String>? newList = getPeopleName();
    List<String> replace = [];
    for(int i = 0; i < index; i++){
      replace.add(newList![i]);
    }
    replace.add(name);
    for(int i = index + 1; i < newList!.length; i++){
      replace.add(newList[i]);
    }

    await _preferences.setStringList(_keyNameP, replace);
  }

  static Future editPeopleAge(String age, int index) async {
    List<String>? newList = getPeopleAge();
    List<String> replace = [];
    for(int i = 0; i < index; i++){
      replace.add(newList![i]);
    }
    replace.add(age);
    for(int i = index + 1; i < newList!.length; i++){
      replace.add(newList[i]);
    }

    await _preferences.setStringList(_keyAgeP, replace);
  }

  static Future editPeoplePic(String path, int index) async {
    List<String>? newList = getPeoplePic();
    List<String> replace = [];
    for(int i = 0; i < index; i++){
      replace.add(newList![i]);
    }
    replace.add(path);
    for(int i = index + 1; i < newList!.length; i++){
      replace.add(newList[i]);
    }

    await _preferences.setStringList(_keyPicP, replace);
  }

  static Future resetPics() async {
    await _preferences.setStringList(_keyPicPersonal, []);
  }

  static Future addAllPicsEnd(String path) async {
    if(getPeoplePicPersonal() == null){
      await _preferences.setStringList(_keyPicPersonal, [path + "|||"]);
    }else{
      List<String>? newList = getPeoplePicPersonal();
      newList?.add(path + "|||");
      await _preferences.setStringList(_keyPicPersonal, newList!);
    }
  }

  static Future addOnePics(String path, int index) async {
    if(getPeoplePicPersonal() == null || getPeoplePicPersonal() == []){
      await _preferences.setStringList(_keyPicPersonal, [path]);
    }else{
      List<String>? newList = getPeoplePicPersonal();
      (newList?[index] = (newList[index] + path + "|||"));
      await _preferences.setStringList(_keyPicPersonal, newList!);
    }
  }

  static Future editOnePics(String path, int index, int num) async {
    List<String>? newList = getPeoplePicPersonal();
    List<String>? rep = newList?[index].split("|||");
    String replace = "";
    List<String> replace1 = [];
    int? len = rep?.length;
    for(int i = 0; i < num; i++){
      if(rep![i] != ""){
        replace += rep[i] + "|||";
      }
    }
    replace += path + "|||";
    for(int i = num + 1; i < len!; i++){
      if(rep![i] != ""){
        replace += rep[i] + "|||";
      }
    }
    for(int i = 0; i < index; i++){
      replace1.add(newList![i]);
    }
    replace1.add(replace);
    for(int i = index + 1; i < newList!.length; i++){
      replace1.add(newList[i]);
    }
    
    await _preferences.setStringList(_keyPicPersonal, replace1);
  }

  static Future deleteOnePic(int index, int num) async {
    List<String>? newList = getPeoplePicPersonal();
    List<String>? rep = newList?[index].split("|||");
    String replace = "";
    List<String> replace1 = [];
    int? len = rep?.length;
    for(int i = 0; i < num; i++){
      if(rep![i] != ""){
        replace += rep[i] + "|||";
      }
    }
    //replace += path + "|||";
    for(int i = num + 1; i < len!; i++){
      if(rep![i] != ""){
        replace += rep[i] + "|||";
      }
    }
    for(int i = 0; i < index; i++){
      replace1.add(newList![i]);
    }
    replace1.add(replace);
    for(int i = index + 1; i < newList!.length; i++){
      replace1.add(newList[i]);
    }

    await _preferences.setStringList(_keyPicPersonal, replace1);
  }

  static List<String>? getPeoplePicPersonal() => _preferences.getStringList(_keyPicPersonal);

  static void deletePeople(int index) async {
    await _preferences.setInt(_keyNumP, getPeopleNum()! - 1);

    List<String>? newList = getPeopleName();
    List<String> replace = [];
    for(int i = 0; i < index; i++){
      replace.add(newList![i]);
    }
    for(int i = index + 1; i < newList!.length; i++){
      replace.add(newList[i]);
    }

    await _preferences.setStringList(_keyNameP, replace);

    newList = getPeoplePic();
    replace = [];
    for(int i = 0; i < index; i++){
      replace.add(newList![i]);
    }
    for(int i = index + 1; i < newList!.length; i++){
      replace.add(newList[i]);
    }

    await _preferences.setStringList(_keyPicP, replace);

    newList = getPeoplePicPersonal();
    replace = [];
    for(int i = 0; i < index; i++){
      replace.add(newList![i]);
    }
    for(int i = index + 1; i < newList!.length; i++){
      replace.add(newList[i]);
    }

    await _preferences.setStringList(_keyPicPersonal, replace);

    newList = getPeopleAge();
    replace = [];
    for(int i = 0; i < index; i++){
      replace.add(newList![i]);
    }
    for(int i = index + 1; i < newList!.length; i++){
      replace.add(newList[i]);
    }

    await _preferences.setStringList(_keyAgeP, replace);
  }

  // //Daily
  //
  // static Future lastAccess() async{
  //   if(getMillisecLastAccess() == null){
  //     await _preferences.setInt(_keyLastAccess, DateTime.now().millisecondsSinceEpoch);
  //   }
  // }
  //
  // static int? getMillisecLastAccess(){
  //   return _preferences.getInt(_keyLastAccess);
  // }
  //
  // static DateTime getLastAccess(){
  //   return DateTime.fromMillisecondsSinceEpoch(getMillisecLastAccess()!);
  // }
  //
  // static bool opened(){
  //   return getLastAccess().isAfter(DateTime.now());
  // }


}