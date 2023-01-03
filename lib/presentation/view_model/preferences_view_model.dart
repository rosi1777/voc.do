import 'package:flutter/foundation.dart';
import 'package:todo_dafault/common/state_enum.dart';
import 'package:todo_dafault/domain/usecases/get_email.dart';
import 'package:todo_dafault/domain/usecases/get_name.dart';
import 'package:todo_dafault/domain/usecases/get_token.dart';
import 'package:todo_dafault/domain/usecases/is_on_boarding_viewed.dart';
import 'package:todo_dafault/domain/usecases/logout.dart';
import 'package:todo_dafault/domain/usecases/set_email.dart';
import 'package:todo_dafault/domain/usecases/set_name.dart';
import 'package:todo_dafault/domain/usecases/set_on_boarding.dart';
import 'package:todo_dafault/domain/usecases/set_token.dart';

class PreferenceViewModel extends ChangeNotifier {
  final GetName getName;
  final GetEmail getEmail;
  final GetToken getToken;
  final IsOnBoardingViewed isOnBoardingViewed;
  final Logout logout;
  final SetName setName;
  final SetEmail setEmail;
  final SetToken setToken;
  final SetOnBoarding setOnBoarding;

  PreferenceViewModel({
    required this.getName,
    required this.getEmail,
    required this.getToken,
    required this.isOnBoardingViewed,
    required this.logout,
    required this.setName,
    required this.setEmail,
    required this.setToken,
    required this.setOnBoarding,
  }) {
    getOnBoardingPreference();
    getTokenPreference();
    getEmailPreference();
    getNamePreference();
  }

  bool _isOnBoardingVieweds = false;
  bool get isOnBoardingVieweds => _isOnBoardingVieweds;
  String _token = "";
  String get token => _token;
  String _name = "";
  String get name => _name;
  String _email = "";
  String get email => _email;

  RequestState _preferenceState = RequestState.empty;
  RequestState get preferenceState => _preferenceState;

  String _message = '';
  String get message => _message;

  Future<void> getOnBoardingPreference() async {
    _preferenceState = RequestState.loading;
    notifyListeners();

    final result = await isOnBoardingViewed.execute();

    await result.fold(
      (failure) async {
        _message = failure.message;
        _preferenceState = RequestState.error;
        notifyListeners();
      },
      (onBoarding) async {
        _preferenceState = RequestState.loaded;
        _isOnBoardingVieweds = onBoarding;
        notifyListeners();
      },
    );
  }

  Future<void> getTokenPreference() async {
    _preferenceState = RequestState.loading;
    notifyListeners();

    final result = await getToken.execute();

    await result.fold(
      (failure) async {
        _message = failure.message;
        _preferenceState = RequestState.error;
        notifyListeners();
      },
      (token) async {
        _preferenceState = RequestState.loaded;
        _token = token!;
        notifyListeners();
      },
    );
  }

  Future<void> getNamePreference() async {
    _preferenceState = RequestState.loading;
    notifyListeners();

    final result = await getName.execute();

    await result.fold(
      (failure) async {
        _message = failure.message;
        _preferenceState = RequestState.error;
        notifyListeners();
      },
      (name) async {
        _preferenceState = RequestState.loaded;
        _name = name!;
        notifyListeners();
      },
    );
  }

  Future<void> getEmailPreference() async {
    _preferenceState = RequestState.loading;
    notifyListeners();

    final result = await getEmail.execute();

    await result.fold(
      (failure) async {
        _message = failure.message;
        _preferenceState = RequestState.error;
        notifyListeners();
      },
      (email) async {
        _preferenceState = RequestState.loaded;
        _email = email!;
        notifyListeners();
      },
    );
  }

  Future logouts() async {
    await logout.execute();
    notifyListeners();
  }

  void setOnBoardingPreference(bool value) async {
    setOnBoarding.execute(value);
    getOnBoardingPreference();
  }

  void setNamePreference(String value) async {
    setName.execute(value);
    getNamePreference();
  }

  void setTokenPreference(String value) async {
    setToken.execute(value);
    getTokenPreference();
  }

  void setEmailPreference(String value) async {
    setEmail.execute(value);
    getEmailPreference();
  }
}
