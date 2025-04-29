// features/game/domain/usecases/move_tiles.dart

import 'package:game_2048/features/game/domain/entities/game_board.dart';
import 'package:game_2048/features/game/domain/entities/tile.dart';
import 'package:game_2048/features/game/domain/repositories/game_repository.dart';

class MoveTiles {
  final GameRepository repository;

  MoveTiles(this.repository);

  GameBoard call(GameBoard board, String direction) {
    if (board.board.length != 4 || board.board.any((row) => row.length != 4)) {
      throw Exception('Invalid board size: must be 4x4');
    }

    List<List<Tile?>> newBoard = List.generate(4, (i) => List<Tile?>.from(board.board[i]));

    switch (direction.toLowerCase()) {
      case 'left':
        for (int i = 0; i < 4; i++) {
          newBoard[i] = _mergeTiles(newBoard[i], i, true);
        }
        break;
      case 'right':
        for (int i = 0; i < 4; i++) {
          newBoard[i] = _mergeTiles(newBoard[i].reversed.toList(), i, true).reversed.toList();
        }
        break;
      case 'up':
        for (int j = 0; j < 4; j++) {
          List<Tile?> column = [for (int i = 0; i < 4; i++) newBoard[i][j]];
          List<Tile?> merged = _mergeTiles(column, j, false);
          for (int i = 0; i < 4; i++) {
            newBoard[i][j] = merged[i];
          }
        }
        break;
      case 'down':
        for (int j = 0; j < 4; j++) {
          List<Tile?> column = [for (int i = 0; i < 4; i++) newBoard[i][j]];
          List<Tile?> merged = _mergeTiles(column.reversed.toList(), j, false).reversed.toList();
          for (int i = 0; i < 4; i++) {
            newBoard[i][j] = merged[i];
          }
        }
        break;
      default:
        throw Exception('Unknown direction: $direction');
    }

    return GameBoard(board: newBoard);
  }

  List<Tile?> _mergeTiles(List<Tile?> input, int fixedIndex, bool isRow) {
    List<Tile> tiles = input.whereType<Tile>().toList();
    List<Tile?> result = [];
    int k = 0;

    while (k < tiles.length) {
      if (k + 1 < tiles.length && tiles[k].value == tiles[k + 1].value) {
        final cubeValue = tiles[k].value;
        final mergedValue = cubeValue * 2;
        result.add(
          Tile(value: mergedValue, x: isRow ? fixedIndex : result.length, y: isRow ? result.length : fixedIndex),
        );
        k += 2;
      } else {
        result.add(
          Tile(value: tiles[k].value, x: isRow ? fixedIndex : result.length, y: isRow ? result.length : fixedIndex),
        );
        k++;
      }
    }

    while (result.length < 4) {
      result.add(null);
    }

    return result;
  }
}
