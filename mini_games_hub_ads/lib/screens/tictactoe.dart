import 'package:flutter/material.dart';

class TicTacToeScreen extends StatefulWidget {
  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  List<String> board = List.filled(9, '');
  String current = 'X';
  String status = "Player X's turn";

  void _reset() {
    setState(() {
      board = List.filled(9, '');
      current = 'X';
      status = "Player X's turn";
    });
  }

  void _play(int idx) {
    if (board[idx] != '') return;
    setState(() {
      board[idx] = current;
      if (_checkWin(current)) {
        status = 'Player \$current wins!';
      } else if (!board.contains('')) {
        status = 'Draw';
      } else {
        current = current == 'X' ? 'O' : 'X';
        status = "Player \$current's turn";
      }
    });
  }

  bool _checkWin(String p) {
    final wins = [
      [0,1,2],[3,4,5],[6,7,8],
      [0,3,6],[1,4,7],[2,5,8],
      [0,4,8],[2,4,6],
    ];
    for (var w in wins) {
      if (board[w[0]] == p && board[w[1]] == p && board[w[2]] == p) return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: _reset),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Text(status, style: TextStyle(fontSize: 18)),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
              itemCount: 9,
              itemBuilder: (context, index) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.indigo[100]),
                  onPressed: () => _play(index),
                  child: Text(board[index], style: TextStyle(fontSize: 32, color: Colors.black87)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}