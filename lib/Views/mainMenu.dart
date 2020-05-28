import 'package:flutter/material.dart';
import 'package:fluttermazegame/Views/base/baseView.dart';
import 'package:fluttermazegame/Views/level.dart';
import 'package:fluttermazegame/game.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  FlutterMazeGame game;
  @override
  void initState() {
    super.initState();
    game = FlutterMazeGame(startView: GameView.MainMenuBackground);
    game.blockResize = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: Stack(
        children: <Widget>[
          game.widget,
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Flutter Maze",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    letterSpacing: 4,
                    color: Colors.white),
                ),
                Text(
                  "Game",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      letterSpacing: 6,
                      color: Colors.white),
                ),
                Text(''),
                RaisedButton(
                    child: Text("Play"),
                    onPressed: () async {
                      game.pauseGame = true; //Stop anything in our background
                      await Navigator.push(
                          context,
                          new MaterialPageRoute(builder: (context) => GameWidget()));
                      game.pauseGame = false; //Restart it when the screen finishes
                    }),
                RaisedButton(
                    child: Text("Level"),
                    onPressed: () async {
                      game.pauseGame = true; //Stop anything in our background
                      await Navigator.push(
                          context,
                          new MaterialPageRoute(builder: (context) => LevelScreen()));
                      game.pauseGame = false;
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
