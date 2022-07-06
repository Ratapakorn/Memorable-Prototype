
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
//import 'package:flutter_icons/';
import 'package:flip_card/flip_card.dart';
import "dart:math" show pi;

import 'package:senex/Pages/gamePage.dart';

class memG1 extends StatefulWidget {
  const memG1({Key? key}) : super(key: key);

  @override
  _memG1State createState() => _memG1State();
}

class _memG1State extends State<memG1> {
  //static var deck;

  @override
  Widget build(BuildContext context) {
    glow(Color c, double r) => [
      Shadow(offset: Offset(-r, -r), color: c),
      Shadow(offset: Offset(r, -r), color: c),
      Shadow(offset: Offset(r, r), color: c),
      Shadow(offset: Offset(-r, r), color: c)
    ];

    gameButton(String title, int cols, int rows) {
      var deck = List.generate(54, (i) => i)
        ..shuffle()
        ..removeRange((cols * rows) ~/ 2, 54);
      deck = (deck + deck)..shuffle();
      return Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(

          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),

          child: TextButton(
            //padding: EdgeInsets.all(25),
            child: Text(title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontFamily: "Robotto",
                  //fontWeight: FontWeight.bold,
                  //shadows: glow(Colors.black, 3),
                )),
            onPressed: () {
              //print(deck);
              Navigator.push(context, MaterialPageRoute(builder: (context) => Game(cols: cols, rows: rows, deck: deck)));
            },
          ),
        ),
      );
    }

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
                child: Text("Difficulty",
                    style: TextStyle(fontFamily: "Robotto",
                        fontSize: 60.0, color: Colors.white, ))), //fontWeight: FontWeight.bold, //shadows: glow(Colors.grey[300]!, 3)))),
            gameButton("Easy", 3, 4),
            gameButton("Medium", 4, 5),
            gameButton("Hard", 5, 8),
            gameButton("Advanced", 6, 9),
          ],
        ),
      ),
    );
  }
}

class Game extends HookWidget {
  Game({Key? key, required this.cols, required this.rows, required this.deck}) : super(key: key);
  final int cols;
  final int rows;
  final List<int> deck;
  var play = [];
  var over = [];
  var wins = [];
  
  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  //
  // void showInSnackBar(String value){
  //
  //   //_scaffoldKey.currentState?.showSnackBar(new SnackBar(content: new Text("Hello")));
  // }
  
  // void showInSnackBar(String value) {
  //   Scaffold.of(context).showSnackBar(snackbar)
  // }


  board(BuildContext context) {
    var cell = (int r, int c) {
      var id = r * cols + c;
      var cb = (AnimationController ctrl) => () {
        if (wins.contains(id) || play.contains(id)) return;
        if (play.isEmpty || play.length == 1 && play[0] != id) {
          play.add(id);
          over.add(ctrl);
          ctrl.forward();
        } else
          return;
        if (play.length == 2) {
          if (deck[play[0]] != deck[id]) {
            Stream.periodic(Duration(milliseconds: 1500)).take(1).listen((_) {
              over[0].reverse();
              over[1].reverse();
              play = [];
              over = [];
            });
          } else {
            wins += play;
            play = [];
            over = [];
            if (wins.length == deck.length){
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
                    top: 10.0,
                  ),
                  title: Text("You Won!!!"),
                  content: TextButton(onPressed: () async {
                    Navigator.pop(context);
                    await Navigator.of(context).push(MaterialPageRoute(builder: (context) => gamePage()));
                  }, child: Icon(Icons.arrow_back_ios),),
                );
              });
              //ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: new Text("Hello")));
            }
            //
          }
        }
      };
      return Expanded(child: Card(id: deck[id], onTap: cb));
    };
    var brd = List.generate(rows, (r) => List.generate(cols, (c) => cell(r, c)))
        .map((cards) => Expanded(child: Row(children: cards, mainAxisAlignment: MainAxisAlignment.spaceEvenly)))
        .toList();
    return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: brd);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(color: Colors.black54, child: board(context)));
  }
}

class Card extends HookWidget {
  Card({Key? key, required this.id, required this.onTap}) : super(key: key);
  final int id;
  final Function onTap;

  // int getID(int id){
  //
  // }

  IconData getIcon(int id){
    if(id == 0){
      return Icons.accessibility_new;
    }else if(id == 1){
      return Icons.account_balance;
    }else if(id == 2){
      return Icons.adb;
    }else if(id == 3){
      return Icons.add_location;
    }else if(id == 4){
      return Icons.add_outlined;
    }
    return Icons.add_reaction;
  }


  _card(bool front) => Container(
      padding: EdgeInsets.all(5),
      child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15.0)), color: Colors.white),
          padding: front ? EdgeInsets.all(5) : EdgeInsets.all(0),
          child: FittedBox(child: front ? Center(child: (Text(id.toString(), style: TextStyle(color: Colors.grey, fontFamily: "Robotto", fontWeight: FontWeight.bold), ))) : ClipRRect(borderRadius: BorderRadius.circular(15),child: Image.asset("assets/images/back.png", fit: BoxFit.contain, height: 200, width: 200,)), ))); //FlutterIconData.octicons(61696 + id)

  @override
  Widget build(BuildContext context) {
    var ctrl = useAnimationController(duration: Duration(milliseconds: 500));
    var forwardTween = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween(begin: 0.0, end: pi / 2).chain(CurveTween(curve: Curves.linear)), weight: 50),
      TweenSequenceItem(tween: ConstantTween<double>(pi / 2), weight: 50)
    ]).animate(ctrl);
    var backwardTween = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: ConstantTween<double>(pi / 2), weight: 50),
      TweenSequenceItem(tween: Tween(begin: -pi / 2, end: 0.0).chain(CurveTween(curve: Curves.linear)), weight: 50)
    ]).animate(ctrl);

    return GestureDetector(
      onTap: onTap(ctrl),
      onLongPress: () {
        //print(_memG1State.deck);
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(fit: StackFit.expand, children: [
          AnimationCard(animation: backwardTween, child: _card(true)),
          AnimationCard(animation: forwardTween, child: _card(false)),
        ]),
      ),
    );
  }
}
