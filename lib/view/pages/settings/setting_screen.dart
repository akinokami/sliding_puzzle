import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_puzzle/view/global/widgets/my_icon_button.dart';
import 'package:sliding_puzzle/view/utils/colors.dart';

class SettingScreeen extends StatelessWidget {
  const SettingScreeen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    'setting'.tr,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Container()
            ],
          ),
        ),
      ),
    );
  }
}
