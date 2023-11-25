import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_dafault/data/datasources/local_data_sources.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late LocalDataSourceImpl localDataSource;
  late MockPreferencesService mockPreferencesService;

  setUp(() {
    mockPreferencesService = MockPreferencesService();
    localDataSource = LocalDataSourceImpl(preferencesService: mockPreferencesService);
  });

  test('Test getEmail', () async {
    when(mockPreferencesService.email).thenAnswer((_) => Future.value('test@example.com'));
    final result = await localDataSource.getEmail();
    expect(result, 'test@example.com');
  });

  test('Test getName', () async {
    when(mockPreferencesService.name).thenAnswer((_) => Future.value('Test User'));
    final result = await localDataSource.getName();
    expect(result, 'Test User');
  });

  test('Test getToken', () async {
    when(mockPreferencesService.token).thenAnswer((_) => Future.value('test_token'));
    final result = await localDataSource.getToken();
    expect(result, 'test_token');
  });

  test('Test isOnBoardingViewed', () async {
    when(mockPreferencesService.isOnBoardingViewed).thenAnswer((_) => Future.value(true));
    final result = await localDataSource.isOnBoardingViewed();
    expect(result, true);
  });

  test('Test setEmail', () {
    localDataSource.setEmail('test@example.com');
    verify(mockPreferencesService.setEmailPreference('test@example.com')).called(1);
  });

  test('Test setName', () {
    localDataSource.setName('Test User');
    verify(mockPreferencesService.setNamePreference('Test User')).called(1);
  });

  test('Test setOnBoarding', () {
    localDataSource.setOnBoarding(true);
    verify(mockPreferencesService.setOnBoardingPreference(true)).called(1);
  });

  test('Test setToken', () {
    localDataSource.setToken('test_token');
    verify(mockPreferencesService.setTokenPreference('test_token')).called(1);
  });
}
