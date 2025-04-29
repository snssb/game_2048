import 'package:flutter/material.dart';
import 'package:game_2048/core/constants/constants.dart';
import 'package:game_2048/features/game/presentation/widgets/cube_score.dart';
import 'package:game_2048/features/game/presentation/widgets/gameover_overlay.dart';
import 'package:game_2048/generated/l10n.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../widgets/tile_widget.dart';

/// Основной экран игры
class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late double padding;
  late double tileSize;
  late double constrainedTileSize;
  late double fontSizeLarge;
  late double fontSizeMedium;
  late double cubeSize;
  late double gridSize;
  late double appBarSize;
  late double tileMargin;
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInitialized) {
      _calculateSizes();
      isInitialized = true;
    }
  }

  void _calculateSizes() {
    final screenWidth = MediaQuery.of(context).size.width;
    padding = screenWidth * AppSizes.paddingFactor;
    tileSize = (screenWidth - padding * 5) / AppSizes.tileSizeDivisor;
    constrainedTileSize = tileSize.clamp(AppSizes.tileSizeMin, AppSizes.tileSizeMax);
    fontSizeLarge = screenWidth * AppSizes.fontSizeLargeFactor;
    fontSizeMedium = (screenWidth * AppSizes.fontSizeMediumFactor).clamp(
      AppSizes.fontSizeMediumMin,
      AppSizes.fontSizeMediumMax,
    );
    cubeSize = (screenWidth * AppSizes.cubeSizeFactor).clamp(AppSizes.cubeSizeMin, AppSizes.cubeSizeMax);
    gridSize = (screenWidth - padding * AppSizes.gridSizePaddingFactor).clamp(
      AppSizes.gridSizeMin,
      AppSizes.gridSizeMax,
    );
    appBarSize = screenWidth * AppSizes.appBarSizeFactor;
    tileMargin = screenWidth * AppSizes.tileMarginFactor;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(const AssetImage('assets/win_2048.gif'), context);
    });

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Padding(
                  padding: EdgeInsets.all(padding),
                  child: Column(
                    children: [
                      SizedBox(
                        width: gridSize,
                        height: appBarSize,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Selector<GameProvider, bool>(
                              selector: (_, provider) => provider.isWin,
                              builder: (context, isWin, child) {
                                return isWin
                                    ? Image.asset('assets/win_2048.gif', width: cubeSize, fit: BoxFit.contain)
                                    : Text('2048', style: TextStyle(fontSize: fontSizeLarge, letterSpacing: 5.5));
                              },
                            ),

                            /// Кнопка рестарта
                            ElevatedButton(
                              onPressed: Provider.of<GameProvider>(context, listen: false).restart,
                              style: AppStyles.gameScreenButtonStyle,
                              child: Text(
                                S.of(context).restartButton,
                                style: TextStyle(color: AppColors.colorWhite, fontSize: fontSizeMedium),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: padding),
                      Expanded(
                        child: MoveDetectorWidget(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: gridSize,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CubeScoreWidget(
                                      cubeSize: cubeSize,
                                      padding: padding,
                                      fontSizeMedium: fontSizeMedium,
                                      cubeType: CubeType.bestScore,
                                    ),
                                    CubeScoreWidget(
                                      cubeSize: cubeSize,
                                      padding: padding,
                                      fontSizeMedium: fontSizeMedium,
                                      cubeType: CubeType.bestCube,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: padding),
                              BoardWidget(
                                gridSize: gridSize,
                                padding: padding,
                                constrainedTileSize: constrainedTileSize,
                                fontSizeMedium: fontSizeMedium,
                                tileMargin: tileMargin,
                              ),
                              SizedBox(height: padding),
                              SizedBox(
                                width: gridSize,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CubeScoreWidget(
                                      cubeSize: cubeSize,
                                      padding: padding,
                                      fontSizeMedium: fontSizeMedium,
                                      cubeType: CubeType.currentScore,
                                    ),
                                    CubeScoreWidget(
                                      cubeSize: cubeSize,
                                      padding: padding,
                                      fontSizeMedium: fontSizeMedium,
                                      cubeType: CubeType.currentCube,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Consumer<GameProvider>(
              builder: (context, provider, child) {
                return provider.isGameOver
                    ? GameOverOverlay(score: provider.board.score!, onRestart: provider.restart)
                    : SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// Определение свайпа
class MoveDetectorWidget extends StatefulWidget {
  final Widget child;

  const MoveDetectorWidget({super.key, required this.child});

  @override
  MoveDetectorWidgetState createState() => MoveDetectorWidgetState();
}

class MoveDetectorWidgetState extends State<MoveDetectorWidget> {
  Offset _dragDelta = Offset.zero;

  void _handlePanUpdate(DragUpdateDetails details) {
    setState(() {
      _dragDelta += details.delta;
    });
  }

  void _handlePanEnd(DragEndDetails details, BuildContext context) {
    final dx = _dragDelta.dx;
    final dy = _dragDelta.dy;
    final absDx = dx.abs();
    final absDy = dy.abs();

    final gameProvider = Provider.of<GameProvider>(context, listen: false);

    if (absDx < 15 && absDy < 15) return;

    final direction = absDx > absDy ? (dx > 0 ? 'right' : 'left') : (dy > 0 ? 'down' : 'up');
    gameProvider.move(direction);

    setState(() {
      _dragDelta = Offset.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _handlePanUpdate,
      onPanEnd: (details) => _handlePanEnd(details, context),
      child: widget.child,
    );
  }
}

/// Виджет куба с очками/рекордами
class CubeScoreWidget extends StatelessWidget {
  final double cubeSize;
  final double padding;
  final double fontSizeMedium;
  final CubeType cubeType;

  const CubeScoreWidget({
    super.key,
    required this.cubeSize,
    required this.padding,
    required this.fontSizeMedium,
    required this.cubeType,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, provider, child) {
        return CubeScoreDetailWidget(
          boxSize: cubeSize,
          padding: padding,
          provider: provider,
          fontSizeMedium: fontSizeMedium,
          cubeType: cubeType,
        );
      },
    );
  }
}

/// Виджет игрового поля
class BoardWidget extends StatelessWidget {
  final double gridSize;
  final double padding;
  final double constrainedTileSize;
  final double fontSizeMedium;
  final double tileMargin;

  const BoardWidget({
    super.key,
    required this.gridSize,
    required this.padding,
    required this.constrainedTileSize,
    required this.fontSizeMedium,
    required this.tileMargin,
  });

  final boardBorderRadius = 10.0;

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, provider, child) {
        return SizedBox(
          width: gridSize,
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(boardBorderRadius)),
                color: AppColors.boardColor,
              ),
              padding: EdgeInsets.all(padding * 0.4),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: AppConfig.boardSize),
                itemCount: AppConfig.boardSize * AppConfig.boardSize,
                itemBuilder: (context, index) {
                  final row = index ~/ AppConfig.boardSize;
                  final col = index % AppConfig.boardSize;
                  final tile = provider.board.board[row][col];
                  return TileWidget(
                    key: ValueKey(tile?.id ?? 0),
                    tile: tile,
                    size: constrainedTileSize,
                    row: row,
                    col: col,
                    fontSize: fontSizeMedium,
                    tileMargin: tileMargin,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
