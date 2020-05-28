import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttermazegame/Views/base/baseView.dart';
import 'package:fluttermazegame/Views/base/viewSwtichMessage.dart';
import 'package:fluttermazegame/Views/levelBackground.dart';
import 'package:fluttermazegame/game.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LevelScreen extends StatefulWidget {
  @override
  _LevelScreenState createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  FlutterMazeGame game;
  final widthController = TextEditingController();
  final heightController = TextEditingController();

  int savedHeight = 8;
  int savedWidth = 8;
  int selectedLevel;

  @override
  void initState() {
    super.initState();
    selectedLevel = 1;
    game = FlutterMazeGame(startView: GameView.Options);
    game.blockResize = true;
    loadSettings();
  }

  Future loadSettings() async{
    var prefs = await SharedPreferences.getInstance();
    savedHeight = prefs.getInt("maze_height") ?? 8;
    savedWidth = prefs.getInt("maze_width") ?? 8;
    widthController.text = savedWidth.toString();
    heightController.text = savedHeight.toString();
  }

  void validateInput(TextEditingController controller, int savedValue) {
    var result = toInt(controller.text, defaultValue: -1);

    if ((result < 1 || result > 16) && controller.text.isNotEmpty) {
      controller.text = savedValue.toString();
      controller.selection = TextSelection(
        baseOffset: controller.text.length,
        extentOffset: controller.text.length,
      );
    } else {
      //try reloading
      rebuildMaze();
    }
  }

  void rebuildMaze() {
    var width = toInt(widthController.text);
    var height = toInt(heightController.text);
    if (height != null && width != null) {
      setState(() {
        var newSize = LevelBackgroundMessage(width, height);
        var msg = ViewSwitchMessage();
        msg.userData = newSize;
        game.sendMessageToActiveState(msg);
      });
    }
  }

  int toInt(String value, {int defaultValue, int radix = 10}) {
    try {
      return int.parse(value, radix: radix);
    } catch (error) {
      return defaultValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.amber,
      body: Stack(
        children: <Widget>[
          game?.widget ?? SizedBox(),
//          ButtonBar(
//            alignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Radio(value: 1, groupValue: 0, onChanged: null)
//            ],
//          )
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  color: Colors.grey,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Easy",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 4,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          ),

                          Expanded(
                            child: Text(
                              "Width",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 4,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: SizedBox(),
                          ),
                          Expanded(
                            flex: 1,
                            child: Radio(value: 1, groupValue: 0, onChanged: null),
                          ),
                          Expanded(
                            flex: 2,
                            child: SizedBox(),
                          ),
                          Expanded(
                            flex: 1,
                            child: Radio(value: 1, groupValue: 0, onChanged: null),
                          ),
                          Expanded(
                            flex: 2,
                            child: SizedBox(),
                          ),
                          Expanded(
                            flex: 1,
                            child: Radio(value: 1, groupValue: 0, onChanged: null),
                          ),
                          Expanded(
                            flex: 2,
                            child: SizedBox(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text("Save"),
                      onPressed: () async {
                        var prefs = await SharedPreferences.getInstance();
                        await prefs.setInt("maze_width", toInt(widthController.text,defaultValue: 8));
                        await prefs.setInt("maze_height", toInt(heightController.text,defaultValue: 8));
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextField _getFormatedTextField(TextEditingController controller,int savedValue) {
    return TextField(
      autofocus: false,
      autocorrect: false,
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly
      ],
      style: TextStyle(
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
      onChanged: (s) => validateInput(controller, savedValue),
    );
  }
}
