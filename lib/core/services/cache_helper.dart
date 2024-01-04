import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  Future<CacheHelper> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }
}
