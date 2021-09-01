import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

void main() {
  final myGame = MyGame();
  runApp(GameWidget(game: myGame));
}

class MyGame extends Game {
  static const int squareSpeed = 200;

  // ball stuff
  late Rect ball;
  int ballDirX = 1;
  int ballDirY = 1;
  Paint ballPaint = BasicPalette.white.paint();

  late Rect topWall;
  late Rect leftWall;
  late Rect rightWall;
  late Rect bottomWall;

  late double wallSize;
  late double wallStroke;

  static final wallPaint = BasicPalette.magenta.paint();

  @override
  Future<void> onLoad() {
    wallSize = size.x * 0.8;
    wallStroke = 10;

    double wallLeftPos = size.x / 2 - wallSize / 2;
    double wallTopPos = size.y / 2 - wallSize / 2;
    double wallRightPos = size.x / 2 + wallSize / 2;

    topWall = Rect.fromLTWH(wallLeftPos, wallTopPos, wallSize, wallStroke);
    leftWall = Rect.fromLTWH(wallLeftPos, wallTopPos, wallStroke, wallSize);
    rightWall = Rect.fromLTWH(wallRightPos, wallTopPos, wallStroke, wallSize);
    bottomWall = Rect.fromLTWH(
        wallLeftPos, wallTopPos + wallSize, wallSize + wallStroke, wallStroke);

    ball = Rect.fromLTWH(leftWall.right + 10, size.y / 2, 10, 10);

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(ball, ballPaint);

    canvas.drawRect(topWall, wallPaint);
    canvas.drawRect(leftWall, wallPaint);
    canvas.drawRect(rightWall, wallPaint);
    canvas.drawRect(bottomWall, wallPaint);
  }

  @override
  void update(double dt) {
    handleMovement(dt);
  }

  void handleMovement(double dt) {
    ball = ball.translate(
        squareSpeed * ballDirX * dt, squareSpeed * ballDirY * dt);
    if (ballDirX == 1 && ball.right > rightWall.left) {
      ballDirX = -1;
    } else if (ballDirX == -1 && ball.left < leftWall.right) {
      ballDirX = 1;
    } else if (ballDirY == 1 && ball.bottom > bottomWall.top) {
      ballDirY = -1;
    } else if (ballDirY == -1 && ball.top < topWall.bottom) {
      ballDirY = 1;
    }
  }
}

class Position {
  late double x;
  late double y;
  Position(this.x, this.y);
}

class Ball {
  late Position position;
  late double width;
  late double height;
  late Paint color;

  Ball(this.position, this.width, this.height, this.color);

  Rect render() {
    return Rect.fromLTWH(position.x, position.y, width, height);
  }

  void move(Rect oldBall, double x, double y) {
    oldBall.translate(x, y);
  }
}
