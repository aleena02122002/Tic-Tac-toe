import 'package:flutter/material.dart';

class GameView extends StatefulWidget {
  String player1;
  String player2;
  GameView({required this.player1, required this.player2});
  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  late List<List<String>> _board;
  late String _currentPlayer;
  late String _winner;
  late bool _gameOver;
  @override


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
