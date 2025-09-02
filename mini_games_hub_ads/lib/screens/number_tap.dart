import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';

class NumberTapScreen extends StatefulWidget {
  @override
  _NumberTapScreenState createState() => _NumberTapScreenState();
}

class _NumberTapScreenState extends State<NumberTapScreen> {
  int score = 0;
  int target = 0;
  Timer? timer;
  int timeLeft = 15;
  Random rnd = Random();

  @override
  void initState() {
    super.initState();
    _startRound();
  }

  void _startRound() {
    setState(() {
      score = 0;
      timeLeft = 15;
      target = rnd.nextInt(9) + 1;
    });
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds:1), (t) {
      setState(() {
        timeLeft--;
        if (timeLeft <= 0) {
          timer?.cancel();
        }
      });
    });
  }

  void _tapNumber(int n) {
    if (timeLeft <= 0) return;
    if (n == target) {
      setState(() {
        score += 10;
        target = rnd.nextInt(9) + 1;
      });
    } else {
      setState(() {
        score = max(0, score - 2);
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Tap'),
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: _startRound),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 12),
          Text('Tap the target number:', style: TextStyle(fontSize: 18)),
          Text('\$target', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
          Text('Time: \$timeLeft  Score: \$score', style: TextStyle(fontSize: 16)),
          Expanded(
            child: GridView.count(
              padding: EdgeInsets.all(20),
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: List.generate(9, (i) {
                return ElevatedButton(
                  onPressed: () => _tapNumber(i+1),
                  child: Text((i+1).toString(), style: TextStyle(fontSize: 24)),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}