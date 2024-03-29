import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class GameView extends StatefulWidget {
  String player1;
  String player2;
  GameView({super.key, required this.player1, required this.player2});
  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  late List<List<String>> _board;
  late String _currentPlayer;
  late String _winner;
  late bool _gameOver;
  @override
  void initState() {
    super.initState();
    _board = List.generate(3, (_) => List.generate(3, (_) => ""));
    _currentPlayer = "X";
    _winner = "";
    _gameOver = false;
  }

  void _resetGame() {
    setState(() {
      _board = List.generate(3, (_) => List.generate(3, (_) => ""));
      _currentPlayer = "X";
      _winner = "";
      _gameOver = false;
    });
  }

  void _makeMove(int row, int col) {
    if (_board[row][col] != "" || _gameOver) {
      return;
    }
    setState(() {
      _board[row][col] = _currentPlayer;
      if (_board[row][0] == _currentPlayer &&
          _board[row][1] == _currentPlayer &&
          _board[row][2] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
      } else if (_board[0][col] == _currentPlayer &&
          _board[1][col] == _currentPlayer &&
          _board[2][col] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
      } else if (_board[0][0] == _currentPlayer &&
          _board[1][1] == _currentPlayer &&
          _board[2][2] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
      } else if (_board[0][2] == _currentPlayer &&
          _board[1][1] == _currentPlayer &&
          _board[2][0] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
      }
      _currentPlayer = _currentPlayer == "X" ? "O" : "X";

      if (!_board.any((row) => row.any((cell) => cell == ""))) {
        _gameOver = true;
        _winner = "It's a Tie";
      }
      if (_winner != "") {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          btnOkText: "Play Again",
          title: _winner == "X"
              ? "${widget.player1}Won!"
              : _winner == "O"
                  ? "${widget.player2}Won!"
                  : "It's a Tie",
          btnOkOnPress: (){
            _resetGame();
          },
        )
            .show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color.fromRGBO(27, 51, 118, 80),
      body: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: 70),

               Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Turn: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        _currentPlayer == "X" ? "${widget.player1}($_currentPlayer)": "${widget.player2}($_currentPlayer)",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: _currentPlayer == "X"? const Color.fromRGBO(248, 72, 28, 90): const Color.fromRGBO(127,255,0, 90),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(182, 182, 180, 80),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(5),
                    child: Expanded(
                      child: GridView.builder(
                        itemCount: 9,
                          shrinkWrap: true,
                           physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ), itemBuilder: (context, index){
                          int row = index ~/ 3;
                          int col = index % 3;
                          return GestureDetector(
                            onTap: ()=> _makeMove(row, col),
                            child: Container(
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(26, 17, 16, 80),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(_board[row][col],
                                  style: TextStyle(
                                    fontSize: 100,
                                    fontWeight: FontWeight.bold,
                                    color: _board[row][col] == "X"? Colors.redAccent : Colors.green,
                                  ),
                                ),
                              ),
                            ),
                          );
                      }),
                    ),
                  )
                ],
              ),

          ],),

      ),
    );
  }
}
