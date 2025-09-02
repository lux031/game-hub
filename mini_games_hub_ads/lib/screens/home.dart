import 'package:flutter/material.dart';
import '../ad_helper.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String,String>> games = [
    {'title': 'Tic Tac Toe', 'route': '/tictactoe'},
    {'title': 'Number Tap', 'route': '/numbertap'},
    {'title': 'Memory Match', 'route': '/memory'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mini Games Hub'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: games.map((g) {
                  return GestureDetector(
                    onTap: () => Navigator.pushNamed(context, g['route']!),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Center(
                        child: Text(g['title']!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          BannerAdWidget(), // Banner at bottom
        ],
      ),
    );
  }
}