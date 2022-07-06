import 'dart:async';

import 'package:flutter/material.dart';
import 'package:senex/gameController/pongGame/ball.dart';
import 'package:senex/gameController/pongGame/brick.dart';
import 'package:senex/gameController/pongGame/coverScreen.dart';
import 'package:senex/widget/appbar_widget.dart';

class Pong extends StatefulWidget {
  const Pong({Key? key}) : super(key: key);

  @override
  _PongState createState() => _PongState();
}

enum direction { UP , DOWN, LEFT, RIGHT}

class _PongState extends State<Pong> {
  double playerX = -0.2;
  double brickWidth = 0.4;
  double playerScore = 0;

  double enemyX = 0.2;
  double enemyScore = 0;
  //double brickWidth

  double ballX = 0;
  double ballY = 0;
  var ballYDirection = direction.DOWN;
  var ballXDirection = direction.LEFT;

  bool gameStarting = false;

  void startGame() {
    setState(() {
      gameStarting = true;
    });
    Timer.periodic(Duration(milliseconds: 1), (timer) {
      updateDirection();

      moveBall();

      moveEnemy();

      if(isPlayerDead()){
        setState(() {
          playerScore ++;
        });
       resetGame();
       timer.cancel();
      }

      if(isEnemyDead()){
        setState(() {
          enemyScore ++;
        });
        resetGame();
        timer.cancel();
      }
    });
  }

  void moveEnemy() {
    setState(() {
      enemyX = ballX;
    });
  }

  void resetGame() {
    setState(() {
      ballX = 0;
      ballY = 0;
      playerX = 0;
      enemyX = 0;
      gameStarting = false;
      ballYDirection = direction.DOWN;
      ballXDirection = direction.LEFT;
    });
  }

  bool isPlayerDead() {
    if(ballY >= 1){
      return true;
    }

    return false;
  }

  bool isEnemyDead() {
    if(ballY <= -1){
      return true;
    }

    return false;
  }

  void updateDirection() {
    setState(() {
      if(ballY >= 0.8 && playerX + brickWidth >= ballX && playerX <= ballX){
        ballYDirection = direction.UP;
      }else if(ballY <= -0.8){
        ballYDirection = direction.DOWN;
      }

      if(ballX >= 1){
        ballXDirection = direction.LEFT;
      }else if(ballX <= -1){
        ballXDirection = direction.RIGHT;
      }
    });
  }

  void moveBall(){
    setState(() {

      if(ballYDirection == direction.DOWN) {
        ballY += 0.005;
      }else if(ballYDirection == direction.UP) {
        ballY -= 0.005;
      }

      if(ballXDirection == direction.LEFT) {
        ballX -= 0.005;
      }else if(ballXDirection == direction.RIGHT) {
        ballX += 0.005;
      }
    });
  }

  void moveLeft() {
    setState(() {
      if(!(playerX - 0.1 <= -1)){
        playerX -= 0.1;
      }
    });
  }

  void moveRight() {
    setState(() {
      if(!(playerX + 0.1 >= 1)){
        playerX += 0.1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, true),
      body: Column(
        children: [
          Expanded(flex: 10, child: InkWell(
            onTap: () {
              //print("hello");
              startGame();
            },
            child: Container(
              color: Colors.black,
              child: Stack(
                children: [
                  CoverScreen(gameStarting: gameStarting,),

                  Container(
                    alignment: Alignment(0,0),
                    child: Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width / 3,
                      color: Colors.grey.shade300,
                    ),
                  ),

                  Container(
                    alignment: Alignment(0,-0.5),
                    child: Text(playerScore.toString(), style: TextStyle(color: Colors.grey.shade300, fontFamily: "bits", fontSize: 30),),
                  ),

                  Container(
                    alignment: Alignment(0,0.5),
                    child: Text(enemyScore.toString(), style: TextStyle(color: Colors.grey.shade300, fontFamily: "bits", fontSize: 30),),
                  ),

                  Brick(
                    x: enemyX,
                    y: -0.8,
                    brickWidth: brickWidth,
                    thisIsEnemy: true,
                  ),

                  Brick(
                    x: playerX,
                    y: 0.8,
                    brickWidth: brickWidth,
                    thisIsEnemy: false,
                  ),

                  Ball(
                    x: ballX,
                    y: ballY
                  )
                ],
              ),
            ),
          )
          ),

          Expanded(
              //color: Colors.grey.shade900,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      print("left");
                      moveLeft();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      color: Colors.redAccent,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      print("right");
                      moveRight();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      color: Colors.blue.shade600,
                    ),
                  ),
                ],
              )
            ),
        ],
      ),
    );
  }
}

