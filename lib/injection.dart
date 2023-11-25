import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_dafault/data/datasources/shared_preference/preferences_service.dart';
import 'package:todo_dafault/domain/usecases/add_task.dart';
import 'package:todo_dafault/domain/usecases/get_email.dart';
import 'package:todo_dafault/domain/usecases/get_name.dart';
import 'package:todo_dafault/domain/usecases/get_overdue_task.dart';
import 'package:todo_dafault/domain/usecases/get_today_task.dart';
import 'package:todo_dafault/domain/usecases/get_token.dart';
import 'package:todo_dafault/domain/usecases/is_on_boarding_viewed.dart';
import 'package:todo_dafault/domain/usecases/logout.dart';
import 'package:todo_dafault/domain/usecases/mark_as_done_task.dart';
import 'package:todo_dafault/domain/usecases/set_name.dart';
import 'package:todo_dafault/domain/usecases/set_on_boarding.dart';
import 'package:todo_dafault/domain/usecases/set_token.dart';
import 'package:todo_dafault/domain/usecases/sign_in.dart';
import 'package:todo_dafault/domain/usecases/sign_up.dart';
import 'package:todo_dafault/domain/usecases/update_task.dart';
import 'package:todo_dafault/presentation/view_model/auth_view_model.dart';
import 'package:todo_dafault/presentation/view_model/counter_view_model.dart';
import 'package:todo_dafault/presentation/view_model/preferences_view_model.dart';
import 'package:todo_dafault/presentation/view_model/task_view_model.dart';

import 'data/datasources/local_data_sources.dart';
import 'data/datasources/remote_data_sources.dart';
import 'data/repositories/repository_impl.dart';
import 'domain/repositories/repository.dart';
import 'domain/usecases/delete_task.dart';
import 'domain/usecases/get_all_task.dart';
import 'domain/usecases/get_counter_task.dart';
import 'domain/usecases/get_done_task.dart';
import 'domain/usecases/get_todo_task.dart';
import 'domain/usecases/set_email.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

// ignore: long-method
void init() {
  // viewmodel

  locator.registerFactory(
    () => AuthViewModel(
      signUp: locator(),
      signIn: locator(),
    ),
  );

  locator.registerFactory(() => CounterViewModel(getCounterTask: locator()));

  locator.registerFactory(() => TaskViewModel(
        addTask: locator(),
        deleteTask: locator(),
        getAllTask: locator(),
        getDoneTask: locator(),
        getOverdueTask: locator(),
        getTodayTask: locator(),
        getTodoTask: locator(),
        updateTask: locator(),
        markAsDoneTask: locator(),
      ));

  locator.registerFactory(() => PreferenceViewModel(
        getName: locator(),
        getEmail: locator(),
        getToken: locator(),
        isOnBoardingViewed: locator(),
        logout: locator(),
        setName: locator(),
        setEmail: locator(),
        setToken: locator(),
        setOnBoarding: locator(),
      ));

  //usecase
  locator.registerLazySingleton(() => AddTask(locator()));
  locator.registerLazySingleton(() => DeleteTask(locator()));
  locator.registerLazySingleton(() => GetAllTask(locator()));
  locator.registerLazySingleton(() => GetCounterTask(locator()));
  locator.registerLazySingleton(() => GetDoneTask(locator()));
  locator.registerLazySingleton(() => GetEmail(locator()));
  locator.registerLazySingleton(() => GetName(locator()));
  locator.registerLazySingleton(() => GetOverdueTask(locator()));
  locator.registerLazySingleton(() => GetTodayTask(locator()));
  locator.registerLazySingleton(() => GetTodoTask(locator()));
  locator.registerLazySingleton(() => GetToken(locator()));
  locator.registerLazySingleton(() => IsOnBoardingViewed(locator()));
  locator.registerLazySingleton(() => Logout(locator()));
  locator.registerLazySingleton(() => MarkAsDoneTask(locator()));
  locator.registerLazySingleton(() => SetEmail(locator()));
  locator.registerLazySingleton(() => SetName(locator()));
  locator.registerLazySingleton(() => SetOnBoarding(locator()));
  locator.registerLazySingleton(() => SetToken(locator()));
  locator.registerLazySingleton(() => SignIn(locator()));
  locator.registerLazySingleton(() => SignUp(locator()));
  locator.registerLazySingleton(() => UpdateTask(locator()));

  // repository
  locator.registerLazySingleton<Repository>(
    () => RepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(client: locator()),
  );

  locator.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(preferencesService: locator()),
  );

  // sharedPreference
  locator.registerLazySingleton<PreferencesService>(() =>
      PreferencesService(sharedPreferences: SharedPreferences.getInstance()));

  // external
  locator.registerLazySingleton(() => http.Client());
}
