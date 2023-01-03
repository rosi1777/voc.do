import 'package:todo_dafault/common/exception.dart';
import 'package:todo_dafault/data/datasources/shared_preference/preferences_service.dart';

abstract class LocalDataSource {
  Future<String?> getToken();
  Future<String?> getName();
  Future<String?> getEmail();
  Future<bool> isOnBoardingViewed();
  Future logOut();
  void setToken(String value);
  void setName(String value);
  void setEmail(String value);
  void setOnBoarding(bool value);
}

class LocalDataSourceImpl implements LocalDataSource {
  final PreferencesService preferencesService;

  LocalDataSourceImpl({required this.preferencesService});

  @override
  Future<String?> getEmail() async {
    try {
      return await preferencesService.email;
    } catch (e) {
      throw PreferenceException(e.toString());
    }
  }

  @override
  Future<String?> getName() async {
    try {
      return await preferencesService.name;
    } catch (e) {
      throw PreferenceException(e.toString());
    }
  }

  @override
  Future<String?> getToken() async {
    try {
      return await preferencesService.token;
    } catch (e) {
      throw PreferenceException(e.toString());
    }
  }

  @override
  Future<bool> isOnBoardingViewed() async {
    try {
      return await preferencesService.isOnBoardingViewed;
    } catch (e) {
      throw PreferenceException(e.toString());
    }
  }

  @override
  void setEmail(String value) {
    try {
      return preferencesService.setEmailPreference(value);
    } catch (e) {
      throw PreferenceException(e.toString());
    }
  }

  @override
  void setName(String value) {
    try {
      return preferencesService.setNamePreference(value);
    } catch (e) {
      throw PreferenceException(e.toString());
    }
  }

  @override
  void setOnBoarding(bool value) {
    try {
      return preferencesService.setOnBoardingPreference(value);
    } catch (e) {
      throw PreferenceException(e.toString());
    }
  }

  @override
  void setToken(String value) {
    try {
      return preferencesService.setTokenPreference(value);
    } catch (e) {
      throw PreferenceException(e.toString());
    }
  }

  @override
  Future logOut() async {
    try {
      return await preferencesService.logout();
    } catch (e) {
      throw PreferenceException(e.toString());
    }
  }
}
