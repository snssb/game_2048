// features/game/domain/entities/tile.dart
class Tile {
  static int _counter = 0;
  final int id;
  final int value;
  final int x;
  final int y;

  Tile({required this.value, required this.x, required this.y}) : id = _counter++;
}
