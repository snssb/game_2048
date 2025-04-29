abstract class GameRepository {
  Future<void> saveHighScores(Map<String, dynamic> score);
  Future<Map<String, dynamic>> getHighScores();
}
