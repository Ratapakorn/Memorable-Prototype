import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:senex/mainMenu.dart';
import 'package:senex/widget/navigation_drawer_widget.dart';
import 'package:senex/widget/recommendIcon_widget.dart';

class Recommend extends StatefulWidget {
  final int timeLeft;
  const Recommend({Key? key, required this.timeLeft}) : super(key: key);

  @override
  _RecommendState createState() => _RecommendState();
}

class _RecommendState extends State<Recommend> {
  String data = "";
  List<String> datas = [];
  //final page = "mainMenu";
  Future<void> _loadData() async {
    final _loadedData = await DefaultAssetBundle.of(context).loadString('assets/ImportantTexts/timeConstraint.txt');
    setState(() {
      data = _loadedData;
      datas = _loadedData.split("\n");
      print(datas[1]);
      print(datas.length);
    });

    //print(widget.timeLeft >= int.parse(_getSpecData(0, 0)));
  }

  String _getSpecData(int index, int value){
    return datas[index].split(";")[value];
  }

  Widget _getButton(int i){
    //print(int.parse(_getSpecData(i, 0)));
    if(widget.timeLeft >= int.parse(_getSpecData(i, 0))){
      //return ("pass");
      //print(_getSpecData(i, 3));
      return recommendIcon(page: _getSpecData(i, 3).replaceAll("\n", ""),name: _getSpecData(i, 1), Description: _getSpecData(i, 2), minutes: int.parse(_getSpecData(i, 0)),);
    }
    return Container(height: 0,);
    //return "";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15,),
            Center(child: Text("Recommendations", style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.04, fontFamily: "Robotto"),)),
            SizedBox(height: 15,),
            for(int i = 0; i < 2; i++)
              (_getButton(i))
              // widget.timeLeft >= int.parse(_getSpecData(i, 0)) ?
              // recommendIcon(page: "mainmenu",name: "Activity Name", Description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ullamcorper a lacus vestibulum sed arcu non odio. Nunc consequat interdum varius sit. Lacus luctus accumsan tortor posuere.", minutes: 5,)
              // : Text("Hit")

          ],
        ),
      )
    );
  }
}
