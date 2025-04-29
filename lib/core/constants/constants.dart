import 'package:flutter/material.dart';

class AppConfig {
  static const boardSize = 4;
}

class AppColors {
  static const colorWhite = Colors.white;
  static const colorBlack = Colors.black;

  // GameScreen
  static const scaffoldBackground = Color.fromARGB(255, 239, 228, 176);
  static const buttonBackground = Color.fromARGB(255, 247, 172, 0);
  static const boardColor = Color.fromARGB(255, 165, 137, 112);

  // Tile
  static const tileEmpty = Color.fromARGB(255, 219, 187, 160);
  static const tile2 = Color.fromARGB(255, 238, 228, 218);
  static const tile4 = Color.fromARGB(255, 255, 255, 191);
  static const tile8 = Color.fromARGB(255, 240, 209, 126);
  static const tile16 = Color.fromARGB(255, 253, 174, 97);
  static const tile32 = Color.fromARGB(255, 244, 109, 67);
  static const tile64 = Color.fromARGB(255, 213, 62, 79);
  static const tile128 = Color.fromARGB(255, 158, 1, 66);
  static const tile256 = Color.fromARGB(255, 171, 221, 164);
  static const tile512 = Color.fromARGB(255, 102, 194, 165);
  static const tile1024 = Color.fromARGB(255, 50, 136, 189);
  static const tile2048 = Color.fromARGB(255, 94, 79, 162);
  static const tile4096 = Color.fromARGB(255, 104, 67, 75);
  static const tile8192 = Color.fromARGB(255, 78, 54, 68);
  static const tile16384 = Color.fromARGB(255, 41, 30, 44);
  static const tile32768 = Color.fromARGB(255, 108, 47, 45);
  static const tile65536 = Color.fromARGB(255, 79, 28, 27);
  static const tile131072 = Color.fromARGB(255, 80, 26, 25);
  static const tileDefault = Color.fromARGB(255, 236, 224, 200);

  static const tileText2 = Color.fromARGB(255, 117, 89, 49);
  static const tileText4 = Color.fromARGB(255, 107, 80, 43);
  static const tileText8 = Color.fromARGB(255, 97, 72, 38);
  static const tileTextDefault = colorWhite;

  // Cube
  static const cubeBestScore = Color.fromARGB(255, 202, 113, 243);
  static const cubeBestCube = Color.fromARGB(255, 92, 83, 168);
  static const cubeCurrentScore = Color.fromARGB(255, 231, 213, 45);
  static const cubeCurrentCube = Color.fromARGB(255, 222, 162, 0);
  static const cubeTextBlack = colorBlack;
  static const cubeTextWhite = Color.fromARGB(255, 255, 255, 255);

  // GameOver
  static const gameOverOverlayBackground = Color.fromARGB(127, 0, 0, 0);
  static const gameOverContainerBackground = Color.fromARGB(131, 0, 0, 0);
  static const gameOverButtonBackground = Color.fromARGB(106, 247, 173, 0);
  static const gameOverTextColor = colorWhite;
}

class AppSizes {
  // GameScreen
  static const buttonBorderRadius = 5.0;
  static const boardBorderRadius = 10.0;
  static const padding = 16.0;
  static const fontSizeLarge = 40.0;
  static const fontSizeMedium = 20.0;
  static const paddingFactor = 0.04;

  // Tile
  static const tileSizeDivisor = 4; // (screenWidth - padding * 5) / 4
  static const tileSizeMin = 60.0;
  static const tileSizeMax = 120.0;
  static const tileMarginFactor = 0.0111;
  static const tileTextPadding = 2.0;
  static const tileBorderRadius = 8.0;

  // Cube
  static const cubeBorderRadius = 8.0;
  static const cubePadding = 7.0;

  static const fontSizeLargeFactor = 0.09;
  static const fontSizeMediumFactor = 0.08;
  static const fontSizeMediumMin = 8.0;
  static const fontSizeMediumMax = 40.0;
  static const cubeSizeFactor = 0.33;
  static const cubeSizeMin = 80.0;
  static const cubeSizeMax = 170.0;
  static const gridSizePaddingFactor = 2;
  static const gridSizeMin = 300.0;
  static const gridSizeMax = 550.0;
  static const appBarSizeFactor = 0.15;

  // GameOver
  static const gameOverContainerPadding = 20.0;
  static const gameOverContainerBorderRadius = 10.0;
  static const gameOverSpacingSmall = 10.0;
  static const gameOverSpacingLarge = 20.0;
  static const gameOverButtonPadding = EdgeInsets.only(left: 5, top: 2, right: 5, bottom: 0);
  static const gameOverTitleFontSize = 30.0;
  static const gameOverScoreFontSize = 20.0;
  static const gameOverButtonFontSize = 25.0;
}

class AppStyles {
  // GameScreen
  static final gameScreenButtonStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(AppColors.buttonBackground),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.buttonBorderRadius)),
    ),
    padding: WidgetStateProperty.all(EdgeInsets.only(left: 5, top: 2, right: 5, bottom: 0)),
    minimumSize: WidgetStateProperty.all(Size.zero),
  );

  // GameOver
  static final gameOverButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.gameOverButtonBackground,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.buttonBorderRadius)),
    padding: AppSizes.gameOverButtonPadding,
    minimumSize: const Size(0, 0),
  );
}
