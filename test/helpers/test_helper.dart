import 'package:mockito/annotations.dart';
import 'package:todo_dafault/data/datasources/local_data_sources.dart';
import 'package:todo_dafault/data/datasources/remote_data_sources.dart';
import 'package:todo_dafault/data/datasources/shared_preference/preferences_service.dart';
import 'package:todo_dafault/domain/repositories/repository.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  Repository,
  RemoteDataSource,
  LocalDataSource,
  PreferencesService,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient),
],)
void main() {}