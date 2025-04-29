// features/game/data/repositories/game_repository_impl.dart
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/repositories/game_repository.dart';

class GameRepositoryImpl implements GameRepository {
  static const _highScoresKey = 'high_scores';

  @override
  Future<void> saveHighScores(Map<String, dynamic> dictScores) async {
    final prefs = await SharedPreferences.getInstance();
    final String scores = jsonEncode(dictScores);
    await prefs.setString(_highScoresKey, scores);
  }

  @override
  Future<Map<String, dynamic>> getHighScores() async {
    final prefs = await SharedPreferences.getInstance();
    final String? scores = prefs.getString(_highScoresKey);

    if (scores == null) {
      return {'bestScore': 0, 'bestCube': 0};
    }

    final Map<String, dynamic> dictScores = jsonDecode(scores);

    return dictScores;
  }
}
