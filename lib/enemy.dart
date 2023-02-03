import 'package:pacman_flutter/direction.dart';

class Enemy {
  
  MoveDirection direction;
  int position;

  Enemy({ 
    this.direction = MoveDirection.RIGTH, 
    required this.position
  });

}