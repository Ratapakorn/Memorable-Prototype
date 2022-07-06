import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:senex/Pages/Reminder.dart';
import 'package:senex/utils/user_simple_preferences.dart';
import 'package:senex/widget/button_widget.dart';
import 'package:senex/widget/navigation_drawer_widget.dart';
import 'package:date_format/date_format.dart';
import 'package:senex/widget/notification_api.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class createReminder extends StatefulWidget {
  final int index;
  const createReminder({Key? key, required this.index}) : super(key: key);

  @override
  _createReminderState createState() => _createReminderState();
}

class _createReminderState extends State<createReminder> {
  @override
  int numReminder = 0;
  final controller = TextEditingController();
  String sub = "";
  String subTime = '';
  List<String> remList = [];
  List<bool> Everyday = [];
  bool _switchValue = true;
  bool onOff = true;
  List<String>? remindList = UserSimplePreferences.getReminderName();
  List<String>? timeList = UserSimplePreferences.getReminderTime();
  List<String>? boolList = UserSimplePreferences.getReminderBool();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  bool create = true;

  // print(int.parse(subTime.split(':')[0]));
  // print(int.parse(subTime.split(':')[1].split(' ')[0]));

  @override
  void initState(){
    super.initState();

    if(widget.index == -1){
      selectedTime = TimeOfDay(hour: 00, minute: 00);
      _timeController.text = formatDate(
          DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
          [HH, ':', nn]).toString();
      subTime = _timeController.text;
    }else{
      if(boolList![widget.index] == "0") {
        _switchValue = false;
      } else {
        _switchValue = true;
      }
      controller.text = remindList![widget.index];
      selectedTime = TimeOfDay(hour: int.parse(timeList![widget.index].split(':')[0]), minute: int.parse(timeList![widget.index].split(':')[1].split(' ')[0]));
      _timeController.text = formatDate(
          DateTime(2019, 08, 1, int.parse(timeList![widget.index].split(':')[0]), int.parse(timeList![widget.index].split(':')[1].split(' ')[0])),
          [HH, ':', nn]).toString(); //[hh, ':', nn, " ", am]
      subTime = _timeController.text;
      sub = remindList![widget.index];
      create = false;
    }
  }

  //late double _height;
  //late double _width;

  late String _setTime, _setDate;

  late String _hour, _minute, _time;

  late String dateTime;

  DateTime selectedDate = DateTime.now();



  final _timeController = TextEditingController();

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [HH, ':', nn]).toString();
        subTime = _timeController.text;
      });
    }}




  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        backgroundColor: Colors.black26,
        //title: Text("Settings"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 10
            ),
            Center(
              child: Text(widget.index == -1 ? "Create Reminder" : "Edit Reminder", style: TextStyle(color: Colors.white, fontSize: 30, fontFamily: "DreamOrphans")),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: controller,
                onChanged: (controller){
                  sub = controller.toString();
                },
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Short Description',
                ),
              ),
            ),

            Container(
                height: 10
            ),

            Row(
              children: [
                Container(
                    width: 10
                ),
                Text("Everyday?", style: TextStyle(color: Colors.white, fontSize: 17, fontFamily: "Robotto")),
                Container(
                    width: 20
                ),
                CupertinoSwitch(
                  value: _switchValue,
                  onChanged: (value) {
                    setState(() {

                      if(onOff == true){
                        onOff = false;
                      }else{
                        onOff = true;
                      }
                      _switchValue = value;
                      print(onOff);
                    }

                    );
                  },
                ),
              ],
            ),

            Container(
                height: 10
            ),

            Row(
              children: [
                Container(
                    width: 10
                ),
                Text("Time", style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: "Robotto")),
                Container(
                    width: 15
                ),
                InkWell(
                  onTap: () {
                    _selectTime(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 0),
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height / 11,
                    alignment: Alignment.center,
                    //decoration: BoxDecoration(color: Colors.white),
                    child: TextFormField(
                      style: TextStyle(fontSize: 25, color: Colors.white, fontFamily: "Robotto"),
                      textAlign: TextAlign.center,
                      onSaved: (String? val) {
                        _setTime = val!;
                        subTime = val;
                      },

                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: _timeController,
                      onChanged: (val){
                        subTime = val.toString();
                      },
                      decoration: InputDecoration(
                          disabledBorder:
                          UnderlineInputBorder(borderSide: BorderSide.none),
                          // labelText: 'Time',
                          contentPadding: EdgeInsets.all(5)),
                    ),
                  ),
                ),
              ],
            ),



            Container(
                height: 10
            ),

            Center(
              child: Column(
                children: [
                  ButtonWidget(onClicked: () async {
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
                  Container(
                      height: 10
                  ),
                  ButtonWidget(onClicked: () async {
                    if(create){
                      await UserSimplePreferences.addReminderNum();
                      await UserSimplePreferences.addReminderName(sub);
                      if(_switchValue == false){
                        await UserSimplePreferences.addReminderBool("0");
                      }else{
                        await UserSimplePreferences.addReminderBool("1");
                      }
                      await UserSimplePreferences.addReminderTime(subTime);
                      print(UserSimplePreferences.getReminderNum());
                      print(UserSimplePreferences.getReminderName());
                      print(UserSimplePreferences.getReminderBool());
                      print(UserSimplePreferences.getReminderTime());
                    }else{
                      await UserSimplePreferences.editReminderName(sub, widget.index);
                      if(_switchValue == false){
                        await UserSimplePreferences.editReminderBool("0", widget.index);
                      }else{
                        await UserSimplePreferences.editReminderBool("1", widget.index);
                      }
                      await UserSimplePreferences.editReminderTime(subTime, widget.index);
                    }



                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Reminder()));

                  },
                    text: 'Save',
                    colR: 255,
                    colG: 255,
                    colB: 255,
                  ),
                  Container(
                      height: 10
                  ),
                  ButtonWidget(text: "Cancel", onClicked: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Reminder()));
                  },
                  colR: 255,
                  colG: 255,
                  colB: 255,
                  ),
                  /*Container(
                      height: 10
                  ),
                  ButtonWidget(text: "Notif", onClicked: () {
                    NotificationApi.showScheduledNotification(
                      title: "Sarah Bas",
                      body: "Helllo test",
                      payload: "Sarhah",
                      hour: 12,
                      minute: 23
                    );
                    final now = tz.TZDateTime.now(tz.local);
                    print(DateTime.now().hour);
                    print(now.hour);
                    print(now.minute);
                  },
                    colR: 255,
                    colG: 255,
                    colB: 255,
                  )

                   */
                ],
              )

            )
          ],
        ),
      ),
    );
  }
}
