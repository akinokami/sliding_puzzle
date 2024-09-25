import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_puzzle/services/repositories_impl/images_repository_impl.dart';
import 'package:sliding_puzzle/view/global/widgets/my_icon_button.dart';
import 'package:sliding_puzzle/view/pages/game/game_view.dart';
import 'package:sliding_puzzle/view/pages/settings/setting_screen.dart';
import 'package:sliding_puzzle/view/utils/colors.dart';

class ChooseCardScreen extends StatelessWidget {
  const ChooseCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final responsive = Responsive.of(context);
    // final width = responsive.width;
    //final isDarkMode = context.isDarkMode;
    return SafeArea(
      child: Scaffold(
          backgroundColor:
              darkColor, // context.isDarkMode ? darkColor : lightColor2,
          body: OrientationBuilder(builder: (_, orientation) {
            // final isPortrait = orientation == Orientation.portrait;
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyIconButton(
                        onPressed: () {
                          exit(0);
                        },
                        iconData: Icons.close,
                      ),
                      Text(
                        'choose_player'.tr,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      MyIconButton(
                        onPressed: () {
                          Get.to(() => const SettingScreeen());
                        },
                        iconData: Icons.settings,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                      ),
                      itemCount: puzzleOptions.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.to(() => GameView(
                                  page: index,
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              color: lightColor.withOpacity(0.3),
                              // color: lightColor
                              //     .withOpacity(isDarkMode ? 0.3 : 0.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    puzzleOptions[index].assetPath,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          })),
    );
  }
}
