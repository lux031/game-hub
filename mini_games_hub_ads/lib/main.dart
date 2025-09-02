import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'screens/home.dart';
import 'screens/tictactoe.dart';
import 'screens/number_tap.dart';
import 'screens/memory.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  runApp(MiniGamesHubApp());
}

class MiniGamesHubApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Games Hub',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/tictactoe': (context) => TicTacToeScreen(),
        '/numbertap': (context) => NumberTapScreen(),
        '/memory': (context) => MemoryScreen(),
      },
    );
  }
}