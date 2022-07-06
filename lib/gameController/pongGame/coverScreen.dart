import 'package:flutter/material.dart';

class CoverScreen extends StatelessWidget {
  // const CoverScreen({Key? key}) : super(key: key);
  final bool gameStarting;

  CoverScreen({required this.gameStarting});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const Alignment(0, -0.2),
      child: gameStarting ? const Text("") : const Text(
        "T A P  T O  P L A Y",
        style: TextStyle(
          fontFamily: "bits",
          fontSize: 12,
          color: Colors.white
        ),
      ),
    );
  }
}
