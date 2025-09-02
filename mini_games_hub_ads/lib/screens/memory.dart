import 'package:flutter/material.dart';
import 'dart:math';

class MemoryScreen extends StatefulWidget {
  @override
  _MemoryScreenState createState() => _MemoryScreenState();
}

class _MemoryScreenState extends State<MemoryScreen> {
  List<int> cards = [];
  List<bool> revealed = [];
  int? firstIndex;
  bool busy = false;
  int matches = 0;

  @override
  void initState() {
    super.initState();
    _setup();
  }

  void _setup() {
    final base = List.generate(8, (i) => i+1);
    cards = [...base, ...base];
    cards.shuffle();
    revealed = List.filled(cards.length, false);
    firstIndex = null;
    matches = 0;
    busy = false;
    setState((){});
  }

  void _tapCard(int idx) async {
    if (busy || revealed[idx]) return;
    setState(() => revealed[idx] = true);
    if (firstIndex == null) {
      firstIndex = idx;
    } else {
      busy = true;
      await Future.delayed(Duration(milliseconds: 700));
      if (cards[firstIndex!] == cards[idx]) {
        matches++;
      } else {
        revealed[firstIndex!] = false;
        revealed[idx] = false;
      }
      firstIndex = null;
      busy = false;
      if (matches == cards.length ~/ 2) {
        _showWin();
      }
      setState((){});
    }
  }

  void _showWin() {
    showDialog(context: context, builder: (_) {
      return AlertDialog(
        title: Text('You win!'),
        content: Text('Play again?'),
        actions: [
          TextButton(onPressed: () { Navigator.pop(context); _setup(); }, child: Text('Yes')),
          TextButton(onPressed: () => Navigator.pop(context), child: Text('No')),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memory Match'),
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: _setup),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 12, crossAxisSpacing: 12),
        itemCount: cards.length,
        itemBuilder: (context, idx) {
          return ElevatedButton(
            onPressed: () => _tapCard(idx),
            child: revealed[idx] ? Text(cards[idx].toString(), style: TextStyle(fontSize: 24)) : SizedBox.shrink(),
            style: ElevatedButton.styleFrom(primary: revealed[idx] ? Colors.orange[200] : Colors.indigo[100]),
          );
        },
      ),
    );
  }
}