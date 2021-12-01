import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';
import 'package:flutter_flame_architecture_template/model/game_board/game_board_ui_state.dart';
import 'package:flutter_flame_architecture_template/theme/theme.dart';
import 'package:flutter_flame_architecture_template/util/canvas/canvas_util.dart';
import 'package:flutter_flame_architecture_template/viewmodel/game/game_board_view_model.dart';

class GameBoardUI extends FlameWidget {
  final GameBoardViewModel viewModel;
  Path? lightningPath;
  Path? smallLightningPath;

  GameBoardUI({
    required this.viewModel,
  }) {
    viewModel.markUIForRebuild = markForRebuild;
  }

  @override
  FlameWidget build(BuildContext context) {
    return FlameRow(
      children: [
        FlameSizedBox(
          width: 96,
          child: FlameValueListenableBuilder<double>(
            valueListenable: viewModel.userMoney,
            builder: (context, value, _) => FlameText(
              '\$${CanvasUtils.formatMoney(value)}',
              textStyle: TextStyle(
                fontSize: 28,
                color: Colors.white,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        if (viewModel.uiState == GameBoardUIState.Speed) ...[
          FlameExpanded(
            child: FlameValueListenableBuilder(
              valueListenable: viewModel.speedMultiplier,
              builder: (context, value, child) => FlameSingleChildScrollView(
                verticalScrollEnabled: false,
                child: FlameRow(
                  children: [
                    FlameSpacer(),
                    FlameButton(
                      width: 64,
                      height: 64,
                      text: 'x0.5',
                      onTap: () => viewModel.setSpeed(0.5),
                      borderColor: value == 0.5 ? TemplateTheme.primary : Colors.white,
                    ),
                    FlameButton(
                      width: 64,
                      height: 64,
                      text: 'x0.75',
                      onTap: () => viewModel.setSpeed(0.75),
                      borderColor: value == 0.75 ? TemplateTheme.primary : Colors.white,
                    ),
                    FlameButton(
                      width: 64,
                      height: 64,
                      text: 'x1',
                      onTap: () => viewModel.setSpeed(1),
                      borderColor: value == 1 ? TemplateTheme.primary : Colors.white,
                    ),
                    FlameButton(
                      width: 64,
                      height: 64,
                      text: 'x1.5',
                      onTap: () => viewModel.setSpeed(1.5),
                      borderColor: value == 1.5 ? TemplateTheme.primary : Colors.white,
                    ),
                    FlameButton(
                      width: 64,
                      height: 64,
                      text: 'x2',
                      onTap: () => viewModel.setSpeed(2),
                      borderColor: value == 2 ? TemplateTheme.primary : Colors.white,
                    ),
                    FlameButton(
                      width: 64,
                      height: 64,
                      text: 'x4',
                      onTap: () => viewModel.setSpeed(4),
                      borderColor: value == 4 ? TemplateTheme.primary : Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
          FlameButton(
            width: 64,
            height: 64,
            text: 'Back',
            onTap: viewModel.onBackClicked,
          ),
        ] else ...[
          FlameSpacer(),
          if (viewModel.uiState == GameBoardUIState.Default) ...[
            FlameButton(
              width: 64,
              height: 64,
              text: 'Speed',
              onTap: viewModel.onSpeedClicked,
            ),
            FlameButton(
              width: 64,
              height: 64,
              text: 'Pause',
              onTap: viewModel.onPauseClicked,
            ),
          ],
        ],
        FlameSizedBox(width: 24),
      ],
    );
  }
}
