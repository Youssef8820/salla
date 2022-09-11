import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/network/local/cache_helper.dart';

import '../../modules/login/shop_login_screen.dart';

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    replace(context, ShopLoginScreen());
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  // ignore: avoid_print
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token = '';
