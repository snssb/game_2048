import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_2048/app/app.dart';
import 'package:game_2048/core/di/injection.dart' as di;

void main() {
  di.init();

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const MyApp());
  });
}
