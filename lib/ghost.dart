import 'package:flutter/material.dart';
import 'package:pacman_flutter/direction.dart';

class Ghost extends StatelessWidget {
  final MoveDir direction;
  
  const Ghost({
    super.key,
    this.direction = MoveDir.RIGTH
  });

  @override
  Widget build(BuildContext context) {
    double scaleX = 1;

    if(
      direction == MoveDir.LEFT || 
      direction == MoveDir.UP
    ) {
      scaleX = -1;
    }

    return Transform.scale(
      scaleX: scaleX,
      child: Image.asset('assets/imgs/red-enemy.png')
    );
  }
}
