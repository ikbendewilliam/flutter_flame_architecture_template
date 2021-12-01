import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';
import 'package:flutter_flame_architecture_template/model/game_board/game_board_save.dart';

import 'package:flutter_flame_architecture_template/theme/theme.dart';
import 'package:flutter_flame_architecture_template/viewmodel/game/game_board_view_model.dart';
import 'package:flutter_flame_architecture_template/widget/game_board/game_board_ui.dart';

class GameBoardScreen extends FlameWidget {
  static const routeName = 'GameBoard';
  late final GameBoardViewModel viewModel;
  final itemSize = 40.0;

  GameBoardScreen({
    required Vector2 boardSize,
    String? campaignId,
  }) {
    viewModel = GameBoardViewModel(
      boardSize: boardSize,
      campaignId: campaignId,
    );
  }

  GameBoardScreen.load({
    required GameBoardSave saveData,
  }) {
    viewModel = GameBoardViewModel.load(saveData);
  }

  @override
  FlameWidget build(BuildContext context) {
    return FlameColumn(
      children: [
        FlameExpanded(
          child: FlamePadding(
            padding: const EdgeInsets.all(10),
            child: FlameZoom(
              zoomAlignment: ZoomAlignment.center,
              child: FlameSingleChildScrollView(
                child: FlameContainer(
                  onUpdate: viewModel.update,
                  width: viewModel.boardSize.x * itemSize,
                  height: viewModel.boardSize.y * itemSize,
                  child: FlameCenter(
                    child: FlameStack(
                      children: [],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        FlameSizedBox(
          height: 2,
          child: FlameContainer(color: TemplateTheme.primary),
        ),
        FlameSizedBox(
          height: 64,
          child: GameBoardUI(viewModel: viewModel),
        ),
      ],
    );
  }
}

class GameBoardArguments {
  final Vector2 boardSize;
  final String? campaignId;

  GameBoardArguments({
    required this.boardSize,
    this.campaignId,
  });
}

class GameBoardResult {
  final bool won;

  GameBoardResult({
    required this.won,
  });
}
