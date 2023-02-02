class Levels {
  
  static final _boardOne = [
      0,0,0,0,0,0,0,0,0,0,0,
      0,2,0,1,1,0,1,1,0,1,0,
      0,1,0,1,1,1,1,1,0,1,0,
      0,1,1,1,0,1,0,1,1,1,0,
      0,1,0,1,0,1,0,1,0,1,0,
      0,0,0,0,0,1,0,0,0,0,0,
      0,1,1,1,1,1,1,1,1,1,0,
      0,1,0,1,0,0,0,1,0,1,0,
      0,1,0,1,1,2,1,1,0,1,0,
      0,1,0,0,0,0,0,0,0,1,0,
      0,1,1,1,1,0,1,1,1,1,0,
      0,1,1,0,1,0,1,0,2,1,0,
      0,1,0,0,0,0,0,0,0,1,0,
      0,1,1,1,1,2,1,1,1,1,0,
      0,0,0,0,0,0,0,0,0,0,0,
  ];

  static final _boardTwo = [
      0,0,0,0,0,0,0,0,0,0,0,
      0,1,1,1,1,1,1,1,1,1,0,
      0,1,0,1,0,1,0,1,0,1,0,
      0,1,0,1,0,1,0,1,0,1,0,
      0,1,0,1,0,1,0,1,0,1,0,
      0,1,0,0,0,1,0,0,0,1,0,
      0,1,1,1,1,1,1,1,1,1,0,
      0,1,0,1,0,0,0,1,0,1,0,
      0,1,0,1,1,1,1,1,0,1,0,
      0,1,0,0,1,0,1,0,0,1,0,
      0,1,1,0,1,0,1,0,1,1,0,
      0,1,1,0,1,0,1,0,1,1,0,
      0,1,0,0,0,0,0,0,0,1,0,
      0,1,1,1,1,1,1,1,1,1,0,
      0,0,0,0,0,0,0,0,0,0,0,
  ];

  static Level one() => Level(
    board: _boardOne,
    cols: 11
  );
  
  static Level two() => Level(
    board: _boardTwo,
    cols: 11
  );

}


class Level {

  final List<int> board;
  final int cols;

  Level({ 
    required this.board,
    required this.cols
  });

  int get length => board.length;

  int get rows => board.length ~/ cols;

  List<int> get barries => _findIndex(0);

  List<int> get paths => _findIndex(1);

  List<int> get enemys => _findIndex(2);

  List<int> _findIndex(int value) {
    var result = <int>[];
    for (var i=0; i<board.length; i++) {
      if(board[i] == value) result.add(i);
    }
    return result;
  }

}