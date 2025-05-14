import 'dart:io';

class TicTacToe {
  List<String> board = List.filled(9, ' ');
  String currentPlayer = 'X';

  void start() {
    print(' welcome Tic-Tac-Toe!');
    _printBoard();

    while (true) {
      _playerMove();
      _printBoard();

      if (_checkWinner(currentPlayer)) {
        print('  $currentPlayer you win');
        break;
      } else if (_isDraw()) {
        print(' The game is done');
        break;
      }

      _switchPlayer();
    }

    _askRestart();
  }

  void _printBoard() {
    print('\n');
    for (int i = 0; i < 9; i += 3) {
      print(' ${board[i]} | ${board[i + 1]} | ${board[i + 2]} ');
      if (i < 6) print('---+---+---');
    }
    print('\n');
  }

  void _playerMove() {
    while (true) {
      stdout
          .write(' player $currentPlayer،  please choose number between 1-9 ');
      String? input = stdin.readLineSync();
      int? index = int.tryParse(input ?? '') ?? -1;

      if (index < 1 || index > 9) {
        print('please choose number between 1-9');
        continue;
      }

      if (board[index - 1] != ' ') {
        print('This is full / please try other');
        continue;
      }

      board[index - 1] = currentPlayer;
      break;
    }
  }

  void _switchPlayer() {
    currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
  }

  bool _checkWinner(String player) {
    List<List<int>> winningPositions = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // row
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // column
      [0, 4, 8], [2, 4, 6], // radios
    ];

    for (var pos in winningPositions) {
      if (board[pos[0]] == player &&
          board[pos[1]] == player &&
          board[pos[2]] == player) {
        return true;
      }
    }
    return false;
  }

  bool _isDraw() {
    return !board.contains(' ');
  }

  void _askRestart() {
    stdout.write(' do yo want to play again ');
    String? answer = stdin.readLineSync()?.toLowerCase();

    if (answer == 'نعم' || answer == 'y' || answer == 'yes') {
      board = List.filled(9, ' ');
      currentPlayer = 'X';
      start();
    } else {
      print('Thanks');
    }
  }
}

void main() {
  TicTacToe game = TicTacToe();
  game.start();
}
