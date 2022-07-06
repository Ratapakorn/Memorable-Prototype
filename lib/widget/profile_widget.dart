import 'dart:io';

import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;
  final bool isEdit;
  final bool hasSymbol;
  final bool center;

  const ProfileWidget({Key? key, required this.imagePath, required this.onClicked, this.isEdit = false, this.hasSymbol = true, this.center = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return center ? Center(
      child: Stack(children: [
        buildImage(),
        Positioned(
          bottom: 0,
          right: 4,
          child: buildEditIcon(color)
        ),
      ],
      ),
    )
    :
    Stack(children: [
      buildImage(),
      Positioned(
          bottom: 0,
          right: 4,
          child: buildEditIcon(color)
      ),
    ],
    );
  }

  Widget buildImage() {
    final image = imagePath.contains("https://")
      ? NetworkImage(imagePath)
      : FileImage(File(imagePath));

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image as ImageProvider,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: onClicked,),
        ),
      )

    );
  }

  Widget buildEditIcon(Color color) => hasSymbol ? buildCircle(
    color: Colors.white,
    all: 3,
    child: buildCircle(
      color: color,
      all: 8,
      child: Icon(
        isEdit ? Icons.add_a_photo : Icons.edit,
        size: 20,
        color: Colors.white,
      ),
    ),
  ) : Container();

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          color: color,
          padding: EdgeInsets.all(all),
          child: child,
        ),
      );
}
