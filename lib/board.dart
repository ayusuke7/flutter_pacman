
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pacman_flutter/enemy.dart';
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
  List<int> enemys = level.enemys;

  int playerPosition = 144;
  int score = 0;
  bool started = false;

  void _start() {
    var fps = const Duration(milliseconds: 150);
    Timer.periodic(fps, _update);
  }

  void _update(Timer timer) {
    
    if(foods.contains(playerPosition)){
      foods.remove(playerPosition);
      setState(() { score++; });
    }

    if(enemys.contains(playerPosition)){
      timer.cancel();
      return;
    }

    switch (direction) {
      case MoveDirection.UP: _moveUp(); break;
      case MoveDirection.DOWN: _moveDown(); break;
      case MoveDirection.LEFT: _moveLeft(); break;
      case MoveDirection.RIGTH: _moveRight(); break;
      default:
    }
  }

  void _moveLeft() {
    if(level.board[playerPosition - 1] > 0){
      setState(() {
        playerPosition--;
      });
    }
  }

  void _moveRight() {
    if(level.board[playerPosition + 1] > 0){
      setState(() {
        playerPosition++;
      });
    }
  }

  void _moveUp() {
    if(level.board[playerPosition - level.cols] > 0){
      setState(() {
        playerPosition -= level.cols;
      });
    }
  }

  void _moveDown() {
    if(level.board[playerPosition + level.cols] > 0){
      setState(() {
        playerPosition += level.cols;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: GestureDetector(
              onVerticalDragUpdate: (details){
                if(details.delta.dy > 0){
                  direction = MoveDirection.DOWN;
                } else {
                  direction = MoveDirection.UP;
                }
              },
              onHorizontalDragUpdate: (details){
                if(details.delta.dx > 0){
                  direction = MoveDirection.RIGTH;
                } else {
                  direction = MoveDirection.LEFT;
                }
              },
              child: Container(
                color: Colors.black,
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
                      return const Pixel(
                        color: Colors.blue
                      );
                    }else 
                    if(level.board[index] == 2){
                      return const Pixel(
                        child: Enemy(),
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
                ),
              ),
            )
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: (){
                      setState(() {
                        level = Levels.two();
                        foods = level.paths;
                      });
                    }, 
                    child: Text("SCORE: $score", style: const TextStyle(
                      fontSize: 20
                    ))
                  ),
                  TextButton(
                    onPressed: _start, 
                    child: const Text("START GAME", style: TextStyle(
                      fontSize: 20
                    ))
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}