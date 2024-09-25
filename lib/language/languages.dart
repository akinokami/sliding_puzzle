import 'package:sliding_puzzle/language/vi_language.dart';
import 'package:sliding_puzzle/language/zh_language.dart';
import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'en_language.dart';
import 'hindi_language.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CN': ZhLanguage().zhLanguage,
        'en_US': EnLanguage().enLanguage,
        'hi_IN': HiLanguage().hiLanguage,
        'vi_VN': ViLanguage().viLanguage,
      };
}
