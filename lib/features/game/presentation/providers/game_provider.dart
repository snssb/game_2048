// features/game/presentation/providers/game_provider.dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game_2048/features/game/domain/entities/game_board.dart';
import 'package:game_2048/features/game/domain/repositories/game_repository.dart';
import '../../domain/usecases/move_tiles.dart';
import '../../domain/usecases/spawn_tile.dart';
import '../../domain/services/game_rules.dart';

class GameProvider with ChangeNotifier {
  final MoveTiles moveTiles;
  final SpawnTile spawnTile;
  final GameRepository repository;
  final GameRules gameRules;

  GameBoard _board;
  Map<String, dynamic> _highscores = {'bestScore': 0, 'bestCube': 0};
  bool _isGameOver = false;
  bool _isWin = false;

  GameProvider(this.moveTiles, this.spawnTile, this.repository)
    : _board = GameBoard.initial(),
      gameRules = GameRules() {
    _board = spawnTile(_board); // first tile
    _calculateScores();
    _loadHighScores();
  }

  GameBoard get board => _board;
  set board(GameBoard board) {
    _board = board;
  }

  int get bestScore => _highscores['bestScore'] as int;
  int get bestCube => _highscores['bestCube'] as int;
  bool get isGameOver => _isGameOver;
  bool get isWin => _isWin;

  void _calculateScores() {
    final res = gameRules.calculateScore(_board.board);
    final int score = res.score;
    final int currentCube = res.score;
    board = GameBoard(board: _board.board, score: score, currentCube: currentCube);
  }

  void _checkGameOver() {
    _isGameOver = !gameRules.hasPossibleMoves(_board.board);
  }

  Future<void> _loadHighScores() async {
    _highscores = await repository.getHighScores();
    notifyListeners();
  }

  Future<void> move(String direction) async {
    _board = moveTiles(_board, direction);
    _board = spawnTile(_board);
    _calculateScores();

    if (_board.score! > bestScore || _board.currentCube! > bestCube) {
      _highscores['bestScore'] = max(_board.score!, bestScore);
      _highscores['bestCube'] = max(_board.currentCube!, bestCube);
      await repository.saveHighScores(_highscores);
    }

    if (_isWin != true && _board.currentCube! >= 2048) {
      _isWin = true;
    }

    _checkGameOver();
    notifyListeners();
  }

  void restart() {
    _board = GameBoard.initial();
    _board = spawnTile(_board);
    _calculateScores();
    _isGameOver = false;
    _isWin = false;
    notifyListeners();
  }
}
