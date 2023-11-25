import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_dafault/data/datasources/shared_preference/preferences_service.dart';

void main() {
  const String mockToken = 'mockToken';
  const String mockName = 'mockName';
  const String mockEmail = 'mockEmail';

  SharedPreferences.setMockInitialValues({});

  late PreferencesService preferencesService;

  setUp(() async {
    preferencesService = PreferencesService(
      sharedPreferences: SharedPreferences.getInstance(),
    );
  });

  test('get and set token preference', () async {
    expect(await preferencesService.token, '');

    preferencesService.setTokenPreference(mockToken);
    expect(await preferencesService.token, mockToken);
  });

  test('get and set name preference', () async {
    expect(await preferencesService.name, '');

    preferencesService.setNamePreference(mockName);
    expect(await preferencesService.name, mockName);
  });

  test('get and set email preference', () async {
    expect(await preferencesService.email, '');

    preferencesService.setEmailPreference(mockEmail);
    expect(await preferencesService.email, mockEmail);
  });

  test('get and set onBoarding preference', () async {
    expect(await preferencesService.isOnBoardingViewed, false);

    preferencesService.setOnBoardingPreference(true);
    expect(await preferencesService.isOnBoardingViewed, true);
  });

  test('logout clears all preferences', () async {
    preferencesService.setTokenPreference(mockToken);
    preferencesService.setNamePreference(mockName);
    preferencesService.setEmailPreference(mockEmail);
    preferencesService.setOnBoardingPreference(true);

    expect(await preferencesService.token, mockToken);
    expect(await preferencesService.name, mockName);
    expect(await preferencesService.email, mockEmail);
    expect(await preferencesService.isOnBoardingViewed, true);

    preferencesService.logout();

    expect(await preferencesService.token, '');
    expect(await preferencesService.name, '');
    expect(await preferencesService.email, '');
    expect(await preferencesService.isOnBoardingViewed, false);
  });
}
