// features/game/presentation/widgets/game_over_overlay.dart
import 'package:flutter/material.dart';
import 'package:game_2048/core/constants/constants.dart';
import 'package:game_2048/generated/l10n.dart';

/// Виджет отображающий конец игры, очки, кнопку restart
class GameOverOverlay extends StatefulWidget {
  final int score;
  final VoidCallback onRestart;

  const GameOverOverlay({super.key, required this.score, required this.onRestart});

  @override
  State<GameOverOverlay> createState() => _GameOverOverlayState();
}

class _GameOverOverlayState extends State<GameOverOverlay> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _opacityAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Container(
            color: AppColors.gameOverOverlayBackground,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(AppSizes.gameOverContainerPadding),
                decoration: BoxDecoration(
                  color: AppColors.gameOverContainerBackground,
                  borderRadius: BorderRadius.circular(AppSizes.gameOverContainerBorderRadius),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      S.of(context).gameOverTitle, // Text
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: AppColors.gameOverTextColor),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      S.of(context).gameOverScoreLabel(widget.score),
                      style: TextStyle(fontSize: 20, color: AppColors.gameOverTextColor),
                    ), // Text
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: widget.onRestart,
                      style: AppStyles.gameOverButtonStyle,
                      child: Text(
                        S.of(context).gameOverRestartButton,
                        style: TextStyle(color: AppColors.gameOverTextColor, fontSize: AppSizes.gameOverButtonFontSize),
                      ), // Text
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
