import 'dart:ffi';

enum Marking { O, X, U }

enum GameState { init, playing, over }

class TicTacToeGame {
  Marking turn = Marking.X;
  int moves = 0;
  Marking? winner; // null: game in progress, 0/X, U:draw
  GameState state = GameState.init;
  late final List<Marking> board;

  TicTacToeGame() {
    board = [
      for (int i = 0; i < 9; i++) Marking.U,
    ];
  }

  void changeTurns() {
    turn = turn == Marking.X ? Marking.O : Marking.X;
    ++moves;
  }

void setWinner() {
  for (int i = 0; i < 3; i++) {
    winner = _checkCol(i);
    if (winner != null) return;
    winner = _checkRow(i);
    if (winner != null) return;
  }
  winner = _checkDiag1();
  if (winner != null) return;
  winner = _checkDiag2();
  if (winner != null) return;

  if (moves == 9) {
    winner = Marking.U;
    return;
  }
}

  Marking? _checkDiag1() {
    if (board[0] != Marking.U && board[0] == board[4] && board[0] == board[8]) {
      return board[0];
    } else {
      return null;
    }
  }

   Marking? _checkDiag2() {
    if (board[0] != Marking.U && board[2] == board[4] && board[2] == board[6]) {
      return board[0];
    } else {
      return null;
    }
  }
  

  Marking? _checkRow(int n) {
    if (board[n * 3] != Marking.U &&
        board[n * 3] == board[n * 3 + 1] &&
        board[n * 3] == board[n * 3 + 2]) {
      return board[n * 3];
    } else {
      return null;
    }
  }

  Marking? _checkCol(int n) {
    if (board[n] != Marking.U &&
        board[n] == board[n + 3] &&
        board[n] == board[n + 6]) {
      return board[n];
    }
  }
}
