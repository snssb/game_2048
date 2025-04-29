// features/game/domain/usecases/spawn_tile.dart
import 'dart:math';

import 'package:game_2048/features/game/domain/entities/game_board.dart';
import 'package:game_2048/features/game/domain/entities/tile.dart';

class SpawnTile {
  GameBoard call(GameBoard board) {
    final random = Random();
    final emptySpots = <List<int>>[];

    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (board.board[i][j] == null) {
          emptySpots.add([i, j]);
        }
      }
    }

    if (emptySpots.isNotEmpty) {
      final spot = emptySpots[random.nextInt(emptySpots.length)];
      final newTile = Tile(value: random.nextInt(10) < 9 ? 2 : 4, x: spot[0], y: spot[1]);
      List<List<Tile?>> newBoard = List.generate(4, (i) => List<Tile?>.from(board.board[i]));
      newBoard[spot[0]][spot[1]] = newTile;
      return GameBoard(board: newBoard, score: board.score, currentCube: board.currentCube);
    }

    return board;
  }
}
