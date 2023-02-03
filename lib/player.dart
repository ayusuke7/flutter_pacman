import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pacman_flutter/direction.dart';

class Player extends StatelessWidget {
  final MoveDir direction;

  const Player({
    super.key,
    this.direction = MoveDir.RIGTH
  });

  @override
  Widget build(BuildContext context) {
    double angle = 0.0;

    if(direction == MoveDir.LEFT){
      angle = pi;
    } else if(direction == MoveDir.DOWN){
      angle = pi / 2;
    } else if(direction == MoveDir.UP){
      angle = 3 * pi / 2;
    }

    return Transform.rotate(
      angle: angle,
      child: Image.asset('assets/imgs/pacman.png')
    );
  }
}