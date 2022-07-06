import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';

class Ball extends StatelessWidget {
  // const Ball({Key? key}) : super(key: key);


  final x;
  final y;

  Ball({this.x, this.y});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(x,y),
      child: AvatarGlow(
        endRadius: 30.0,
        child: Material(
          elevation: 8.0,
          child: CircleAvatar(
            backgroundColor: Colors.black,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white
              ),
              width: 20,
              height: 20,
            ),
            radius: 7,
          ),
        ),
      ),
    );
  }
}
