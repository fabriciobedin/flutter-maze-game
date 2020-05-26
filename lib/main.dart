import 'package:flame/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttermazegame/Views/mainMenu.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences sharedPrefs;
Util flameUtil;

void main() async {
  await setupFlame();
  runApp(App());
}

Future setupFlame() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPrefs = await SharedPreferences.getInstance();
  flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(
      DeviceOrientation.portraitUp);
 
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StartScreen(),
    );
  }
}

