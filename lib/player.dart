import 'dart:math';
import 'package:flutter/material.dart';

enum MoveDirection { UP, DOWN, LEFT, RIGTH }


class Player extends StatelessWidget {
  final MoveDirection direction;

  const Player({
    super.key,
    this.direction = MoveDirection.RIGTH
  });

  @override
  Widget build(BuildContext context) {
    double angle = 0.0;

    if(direction == MoveDirection.LEFT){
      angle = pi;
    } else if(direction == MoveDirection.DOWN){
      angle = pi / 2;
    } else if(direction == MoveDirection.UP){
      angle = 3 * pi / 2;
    }

    return Transform.rotate(
      angle: angle,
      child: Image.asset('assets/imgs/pacman.png')
    );
  }
}