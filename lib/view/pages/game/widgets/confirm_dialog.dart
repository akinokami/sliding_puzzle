import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
//import 'package:sliding_puzzle/generated/l10n.dart';
import 'package:sliding_puzzle/view/global/widgets/up_to_down.dart';
import 'package:sliding_puzzle/view/utils/colors.dart';
//import 'package:sliding_puzzle/view/utils/dark_mode_extension.dart';

Future<bool> showConfirmDialog(BuildContext context) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) {
      //final texts = S.current;
      //final isDarkMode = context.isDarkMode;
      return Center(
        child: UpToDown(
          child: Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: //isDarkMode ? darkColor : lightColor,
                darkColor,
            child: SizedBox(
              width: 320,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 25,
                    ),
                    child: Transform.scale(
                      scale: 1.5,
                      child: Image.asset(
                        'assets/images/restart.png',
                        width: 30.w,
                      ),
                    ),
                  ),
                  Text(
                    'are_you_sure'.tr,
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Text(
                      // texts.dou_you_really,
                      'do_you_restart'.tr,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(
                            context,
                            true,
                          ),
                          child: Text('yes'.tr),
                          //Text(texts.yes),
                        ),
                      ),
                      Container(
                        height: 20,
                        width: 1,
                        // color: (isDarkMode ? Colors.white : darkColor)
                        //     .withOpacity(0.2),
                        color: Colors.white.withOpacity(0.2),
                      ),
                      Expanded(
                        child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: //Text(texts.no),
                                Text('no'.tr)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
  return result ?? false;
}
