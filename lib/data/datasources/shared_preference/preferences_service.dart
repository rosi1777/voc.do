import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesService({required this.sharedPreferences});

  static const onBoardingPreferenceKey = 'onBoarding';
  static const tokenPreferenceKey = 'token';
  static const namePreferenceKey = 'name';
  static const emailPreferenceKey = 'email';

  Future<String?> get token async {
    final prefs = await sharedPreferences;

    return prefs.getString(tokenPreferenceKey) ?? "";
  }

  void setTokenPreference(String value) async {
    final prefs = await sharedPreferences;
    prefs.setString(tokenPreferenceKey, value);
  }

  Future<String?> get name async {
    final prefs = await sharedPreferences;

    return prefs.getString(namePreferenceKey) ?? "";
  }

  void setNamePreference(String value) async {
    final prefs = await sharedPreferences;
    prefs.setString(namePreferenceKey, value);
  }

  Future<String?> get email async {
    final prefs = await sharedPreferences;

    return prefs.getString(emailPreferenceKey) ?? "";
  }

  void setEmailPreference(String value) async {
    final prefs = await sharedPreferences;
    prefs.setString(emailPreferenceKey, value);
  }

  Future<bool> get isOnBoardingViewed async {
    final prefs = await sharedPreferences;

    return prefs.getBool(onBoardingPreferenceKey) ?? false;
  }

  void setOnBoardingPreference(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(onBoardingPreferenceKey, value);
  }

  Future logout() async {
    final prefs = await sharedPreferences;
    prefs.clear();
  }
}
