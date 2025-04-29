import 'package:game_2048/features/game/domain/entities/tile.dart';

class GameRules {
  ({int score, int currentCube}) calculateScore(List<List<Tile?>> board) {
    int score = 0;
    int bestCube = 0;

    for (int i = 0; i < board.length; i++) {
      for (int j = 0; j < board[i].length; j++) {
        final tile = board[i][j];
        if (tile != null) {
          score += tile.value;
          if (tile.value > bestCube) {
            bestCube = tile.value;
          }
        }
      }
    }

    return (score: score, currentCube: bestCube);
  }

  bool hasPossibleMoves(List<List<Tile?>> board) {
    if ((board.length != 4) || (board.any((row) => row.length != 4))) {
      throw Exception('Invalid board size: must be 4x4');
    }

    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (board[i][j] == null) {
          return true;
        }
      }
    }

    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j]!.value == board[i][j + 1]!.value) {
          return true;
        }
      }
    }

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 4; j++) {
        if (board[i][j]!.value == board[i + 1][j]!.value) {
          return true;
        }
      }
    }

    return false;
  }
}
