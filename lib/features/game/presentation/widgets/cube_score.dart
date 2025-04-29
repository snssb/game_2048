import 'package:flutter/material.dart';
import 'package:game_2048/core/constants/constants.dart';
import 'package:game_2048/features/game/presentation/providers/game_provider.dart';
import 'package:game_2048/generated/l10n.dart';

enum CubeType { bestScore, bestCube, currentScore, currentCube }

/// Виджет отображающий очки и рекорды
class CubeScoreDetailWidget extends StatelessWidget {
  final double boxSize;
  final double padding;
  final GameProvider provider;
  final double fontSizeMedium;
  final CubeType cubeType;

  const CubeScoreDetailWidget({
    super.key,
    required this.boxSize,
    required this.padding,
    required this.provider,
    required this.fontSizeMedium,
    required this.cubeType,
  });

  String _getCubeText(BuildContext context) {
    return switch (cubeType) {
      CubeType.bestScore => S.of(context).bestScoreLabel(provider.bestScore),
      CubeType.bestCube => S.of(context).bestCubeLabel(provider.bestCube),
      CubeType.currentScore => S.of(context).currentScoreLabel(provider.board.score ?? 0),
      CubeType.currentCube => S.of(context).currentCubeLabel(provider.board.currentCube ?? 0),
    };
  }

  Color _getCubeColor() {
    return switch (cubeType) {
      CubeType.bestScore => AppColors.cubeBestScore,
      CubeType.bestCube => AppColors.cubeBestCube,
      CubeType.currentScore => AppColors.cubeCurrentScore,
      CubeType.currentCube => AppColors.cubeCurrentCube,
    };
  }

  Color _getCubeTextColor() {
    return switch (cubeType) {
      CubeType.bestScore => AppColors.cubeTextBlack,
      CubeType.bestCube => AppColors.cubeTextWhite,
      CubeType.currentScore => AppColors.cubeTextBlack,
      CubeType.currentCube => AppColors.cubeTextWhite,
    };
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: boxSize,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(AppSizes.cubeBorderRadius)),
            color: _getCubeColor(),
          ),
          child: Center(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.cubePadding),
                child: Text(
                  _getCubeText(context),
                  style: TextStyle(fontSize: fontSizeMedium, color: _getCubeTextColor()),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
