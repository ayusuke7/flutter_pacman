
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';

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
  MoveDir direction = MoveDir.RIGTH;
  
  static Level level = Levels.one();

  List<int> foods = level.paths;
  List<Enemy> enemys = [
    Enemy(position: 27, direction: MoveDir.DOWN),
    Enemy(position: 93, direction: MoveDir.LEFT),
    Enemy(position: 148, direction: MoveDir.RIGTH),
  ];

  bool started = false;
  bool gameOver = false;
  
  Duration fps = const Duration(milliseconds: 250);

  int playerPosition = 133;
  int score = 0;

  Timer? timer;

  void _startStop() {
    if(!started) {
      setState(() { started = true; });
      timer = Timer.periodic(fps, _update);
    } else {
      timer?.cancel();
      setState(() { started = false; });
    }
  }

  void _update(Timer t) {

    _moveEnemys();

    if(foods.contains(playerPosition)){
      foods.remove(playerPosition);
      setState(() { score++; });

      if(foods.isEmpty) {
        setState(() {
          level = Levels.two();
          foods = level.paths;
          playerPosition =  133;
        });
      }
    }

    if(enemys.any((e)=> e.position == playerPosition)){
      t.cancel();
      setState(() { started = false; });
      return;
    }
  }

  void _moveLeft() {
    if(started && level.board[playerPosition - 1] > 0){
      setState(() {
        playerPosition--;
        direction = MoveDir.LEFT;
      });
    }
  }

  void _moveRight() {
    if(started && level.board[playerPosition + 1] > 0){
      setState(() {
        playerPosition++;
        direction = MoveDir.RIGTH;
      });
    }
  }

  void _moveUp() {
    if(started && level.board[playerPosition - level.cols] > 0){
      setState(() {
        playerPosition -= level.cols;
        direction = MoveDir.UP;
      });
    }
  }

  void _moveDown() {
    if(started && level.board[playerPosition + level.cols] > 0){
      setState(() {
        playerPosition += level.cols;
        direction = MoveDir.DOWN;
      });
    }
  }

  void _moveEnemys() {

    for(var i=0; i<enemys.length; i++) {
      var enemy = enemys[i];
      var pos = enemy.position;
      var dir = enemy.direction;

      if(dir == MoveDir.RIGTH) {
        if(level.board[pos + 1] > 0) {
          enemy.position++;
        } else {
          enemy.direction = MoveDir.LEFT;
        }
      }else 
      if(dir == MoveDir.LEFT) {
        if(level.board[pos - 1] > 0) { 
          enemy.position--;
        } else {
          enemy.direction = MoveDir.RIGTH;
        } 
      }else 
      if(dir == MoveDir.UP) {
        if(level.board[pos - level.cols] > 0) { 
          enemy.position -= level.cols;
        }  else {
          enemy.direction = MoveDir.DOWN;
        }
      }else 
      if(dir == MoveDir.DOWN){
        if(level.board[pos + level.cols] > 0) { 
          enemy.position += level.cols;
        } else {
          enemy.direction = MoveDir.UP;
        }
      }

    }
    
    /* update three */
    setState(() { });
  }

  String _convertTime() {

    if(started && timer != null) {
      var ms = timer!.tick * fps.inMilliseconds;
      var d = Duration(milliseconds: ms);
      return d.inSeconds.toString();
    }

    return '0';
  }

  @override
  Widget build(BuildContext context) {
    BoxConstraints? constraints;

    if(kIsWeb || !Platform.isAndroid && !Platform.isIOS) {
      constraints = const BoxConstraints(
        maxWidth: 500
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("TIME: ${_convertTime()}", style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold
            )),
            Text("SCORE: $score", style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold
            )),
          ],
        ),
      ),
      body: Center(
        child: Container(
          constraints: constraints,
          child: Stack(
            children: [
              _buildBoardGame(),
              Align(
                alignment: Alignment.bottomCenter,
                child: _buildControls()
              ),
              if(!started) _buildOverlay(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildControls() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0
      ),
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
            onPressed: _moveDown, 
            icon: const Icon(Icons.arrow_circle_down),
            iconSize: 40,
          ),
          IconButton(
            color: Colors.white,
            onPressed: _moveUp, 
            icon: const Icon(Icons.arrow_circle_up),
            iconSize: 40,
          ),
        ],
      ),
    );
  }

  Widget _buildBoardGame() {
    return GestureDetector(
      onDoubleTap: _startStop,
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
            var e = enemys.firstWhere((e) => e.position == index);
            return Pixel(
              child: Ghost(
                direction: e.direction,
              ),
            );
          }else
          if(foods.contains(index)) {
            return const Pixel(
              child: Icon(Icons.circle,
                color: Colors.yellow,
                size: 15.0,
              ),
            );
          }else{
            return const Pixel();
          }
        }
      ),
    );
  }

  Widget _buildOverlay() {
    var fixedSize = const Size(130, 40);
    var textStyle = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold
    );
    return Container(
      color: Colors.black.withOpacity(.5),
      constraints: const BoxConstraints.expand(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow,
              foregroundColor: Colors.black,
              fixedSize: fixedSize,
              textStyle: textStyle,
            ),
            child: const Text('PLAY'),
            onPressed: (){
              _startStop();
            }, 
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              fixedSize: fixedSize,
              textStyle: textStyle,
            ),
            child: const Text('RESTART'),
            onPressed: (){
            }, 
          )
        ],
      ),
    );
  }
}