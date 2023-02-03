import 'package:pacman_flutter/direction.dart';

class Enemy {
  
  MoveDir direction;
  int position;

  Enemy({ 
    this.direction = MoveDir.RIGTH, 
    required this.position
  });

}