import 'dart:ui';
import 'package:fluttermazegame/Elements/mazeBuilder.dart';
import 'package:fluttermazegame/Views/base/baseView.dart';
import 'package:fluttermazegame/Views/base/viewSwtichMessage.dart';
import 'package:fluttermazegame/Views/viewManager.dart';
import '../main.dart';

class LevelBackgroundMessage {
  int width;
  int height;

  LevelBackgroundMessage(this.width, this.height);

  LevelBackgroundMessage.eightByEight() {
    width = 8;
    height = 8;
  }
}

class OptionBackgroundView extends BaseView {
  bool initRequired = true;
  MazeBuilder _mazeBuilder;
  OptionBackgroundView(GameView view, ViewManager viewManager)
      : super(view, viewManager);

  @override
  void moveToBackground({ViewSwitchMessage message}) {}

  @override
  void render(Canvas c) {
    _mazeBuilder?.render(c);
  }

  void initMaze() {
    var savedHeight = sharedPrefs.getInt("maze_height") ?? 8;
    var savedWidth = sharedPrefs.getInt("maze_width") ?? 8;
    _mazeBuilder = MazeBuilder(
      this.viewManager.game,
      height: savedHeight,
      width: savedWidth,
    );
    _mazeBuilder.generateMaze();
  }

  @override
  void setActive({ViewSwitchMessage message}) {
    LevelBackgroundMessage details;
    if (message?.userData is LevelBackgroundMessage) {
      details = (message.userData as LevelBackgroundMessage);
    } else {
      details = LevelBackgroundMessage.eightByEight();
    }

    if (initRequired) {
      initRequired = false;
      initMaze();
    } else {
      _mazeBuilder.resetMaze(
        width: details.width,
        height: details.height,
      );
    }
  }

  @override
  void update(double t) {}
}
