import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sliding_puzzle/view/global/enum.dart';
import 'package:sliding_puzzle/view/global/widgets/my_icon_button.dart';
import 'package:sliding_puzzle/view/utils/colors.dart';
import 'package:sliding_puzzle/view/widget/custom_card.dart';
import 'package:sliding_puzzle/view/widget/custom_text.dart';

import '../../../controller/language_controller.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languageController = Get.put(LanguageController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: darkColor,
        body: Padding(
          padding: EdgeInsets.all(10.w),
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
                    text: 'change_language'.tr,
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
                    Obx(
                      () => GestureDetector(
                        onTap: () {
                          languageController.changeLanguage("en", "US");
                        },
                        child: CustomCard(
                          widget: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/usa.webp",
                                    width: 20.w,
                                    height: 20.h,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  const CustomText(
                                    text: "English",
                                  )
                                ],
                              ),
                              Icon(
                                languageController.language.value ==
                                        Language.en.name
                                    ? Icons.check_circle
                                    : Icons.check_circle_outline,
                                color: languageController.language.value ==
                                        Language.en.name
                                    ? Colors.green
                                    : Colors.grey,
                                size: 20.sp,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => GestureDetector(
                        onTap: () {
                          languageController.changeLanguage("zh", "CN");
                        },
                        child: CustomCard(
                          widget: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/china.webp",
                                    width: 20.w,
                                    height: 20.h,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  const CustomText(
                                    text: "中文",
                                  )
                                ],
                              ),
                              Icon(
                                languageController.language.value ==
                                        Language.zh.name
                                    ? Icons.check_circle
                                    : Icons.check_circle_outline,
                                color: languageController.language.value ==
                                        Language.zh.name
                                    ? Colors.green
                                    : Colors.grey,
                                size: 20.sp,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => GestureDetector(
                        onTap: () {
                          languageController.changeLanguage("vi", "VN");
                        },
                        child: CustomCard(
                          widget: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/vietnam.webp",
                                    width: 20.w,
                                    height: 20.h,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  const CustomText(
                                    text: "Tiếng Việt",
                                  )
                                ],
                              ),
                              Icon(
                                languageController.language.value ==
                                        Language.vi.name
                                    ? Icons.check_circle
                                    : Icons.check_circle_outline,
                                color: languageController.language.value ==
                                        Language.vi.name
                                    ? Colors.green
                                    : Colors.grey,
                                size: 20.sp,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => GestureDetector(
                        onTap: () {
                          languageController.changeLanguage("hi", "IN");
                        },
                        child: CustomCard(
                          widget: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/india.webp",
                                    width: 20.w,
                                    height: 20.h,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  const CustomText(
                                    text: "हिन्दी",
                                  )
                                ],
                              ),
                              Icon(
                                languageController.language.value ==
                                        Language.hi.name
                                    ? Icons.check_circle
                                    : Icons.check_circle_outline,
                                color: languageController.language.value ==
                                        Language.hi.name
                                    ? Colors.green
                                    : Colors.grey,
                                size: 20.sp,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
