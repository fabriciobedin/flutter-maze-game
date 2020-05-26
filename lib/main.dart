import 'package:flame/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttermazegame/game.dart';

void main() async {
  await setupFlame();
  var game = new FlutterMazeGame();
  runApp(game.widget);
}

Future setupFlame() async {
  WidgetsFlutterBinding.ensureInitialized();
  var flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);
}
