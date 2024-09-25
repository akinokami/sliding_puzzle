import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sliding_puzzle/services/local_storage.dart';
import 'package:sliding_puzzle/services/repositories_impl/images_repository_impl.dart';
import 'package:sliding_puzzle/view/global/enum.dart';
import 'package:sliding_puzzle/view/global/widgets/my_icon_button.dart';
import 'package:sliding_puzzle/view/pages/game/game_view.dart';
import 'package:sliding_puzzle/view/pages/settings/setting_screen.dart';
import 'package:sliding_puzzle/view/utils/colors.dart';
import 'package:sliding_puzzle/view/widget/custom_text.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../global/global.dart';
import '../../widget/custom_button.dart';

class ChooseCardScreen extends StatefulWidget {
  const ChooseCardScreen({super.key});

  @override
  State<ChooseCardScreen> createState() => _ChooseCardScreenState();
}

class _ChooseCardScreenState extends State<ChooseCardScreen> {
  bool isAccepted = false;
  bool isChecked = false;
  String first = '';

  @override
  void initState() {
    super.initState();

    first = LocalStorage.instance.read(StorageKey.first.name) ?? '';
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        if (first == '') {
          if (context.mounted) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (ctx) => Builder(builder: (context) {
                return StatefulBuilder(
                  builder: (context, StateSetter setState) {
                    return AlertDialog(
                      surfaceTintColor: Colors.white,
                      backgroundColor: Colors.white,
                      content: SizedBox(
                        height: 1.sh,
                        width: 1.sw,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: WebViewWidget(
                                  controller: WebViewController()
                                    ..loadHtmlString(Global.language ==
                                            Language.zh.name
                                        ? Global.policyZh
                                        : Global.language == Language.vi.name
                                            ? Global.policyVi
                                            : Global.language ==
                                                    Language.hi.name
                                                ? Global.policyHi
                                                : Global.policyEn)),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                  activeColor: darkColor,
                                  side: BorderSide(
                                    width: 1.5,
                                    color: isChecked ? darkColor : Colors.black,
                                  ),
                                  value: isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked = value!;
                                      if (isChecked) {
                                        isAccepted = true;
                                      } else {
                                        isAccepted = false;
                                      }
                                    });
                                  },
                                ),
                                Expanded(
                                  child: CustomText(
                                    text: 'agree'.tr,
                                    color: darkColor,
                                    fontSize: 11.sp,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            CustomButton(
                              text: 'accept'.tr,
                              size: 11.sp,
                              width: 100.w,
                              height: 25.h,
                              isRounded: true,
                              outlineColor:
                                  isAccepted ? darkColor : Colors.grey,
                              bgColor: isAccepted ? darkColor : Colors.grey,
                              onTap: isAccepted
                                  ? () async {
                                      LocalStorage.instance.write(
                                          StorageKey.first.name, 'notfirst');
                                      Navigator.pop(context);
                                    }
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            );
          }
        }
      } catch (e) {
        // print("Error fetching SharedPreferences: $e");
      }
    });
  }

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
                      CustomText(
                        text: 'choose_player'.tr,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
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
