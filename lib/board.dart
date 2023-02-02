
import 'package:flutter/material.dart';

class BoardGame extends StatefulWidget {
  const BoardGame({super.key});

  @override
  State<BoardGame> createState() => _BoardGameState();
}

class _BoardGameState extends State<BoardGame> {
  static int numOfRows = 11;
  int numOfSquares = numOfRows * 15;
  int playerPosition = 12;

  List<int> barries = [
    0,0,0,0,0,0,0,0,0,0,0,
    0,1,0,1,1,0,1,1,0,1,0,
    0,1,0,1,1,1,1,1,0,1,0,
    0,1,1,1,0,1,0,1,1,1,0,
    0,1,0,1,0,1,0,1,0,1,0,
    0,0,0,0,0,1,0,0,0,0,0,
    0,1,1,1,1,1,1,1,1,1,0,
    0,1,0,1,0,0,0,1,0,1,0,
    0,1,0,1,1,1,1,1,0,1,0,
    0,1,0,0,0,0,0,0,0,1,0,
    0,1,1,1,1,0,1,1,1,1,0,
    0,1,1,0,1,0,1,0,1,1,0,
    0,1,0,0,0,0,0,0,0,1,0,
    0,1,1,1,1,1,1,1,1,1,0,
    0,0,0,0,0,0,0,0,0,0,0,
  ];



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              color: Colors.black,
              child: GridView.builder(
                itemCount: numOfSquares,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: numOfRows
                ), 
                itemBuilder: (BuildContext ctx, int index) {
                  if(playerPosition == index){
                    return Container(
                      padding: const EdgeInsets.all(10),
                      child: const Icon(Icons.face_2, 
                        color: Colors.yellow
                      ),
                    );
                  }else
                  if(barries[index] > 0) {
                    return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      color: Colors.grey,
                      child: Text(index.toString()),
                    );
                  }else {
                    return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      color: Colors.blue,
                      child: Text(index.toString()),
                    );
                  }
                }
              ),
            )
          ),
          Expanded(
            child: Container(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}