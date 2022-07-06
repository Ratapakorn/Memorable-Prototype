import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final hor;
  final vert;
  final colR;
  final colG;
  final colB;
  const ButtonWidget({Key? key, required this.text, required this.onClicked, this.hor = 32.0, this.vert = 12.0, this.colR = 120, this.colG = 128, this.colB = 130}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: StadiumBorder(),
        onPrimary: Colors.white,
        primary: Color.fromRGBO(colR, colG, colB, 1.0),
        padding: EdgeInsets.symmetric(horizontal: hor, vertical: vert),
      ),
        onPressed: onClicked,

        child: Text(text, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'DreamOrphans'
        ),)

        //
    );
  }
}
