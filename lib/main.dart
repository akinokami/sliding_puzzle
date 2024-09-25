import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sliding_puzzle/generated/l10n.dart';
import 'package:sliding_puzzle/language/languages.dart';
import 'package:sliding_puzzle/services/inject_dependencies.dart';
import 'package:sliding_puzzle/services/local_storage.dart';
import 'package:sliding_puzzle/view/global/controllers/theme_controller.dart';
import 'package:sliding_puzzle/view/global/enum.dart';
import 'package:sliding_puzzle/view/global/global.dart';
import 'package:sliding_puzzle/view/routes/app_routes.dart';
import 'package:sliding_puzzle/view/routes/routes.dart';
import 'package:url_strategy/url_strategy.dart';
import 'view/global/widgets/max_text_scale_factor.dart';

void main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await injectDependencies();
  await LocalStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Global.language = LocalStorage.instance.read(StorageKey.language.name) ??
        Language.en.name;
    return ChangeNotifierProvider(
      create: (_) => ThemeController(),
      child: Consumer<ThemeController>(
        builder: (_, controller, __) => ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return GetMaterialApp(
              builder: (_, page) => MaxTextScaleFactor(
                child: page!,
              ),
              // localizationsDelegates: const [
              //   S.delegate,
              //   GlobalMaterialLocalizations.delegate,
              //   GlobalWidgetsLocalizations.delegate,
              //   GlobalCupertinoLocalizations.delegate,
              // ],
              // supportedLocales: const [
              //   Locale('en'),
              //   Locale('es'),
              // ],
              translations: Languages(),
              locale: Global.language == Language.zh.name
                  ? const Locale('zh', 'CN')
                  : Global.language == Language.vi.name
                      ? const Locale('vi', 'VN')
                      : Global.language == Language.hi.name
                          ? const Locale('hi', 'IN')
                          : const Locale('en', 'US'),
              fallbackLocale: const Locale('en', 'US'),
              debugShowCheckedModeBanner: false,
              themeMode: controller.themeMode,
              // theme: controller.lightTheme,
              darkTheme: controller.darkTheme,
              initialRoute: Routes.splash,
              routes: appRoutes,
            );
          },
        ),
      ),
    );
  }
}
