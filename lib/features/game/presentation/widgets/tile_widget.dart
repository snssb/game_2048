import 'package:flutter/material.dart';
import 'package:game_2048/core/constants/constants.dart';
import '../../domain/entities/tile.dart';

/// Виджет, отображающий куб на игровом поле с анимацией появления
class TileWidget extends StatefulWidget {
  final Tile? tile;
  final double size;
  final int row;
  final int col;
  final double fontSize;
  final double tileMargin;

  const TileWidget({
    required this.tile,
    required this.size,
    required this.row,
    required this.col,
    super.key,
    required this.fontSize,
    required this.tileMargin,
  });

  @override
  State<TileWidget> createState() => _TileWidgetState();
}

class _TileWidgetState extends State<TileWidget> with SingleTickerProviderStateMixin {
  Tile? previousTile;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    previousTile = widget.tile;

    _controller = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    if (widget.tile != null && (widget.tile!.value == 2 || widget.tile!.value == 4)) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(TileWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tile != widget.tile) {
      previousTile = oldWidget.tile;
      if (previousTile == null && widget.tile != null && (widget.tile!.value == 2 || widget.tile!.value == 4)) {
        _controller.reset();
        _controller.forward();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isNew = previousTile == null && widget.tile != null;
    final shouldAnimate = isNew && (widget.tile!.value == 2 || widget.tile!.value == 4);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(scale: shouldAnimate ? _scaleAnimation.value : 1.0, child: child);
      },
      child: Container(
        width: widget.size,
        height: widget.size,
        margin: EdgeInsets.all(widget.tileMargin),
        decoration: BoxDecoration(
          color: widget.tile == null ? AppColors.tileEmpty : _tileColors[widget.tile!.value],
          borderRadius: BorderRadius.circular(AppSizes.tileBorderRadius),
        ),
        child: Center(
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.tileTextPadding),
              child: Text(
                widget.tile == null ? '' : widget.tile!.value.toString(),
                style: TextStyle(
                  fontSize: widget.fontSize,
                  fontWeight: FontWeight.bold,
                  color:
                      widget.tile != null && [2, 4, 8].contains(widget.tile!.value)
                          ? _tileTextColors[widget.tile!.value]
                          : AppColors.tileTextDefault,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static const Map<int, Color> _tileColors = {
    2: AppColors.tile2,
    4: AppColors.tile4,
    8: AppColors.tile8,
    16: AppColors.tile16,
    32: AppColors.tile32,
    64: AppColors.tile64,
    128: AppColors.tile128,
    256: AppColors.tile256,
    512: AppColors.tile512,
    1024: AppColors.tile1024,
    2048: AppColors.tile2048,
    4096: AppColors.tile4096,
    8192: AppColors.tile8192,
    16384: AppColors.tile16384,
    32768: AppColors.tile32768,
    65536: AppColors.tile65536,
    131072: AppColors.tile131072,
  };

  static const Map<int, Color> _tileTextColors = {
    2: AppColors.tileText2,
    4: AppColors.tileText4,
    8: AppColors.tileText8,
  };
}
