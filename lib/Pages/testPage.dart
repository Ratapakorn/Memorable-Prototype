import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:senex/Pages/test.dart';


class testPage extends StatefulWidget {
  const testPage({Key? key}) : super(key: key);

  @override
  _testPageState createState() => _testPageState();
}

class _testPageState extends State<testPage> {
  List<String>? datas = [];
  String? _data;
  int? len;
  List<int> index = [];
  List<String> answers = ["", "", "", "", ""];
  var controller = TextEditingController();
  int currentVal = 0;

  Future<void> _loadData() async {

    final _loadedData = await DefaultAssetBundle.of(context).loadString('assets/ImportantTexts/Questions.txt'); //rootBundle.loadString('assets/ImportantTexts/Questions.txt');
    setState(() {
      _data = _loadedData;
      datas = _data?.split("\n");
      len = datas?.length;
      bool end = false;
      int num = 0;
      bool found = false;
      while(!end){
        found = false;
        num = num + 1;
        var rand = new Random();

        int min = 0;
        int? max = len;

        int result = min + rand.nextInt(max! - min);

        for(int j = 0; j < index.length; j++){
          if(index[j] == result){
            num = num - 1;
            found = true;
          }
        }

        if(!found){
          index.add(result);
        }

        if(num == 5){
          end = true;
        }
      }
      print(index);

    }

    );
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
      backgroundColor: Color.fromRGBO(255, 188, 98, 1.0),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(173, 111, 5, 1.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(height: 20,),
            //for(int i = 0; i < 5; i++)
              Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(_data == null ? 'Nothing to show' : "Question #" + (currentVal + 1).toString() + ": " + datas![index[currentVal]],
                          style: const TextStyle(fontFamily: "Robotto", fontSize: 24, color: Color.fromRGBO(
                              54, 83, 54, 1.0), fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                    ),
                  ),
                  Container(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: controller,
                      style: TextStyle(fontFamily: "Robotto", fontSize: 25),
                      textAlign: TextAlign.center,
                      decoration: new InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        hintText: "Answer"
                      ),
                      // onChanged: (){
                      //   setState(() {
                      //
                      //   });
                      // },
                    ),
                  ),
                  Container(height: 20,),
                  // Center(child: Icon(Icons.keyboard_return)),
                ],
              ),
              SizedBox(
                height: 140,
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  children: [
                    ElevatedButton(onPressed: (){
                      //Navigator.of(context).push(MaterialPageRoute(builder: (context) => Test()));
                      setState(() {
                        answers[currentVal] = controller.text;
                        if(currentVal > 0){
                          currentVal = currentVal - 1;
                          controller.text = answers[currentVal];
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(primary: Color.fromRGBO(173, 111, 5, 1.0),),
                    child: Center(child: Icon(Icons.keyboard_arrow_left, size: 70, color: Colors.white,))),
                    // Container(height: 20,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Color.fromRGBO(173, 111, 5, 1.0),),
                      onPressed: (){
                      //Navigator.of(context).push(MaterialPageRoute(builder: (context) => Test()));
                        setState(() {
                          answers[currentVal] = controller.text;
                          if(currentVal < 4){
                            currentVal = currentVal + 1;
                            controller.text = answers[currentVal];
                          }
                        });
                    }, child: Center(child: Icon(Icons.keyboard_arrow_right, size: 70, color: Colors.white,))),
                    //Container(height: 20,),
                  ],
                ),
              ),
            Container(
              height: 20,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: TextButton(onPressed: (){
                print(answers);
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Test()));
              },
              style: ElevatedButton.styleFrom(primary: Color.fromRGBO(173, 111, 5, 1.0)),
              child: Center(child: Icon(Icons.keyboard_return, size: 70, color: Colors.white,))),
            ),

          ],
        ),
      ),
    );
  }
}
