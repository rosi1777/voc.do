import 'package:dartz/dartz.dart';
import 'package:todo_dafault/domain/entities/task_response.dart';
import 'package:todo_dafault/domain/entities/user_response.dart';

import '../../common/failure.dart';
import '../entities/counter_response.dart';

abstract class Repository {
  Future<Either<Failure, dynamic>> signUp(
    String name,
    String email,
    String password,
    String confirmPassword,
  );

  Future<Either<Failure, UserResponse>> signIn(
    String email,
    String password,
  );

  Future<Either<Failure, dynamic>> addTask(
    String token,
    String tittle,
    String description,
    String time,
  );

  // ignore: long-parameter-list
  Future<Either<Failure, dynamic>> updateTask(
    String token,
    String id,
    String tittle,
    String description,
    String time,
  );

  Future<Either<Failure, dynamic>> deleteTask(String token, String id);
  Future<Either<Failure, dynamic>> markAsDoneTask(String token, String id);
  Future<Either<Failure, TaskResponse>> getAllTask(String token);
  Future<Either<Failure, TaskResponse>> getTodayTask(String token);
  Future<Either<Failure, TaskResponse>> getOverdueTask(String token);
  Future<Either<Failure, TaskResponse>> getDoneTask(String token);
  Future<Either<Failure, TaskResponse>> getTodoTask(String token);
  Future<Either<Failure, CounterResponse>> getCounterTask(String token);
  Future<Either<Failure, String?>> getToken();
  Future<Either<Failure, String?>> getName();
  Future<Either<Failure, String?>> getEmail();
  Future<Either<Failure, bool>> isOnBoardingViewed();
  Future logout();
  void setToken(String value);
  void setName(String value);
  void setEmail(String value);
  void setOnBoarding(bool value);
}
