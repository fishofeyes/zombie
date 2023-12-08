import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:zombies/zombie_game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final game = ZombieGame();
  runApp(MyApp(game: game));
}

class MyApp extends StatelessWidget {
  final ZombieGame game;
  const MyApp({super.key, required this.game});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: GameWidget(game: game),
    );
  }
}
