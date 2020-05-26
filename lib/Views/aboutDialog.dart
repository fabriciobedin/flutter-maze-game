import 'package:flutter/material.dart';

class AboutMazeBallDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      title: Text(
        "About Maze Ball",
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25.0),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text("Made with Flutter, Falme and Box2D by Christian Muehle. "
              "Simply move your phone to guide the ball through the maze"),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
