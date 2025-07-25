import 'package:flutter/material.dart';

class Brick extends StatelessWidget {
  // const Brick({Key? key}) : super(key: key);

  final x;
  final y;
  final brickWidth;
  final thisIsEnemy;

  Brick({this.x, this.y, this.brickWidth, this.thisIsEnemy});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(x,y),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          color: thisIsEnemy ? Colors.grey : Colors.white,
          height: 20,
          width: MediaQuery.of(context).size.width * brickWidth / 2,
        ),
      ),
    );
  }
}
