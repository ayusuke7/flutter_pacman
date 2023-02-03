
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pacman_flutter/direction.dart';
import 'package:pacman_flutter/enemy.dart';
import 'package:pacman_flutter/ghost.dart';
import 'package:pacman_flutter/levels.dart';
import 'package:pacman_flutter/pixel.dart';
import 'package:pacman_flutter/player.dart';


class BoardGame extends StatefulWidget {
  const BoardGame({super.key});

  @override
  State<BoardGame> createState() => _BoardGameState();
}

class _BoardGameState extends State<BoardGame> {
  MoveDirection direction = MoveDirection.RIGTH;
  
  static Level level = Levels.one();

  List<int> foods = level.paths;
  List<Enemy> enemys = [ 
    Enemy(position: 12, direction: MoveDirection.DOWN),
    Enemy(position: 20, direction: MoveDirection.DOWN),
    Enemy(position: 93, direction: MoveDirection.LEFT),
    Enemy(position: 148, direction: MoveDirection.RIGTH),
  ];

  bool started = false;
  Duration fps = const Duration(milliseconds: 200);

  int playerPosition = 144;
  int score = 0;

  void _start() {
    setState(() { started = true; });
    Timer.periodic(fps, _update);
  }

  void _update(Timer timer) {

    _moveEnemys();

    if(foods.contains(playerPosition)){
      foods.remove(playerPosition);
      setState(() { score++; });
    }

    if(enemys.any((e)=> e.position == playerPosition)){
      timer.cancel();
      setState(() { started = false; });
      return;
    }
  }

  void _moveLeft() {
    if(level.board[playerPosition - 1] > 0){
      setState(() {
        playerPosition--;
        direction = MoveDirection.LEFT;
      });
    }
  }

  void _moveRight() {
    if(level.board[playerPosition + 1] > 0){
      setState(() {
        playerPosition++;
        direction = MoveDirection.RIGTH;
      });
    }
  }

  void _moveUp() {
    if(level.board[playerPosition - level.cols] > 0){
      setState(() {
        playerPosition -= level.cols;
        direction = MoveDirection.UP;
      });
    }
  }

  void _moveDown() {
    if(level.board[playerPosition + level.cols] > 0){
      setState(() {
        playerPosition += level.cols;
        direction = MoveDirection.DOWN;
      });
    }
  }

  void _moveEnemys() {

    for(var i=0; i<enemys.length; i++) {
      var enemy = enemys[i];
      var pos = enemy.position;
      var dir = enemy.direction;

      if(dir == MoveDirection.RIGTH) {
        if(level.board[pos + 1] > 0) {
          enemy.position++;
        } else {
          enemy.direction = MoveDirection.LEFT;
        }
      }else 
      if(dir == MoveDirection.LEFT) {
        if(level.board[pos - 1] > 0) { 
          enemy.position--;
        } else {
          enemy.direction = MoveDirection.RIGTH;
        }
      }else 
      if(dir == MoveDirection.UP) {
        if(level.board[pos - level.cols] > 0) { 
          enemy.position -= level.cols;
        }else {
          enemy.direction = MoveDirection.DOWN;
        }
      }else 
      if(dir == MoveDirection.DOWN){
        if(level.board[pos + level.cols] > 0) { 
          enemy.position += level.cols;
        }else {
          enemy.direction = MoveDirection.UP;
        }
      }
    }
    
    setState(() { });
  }

  void _movePlayer() {
    switch (direction) {
      case MoveDirection.UP: _moveUp(); break;
      case MoveDirection.DOWN: _moveDown(); break;
      case MoveDirection.LEFT: _moveLeft(); break;
      case MoveDirection.RIGTH: _moveRight(); break;
      default:
    } 
  }

  void _onVerticalDragUpdate(DragUpdateDetails details){
    if(details.delta.dy > 0){
      _moveDown();
    } else {
      _moveUp();
    }
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details){
    if(details.delta.dx > 0){
      _moveRight();
    } else {
      _moveLeft();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 20.0
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("SCORE: $score", style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                )),
                const Text("TIME", style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                )),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: level.length,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: level.cols
              ), 
              itemBuilder: (BuildContext ctx, int index) {
                if(playerPosition == index){
                  return Pixel(
                    child: Player(
                      direction: direction
                    ),
                  );
                }else
                if(level.board[index] == 0) {
                  return Pixel(
                    color: Colors.grey[700]
                  );
                }else 
                if(enemys.any((e) => e.position == index)){
                  return const Pixel(
                    child: Ghost(),
                  );
                }else
                if(foods.contains(index)) {
                  return const Pixel(
                    child: Icon(Icons.circle,
                      color: Colors.yellow,
                      size: 20.0,
                    ),
                  );
                }else{
                  return const Pixel();
                }
              }
            )
          ),
          Container(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  color: Colors.white,
                  onPressed: _moveLeft, 
                  icon: const Icon(Icons.arrow_circle_left),
                  iconSize: 40,
                ),
                IconButton(
                  color: Colors.white,
                  onPressed: _moveRight, 
                  icon: const Icon(Icons.arrow_circle_right),
                  iconSize: 40,
                ),
                IconButton(
                  color: Colors.white,
                  onPressed: _moveUp, 
                  icon: const Icon(Icons.arrow_circle_up),
                  iconSize: 40,
                ),
                IconButton(
                  color: Colors.white,
                  onPressed: _moveDown, 
                  icon: const Icon(Icons.arrow_circle_down),
                  iconSize: 40,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}