import 'package:game_2048/features/game/domain/entities/tile.dart';

class GameBoard {
  final List<List<Tile?>> board;
  final int? score;
  final int? currentCube;

  GameBoard({required this.board, this.score, this.currentCube});

  factory GameBoard.initial() {
    return GameBoard(board: List.generate(4, (_) => List.generate(4, (_) => null)), score: 0, currentCube: 0);
  }
}
