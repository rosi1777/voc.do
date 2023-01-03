import 'dart:io';

import 'package:todo_dafault/common/exception.dart';
import 'package:todo_dafault/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_dafault/data/datasources/local_data_sources.dart';
import 'package:todo_dafault/data/datasources/remote_data_sources.dart';
import 'package:todo_dafault/domain/entities/task_response.dart';
import 'package:todo_dafault/domain/entities/counter_response.dart';
import 'package:todo_dafault/domain/entities/user_response.dart';
import 'package:todo_dafault/domain/repositories/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  RepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, dynamic>> addTask(
    String token,
    String tittle,
    String description,
    String time,
  ) async {
    try {
      return Right(
        await remoteDataSource.addTask(
          token,
          tittle,
          description,
          time,
        ),
      );
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, dynamic>> deleteTask(String token, String id) async {
    try {
      return Right(await remoteDataSource.deleteTask(token, id));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, TaskResponse>> getAllTask(String token) async {
    try {
      final result = await remoteDataSource.getAllTask(token);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, CounterResponse>> getCounterTask(String token) async {
    try {
      final result = await remoteDataSource.getCounterTask(token);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, TaskResponse>> getDoneTask(String token) async {
    try {
      final result = await remoteDataSource.getDoneTask(token);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String?>> getEmail() async {
    try {
      final result = await localDataSource.getEmail();

      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String?>> getName() async {
    try {
      final result = await localDataSource.getName();

      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String?>> getToken() async {
    try {
      final result = await localDataSource.getToken();

      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, TaskResponse>> getOverdueTask(String token) async {
    try {
      final result = await remoteDataSource.getOverdueTask(token);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, TaskResponse>> getTodayTask(String token) async {
    try {
      final result = await remoteDataSource.getTodayTask(token);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, TaskResponse>> getTodoTask(String token) async {
    try {
      final result = await remoteDataSource.getTodoTask(token);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, UserResponse>> signIn(
    String email,
    String password,
  ) async {
    try {
      final result = await remoteDataSource.signIn(email, password);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, bool>> isOnBoardingViewed() async {
    try {
      final result = await localDataSource.isOnBoardingViewed();

      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future logout() async {
    return await localDataSource.logOut();
  }

  @override
  Future<Either<Failure, dynamic>> markAsDoneTask(
    String token,
    String id,
  ) async {
    try {
      return Right(await remoteDataSource.markAsDoneTask(token, id));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  void setEmail(String value) {
    return localDataSource.setEmail(value);
  }

  @override
  void setName(String value) {
    return localDataSource.setName(value);
  }

  @override
  void setOnBoarding(bool value) {
    return localDataSource.setOnBoarding(value);
  }

  @override
  void setToken(String value) {
    return localDataSource.setToken(value);
  }

  @override
  Future<Either<Failure, dynamic>> signUp(
    String name,
    String email,
    String password,
    String confirmPassword,
  ) async {
    try {
      return Right(await remoteDataSource.signUp(
        name,
        email,
        password,
        confirmPassword,
      ));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  // ignore: long-parameter-list
  Future<Either<Failure, dynamic>> updateTask(
    String token,
    String id,
    String tittle,
    String description,
    String time,
  ) async {
    try {
      return Right(await remoteDataSource.updateTask(
        token,
        id,
        tittle,
        description,
        time,
      ));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
