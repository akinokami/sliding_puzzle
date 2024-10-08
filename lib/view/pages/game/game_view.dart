import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:sliding_puzzle/models/move_to.dart';
import 'package:sliding_puzzle/services/repositories_impl/images_repository_impl.dart';
import 'package:sliding_puzzle/view/pages/game/controller/game_controller.dart';
import 'package:sliding_puzzle/view/pages/game/widgets/background.dart';
import 'package:sliding_puzzle/view/pages/game/widgets/game_buttons.dart';
import 'package:sliding_puzzle/view/pages/game/widgets/puzzle_interactor.dart';
//import 'package:sliding_puzzle/view/pages/game/widgets/puzzle_options.dart';
import 'package:sliding_puzzle/view/pages/game/widgets/time_and_moves.dart';
import 'package:sliding_puzzle/view/pages/game/widgets/winner_dialog.dart';
// import 'package:sliding_puzzle/view/utils/responsive.dart';
import 'package:provider/provider.dart';
import 'package:sliding_puzzle/view/pages/settings/setting_screen.dart';
import 'package:sliding_puzzle/view/widget/custom_card.dart';

import '../../global/widgets/my_icon_button.dart';

class GameView extends StatelessWidget {
  final int page;
  const GameView({Key? key, required this.page}) : super(key: key);

  // @override
  void _onKeyBoardEvent(BuildContext context, RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      final moveTo = event.logicalKey.keyLabel.moveTo;
      if (moveTo != null) {
        context.read<GameController>().onMoveByKeyboard(moveTo);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //  final responsive = Responsive.of(context);
    // final width = responsive.width;
    final controller = GameController();
    return ChangeNotifierProvider(
      create: (_) {
        //todo
        final image = puzzleOptions[page];
        controller.changeGrid(
          controller.state.crossAxisCount,
          image.name != 'Numeric' ? image : null,
        );

        if (image.name != 'Numeric' && controller.state.sound) {
          controller.audioRepository.play(
            image.soundPath,
          );
        }
        //todo
        controller.onFinish.listen(
          (_) {
            Timer(
              const Duration(
                milliseconds: 200,
              ),
              () {
                showWinnerDialog(
                  context,
                  moves: controller.state.moves,
                  time: controller.time.value,
                );
              },
            );
          },
        );
        return controller;
      },
      builder: (context, child) => RawKeyboardListener(
        autofocus: true,
        includeSemantics: false,
        focusNode: FocusNode(),
        onKey: (event) => _onKeyBoardEvent(context, event),
        child: child!,
      ),
      child: GameBackground(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Consumer<GameController>(
                builder: (context, loadingProvider, child) {
              return controller.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SafeArea(
                      child: OrientationBuilder(
                        builder: (_, orientation) {
                          final isPortrait =
                              orientation == Orientation.portrait;

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    MyIconButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      iconData: Icons.arrow_back,
                                    ),
                                    MyIconButton(
                                      onPressed: () {
                                        Get.to(() => const SettingScreeen());
                                      },
                                      iconData: Icons.settings,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: LayoutBuilder(
                                  builder: (_, constraints) {
                                    final height = constraints.maxHeight;
                                    final puzzleHeight = (isPortrait
                                            ? height * 0.45
                                            : height * 0.5)
                                        .clamp(250, 700)
                                        .toDouble();
                                    // final optionsHeight =
                                    //     (isPortrait ? height * 0.25 : height * 0.2)
                                    //         .clamp(120, 200)
                                    //         .toDouble();

                                    return SizedBox(
                                      height: height,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            // SizedBox(
                                            //   height: optionsHeight,
                                            //   child: PuzzleOptions(
                                            //     width: width,
                                            //   ),
                                            // ),
                                            // SizedBox(
                                            //   height: 10.h,
                                            // ),
                                            // CustomCard(
                                            //   width: 1.sw * 0.62,
                                            //   widget: Row(
                                            //     children: [
                                            //       CustomText(
                                            //         text: 'best_moves'.tr,
                                            //         fontSize: 20.sp,
                                            //         fontWeight: FontWeight.w600,
                                            //       ),
                                            //       SizedBox(
                                            //         width: 10.w,
                                            //       ),
                                            //       const Icon(
                                            //         Icons.multiple_stop_rounded,
                                            //         size: 27,
                                            //       ),
                                            //       SizedBox(
                                            //         width: 10.w,
                                            //       ),
                                            //       CustomText(
                                            //         text: "10",
                                            //         fontSize: 20.sp,
                                            //         fontWeight: FontWeight.w600,
                                            //       )
                                            //     ],
                                            //   ),
                                            // ),
                                            SizedBox(
                                              height: height * 0.1,
                                            ),
                                            CustomCard(
                                              width: 1.sw * 0.62,
                                              widget: const TimeAndMoves(),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: SizedBox(
                                                height: puzzleHeight,
                                                child: const AspectRatio(
                                                  aspectRatio: 1,
                                                  child: PuzzleInteractor(),
                                                ),
                                              ),
                                            ),
                                            const GameButtons(),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    );
            })),
      ),
    );
  }
}
