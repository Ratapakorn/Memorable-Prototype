import 'package:flutter/material.dart';
import 'package:senex/widget/appbar_widget.dart';

import '../Utils.dart';

class TicToe extends StatefulWidget {
  const TicToe({Key? key}) : super(key: key);

  @override
  _TicToeState createState() => _TicToeState();
}

class Player {
  static const none = '';
  static const X = 'X';
  static const O = 'O';


}

class _TicToeState extends State<TicToe> {
  static final countMatrix = 3;
  static final double size = 92;

  String lastMove = Player.none;
  late List<List<String>> matrix;

  @override
  void initState() {
    super.initState();

    setEmptyFields();
  }

  void setEmptyFields() => setState(() => matrix = List.generate(
    countMatrix,
        (_) => List.generate(countMatrix, (_) => Player.none),
  ));

  Color getBackgroundColor() {
    final thisMove = lastMove == Player.X ? Player.O : Player.X;

    return getFieldColor(thisMove).withAlpha(150);
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.black,
  //     body: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: Utils.modelBuilder(matrix, (x, value) =>),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: getBackgroundColor(),
    appBar: buildAppBar(context, true),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: Utils_TicTac.modelBuilder(matrix, (x, value) => buildRow(x)),
    ),
  );

  Widget buildRow(int x) {
    final values = matrix[x];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: Utils_TicTac.modelBuilder(
        values,
            (y, value) => buildField(x, y),
      ),
    );
  }

  Color getFieldColor(String value) {
    switch (value) {
      case Player.O:
        return Colors.black;
      case Player.X:
        return Colors.grey;
      default:
        return Colors.grey.shade800;
    }
  }

  Widget buildField(int x, int y) {
    final value = matrix[x][y];
    final color = getFieldColor(value);

    return Container(
      margin: EdgeInsets.all(4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(size, size),
          primary: color,
        ),
        child: Text(value, style: TextStyle(fontFamily: "bits", fontSize: 25),),
        onPressed: () => selectField(value, x, y),
      ),
    );
  }

  void selectField(String value, int x, int y) {
    if (value == Player.none) {
      final newValue = lastMove == Player.X ? Player.O : Player.X;

      setState(() {
        lastMove = newValue;
        matrix[x][y] = newValue;
      });

      if (isWinner(x, y)) {
        showEndDialog('Player $newValue Won');
      } else if (isEnd()) {
        showEndDialog('Undecided Game');
      }
    }
  }

  bool isEnd() =>
      matrix.every((values) => values.every((value) => value != Player.none));

  /// Check out logic here: https://stackoverflow.com/a/1058804
  bool isWinner(int x, int y) {
    var col = 0, row = 0, diag = 0, rdiag = 0;
    final player = matrix[x][y];
    final n = countMatrix;

    for (int i = 0; i < n; i++) {
      if (matrix[x][i] == player) col++;
      if (matrix[i][y] == player) row++;
      if (matrix[i][i] == player) diag++;
      if (matrix[i][n - i - 1] == player) rdiag++;
    }

    return row == n || col == n || diag == n || rdiag == n;
  }

  Future showEndDialog(String title) => showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: Center(child: Text(title, style: TextStyle(fontFamily: "bits", fontSize: 15),)),
      //content: Text('Press to Restart the Game'),
      actions: [
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
            onPressed: () {
              setEmptyFields();
              Navigator.of(context).pop();
            },
            child: Text('Restart', style: TextStyle(fontFamily: "bits", fontSize: 16),),
          ),
        )
      ],
    ),
  );

}
