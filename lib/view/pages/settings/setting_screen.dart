import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:sliding_puzzle/controller/sound_controller.dart';
import 'package:sliding_puzzle/view/global/widgets/my_icon_button.dart';
import 'package:sliding_puzzle/view/pages/settings/language_screen.dart';
import 'package:sliding_puzzle/view/pages/settings/privacy_policy_screen.dart';
import 'package:sliding_puzzle/view/utils/colors.dart';

import '../../widget/custom_card.dart';
import '../../widget/custom_text.dart';

class SettingScreeen extends StatelessWidget {
  const SettingScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    final soundController = Get.put(SoundController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: darkColor,
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  MyIconButton(
                    onPressed: () {
                      Get.back();
                    },
                    iconData: Icons.arrow_back,
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  CustomText(
                    text: 'settings'.tr,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                child: ListView(
                  children: [
                    CustomText(text: 'general'.tr),
                    SizedBox(height: 5.h),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const LanguageScreen());
                      },
                      child: CustomCard(
                        widget: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.language,
                                  size: 18.sp,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                CustomText(text: 'language'.tr)
                              ],
                            ),
                            Row(
                              children: [
                                CustomText(
                                  text: 'lang'.tr,
                                  fontSize: 12.sp,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 18.sp,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Obx(
                      () => CustomCard(
                        widget: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.music_note,
                                  size: 18.sp,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                CustomText(text: 'sound'.tr)
                              ],
                            ),
                            FlutterSwitch(
                              padding: 1.5,
                              height: 23,
                              width: 44,
                              inactiveColor: Colors.grey,
                              activeColor: Colors.green,
                              value: soundController.isMuted.value,
                              onToggle: (val) {
                                soundController.isMuted.value = val;
                                soundController.muteUnmute();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomText(text: 'other'.tr),
                    SizedBox(height: 5.h),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const PrivacyPolicyScreen());
                      },
                      child: CustomCard(
                        widget: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.policy_outlined,
                                  size: 18.sp,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                CustomText(text: 'policy'.tr)
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 18.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomCard(
                      widget: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.info_outline_rounded,
                                size: 18.sp,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              CustomText(text: 'version'.tr),
                            ],
                          ),
                          const CustomText(text: '1.0.0'),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
