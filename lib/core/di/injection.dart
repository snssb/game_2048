// core/di/injection.dart
import 'package:game_2048/features/game/data/repositories/game_repository_impl.dart';
import 'package:game_2048/features/game/domain/repositories/game_repository.dart';
import 'package:game_2048/features/game/domain/usecases/move_tiles.dart';
import 'package:game_2048/features/game/domain/usecases/spawn_tile.dart';
import 'package:game_2048/features/game/presentation/providers/game_provider.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void init() {
  // Repositories
  sl.registerLazySingleton<GameRepository>(() => GameRepositoryImpl());

  // Use Cases
  sl.registerLazySingleton(() => MoveTiles(sl<GameRepository>()));
  sl.registerLazySingleton(() => SpawnTile());

  // Provider
  sl.registerLazySingleton(() => GameProvider(sl<MoveTiles>(), sl<SpawnTile>(), sl<GameRepository>()));
}
