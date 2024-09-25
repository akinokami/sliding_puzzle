import 'package:flutter/material.dart';
import 'package:sliding_puzzle/view/pages/choose_card/choose_card_screen.dart';
import 'package:sliding_puzzle/view/pages/privacy/privacy_view.dart';
import 'package:sliding_puzzle/view/pages/splash/splash_view.dart';
import 'package:sliding_puzzle/view/routes/routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.splash: (_) => const SplashView(),
    Routes.chooseCard: (_) => const ChooseCardScreen(),
    Routes.privacy: (_) => const PrivacyView(),
  };
}
