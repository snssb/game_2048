// app/app.dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:game_2048/features/game/presentation/providers/game_provider.dart';
import 'package:game_2048/generated/l10n.dart';
import 'package:provider/provider.dart';
import '../core/di/injection.dart' as di;
import '../features/game/presentation/screens/game_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => di.sl<GameProvider>(),
      child: MaterialApp(
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: GameScreen(),
      ),
    );
  }
}
