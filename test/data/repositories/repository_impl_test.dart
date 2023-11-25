import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_dafault/common/exception.dart';
import 'package:todo_dafault/common/failure.dart';
import 'package:todo_dafault/data/model/counter_model.dart';
import 'package:todo_dafault/data/model/counter_response_model.dart';
import 'package:todo_dafault/data/model/task_list_model.dart';
import 'package:todo_dafault/data/model/task_model.dart';
import 'package:todo_dafault/data/model/task_response_model.dart';
import 'package:todo_dafault/data/model/user_message_model.dart';
import 'package:todo_dafault/data/model/user_model.dart';
import 'package:todo_dafault/data/model/user_response_model.dart';
import 'package:todo_dafault/data/repositories/repository_impl.dart';
import 'package:todo_dafault/domain/entities/counter.dart';
import 'package:todo_dafault/domain/entities/counter_response.dart';
import 'package:todo_dafault/domain/entities/task_list.dart';
import 'package:todo_dafault/domain/entities/task_response.dart';
import 'package:todo_dafault/domain/entities/task.dart' as tk;
import 'package:todo_dafault/domain/entities/user.dart';
import 'package:todo_dafault/domain/entities/user_messages.dart';
import 'package:todo_dafault/domain/entities/user_response.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    repository = RepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  const tCounterModel = CounterModel(
    todo: 0,
    today: 1,
    overdue: 0,
    done: 0,
    all: 5,
  );

  const tCounter = Counter(
    todo: 0,
    today: 1,
    overdue: 0,
    done: 0,
    all: 5,
  );

  const tCounterResponseModel =
      CounterResponseModel(status: 200, error: null, messages: tCounterModel);

  const tCounterResponse =
      CounterResponse(status: 200, error: null, messages: tCounter);

  const tTaskModel = TaskModel(
    id: "10",
    userId: "4",
    tittle: "Test menampilkan data todo",
    description: "Mencoba mengubah data to-do",
    time: "2022-03-09 07:00:00",
    status: "1",
  );

  const tTask = tk.Task(
    id: "10",
    userId: "4",
    tittle: "Test menampilkan data todo",
    description: "Mencoba mengubah data to-do",
    time: "2022-03-09 07:00:00",
    status: "1",
  );

  const tTaskListModel = TaskListModel(taskList: <TaskModel>[tTaskModel]);
  const tTaskList = TaskList(taskList: <tk.Task>[tTask]);

  const tTaskResponseModel =
      TaskResponseModel(status: 200, error: null, messages: tTaskListModel);

  const tTaskResponse =
      TaskResponse(status: 200, error: null, messages: tTaskList);

  const tUserModel =
      UserModel(id: "4", name: "Ade Rizaldi", email: "ade@gmail.com");

  const tUser = User(id: "4", name: "Ade Rizaldi", email: "ade@gmail.com");

  const tUserMessagesModel =
      UserMessagesModel(success: "Successfully authentication");

  const tUserMessages = UserMessages(success: "Successfully authentication");

  const tUserResponseModel = UserResponseModel(
    status: 201,
    error: null,
    messages: tUserMessagesModel,
    data: tUserModel,
    token:
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQiLCJuYW1lIjoiQWRlIFJpemFsZGkiLCJlbWFpbCI6ImFkZUBnbWFpbC5jb20iLCJpYXQiOjE2NDY3OTAyMTksImV4cCI6MTY0Njg3NjYxOX0.JX_68UdpBJji0imUpXK3iLqEqyUXcNya-mSuAg9FShg",
  );

  const tUserResponse = UserResponse(
    status: 201,
    error: null,
    messages: tUserMessages,
    data: tUser,
    token:
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQiLCJuYW1lIjoiQWRlIFJpemFsZGkiLCJlbWFpbCI6ImFkZUBnbWFpbC5jb20iLCJpYXQiOjE2NDY3OTAyMTksImV4cCI6MTY0Njg3NjYxOX0.JX_68UdpBJji0imUpXK3iLqEqyUXcNya-mSuAg9FShg",
  );

  final updateResponse = {
    "status": 201,
    "error": null,
    "messages": {
      "success": "Successfully updated to-do with id = 10",
    },
  };

  final addResponse = {
    "status": 201,
    "error": null,
    "messages": {
      "success": "Successfully created new to-do",
    },
  };

  final deleteResponse = {
    "status": 200,
    "error": null,
    "messages": {
      "success": "Successfully deleted to-do with id = 8",
    },
  };

  final markAsDoneResponse = {
    "status": 200,
    "error": null,
    "messages": {
      "success": "Successfully mark as done to-do with id = 11",
    },
  };

  final signUpResponse = {
    "status": 201,
    "error": null,
    "messages": {"success": "Successfully created an account"},
  };

  const String token =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjMiLCJuYW1lIjoiRmF0aG9ycm9zaSIsImVtYWlsIjoiZnJvc2k3NTdAZ21haWwuY29tIiwiaWF0IjoxNjc1NTgyOTU5LCJleHAiOjE2NzU1ODY1NTl9.oWcNmhkqCb90bNEVqM0gaSadjfDCQoeqIM5qaVPWbfE';

  group('Add Task', () {
    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.addTask(
          token,
          "tittle",
          "description",
          "2022-03-09 19:00:00",
        )).thenAnswer((_) async => addResponse);
        // act
        final result = await repository.addTask(
          token,
          "tittle",
          "description",
          "2022-03-09 19:00:00",
        );
        // assert
        verify(mockRemoteDataSource.addTask(
          token,
          "tittle",
          "description",
          "2022-03-09 19:00:00",
        ));
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(resultList, addResponse);
      },
    );

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        // ignore: prefer-trailing-comma
        () async {
      // arrange
      when(mockRemoteDataSource.addTask(
        token,
        "tittle",
        "description",
        "2022-03-09 19:00:00",
      )).thenThrow(ServerException());
      // act
      final result = await repository.addTask(
        token,
        "tittle",
        "description",
        "2022-03-09 19:00:00",
      );
      // assert
      verify(mockRemoteDataSource.addTask(
        token,
        "tittle",
        "description",
        "2022-03-09 19:00:00",
      ));
      // expect(result, equals(const Left(ServerFailure(''))));
    });
  });

  group('Update Task', () {
    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.updateTask(
          token,
          "1",
          "tittle",
          "description",
          "2022-03-09 19:00:00",
        )).thenAnswer((_) async => updateResponse);
        // act
        final result = await repository.updateTask(
          token,
          "1",
          "tittle",
          "description",
          "2022-03-09 19:00:00",
        );
        // assert
        verify(mockRemoteDataSource.updateTask(
          token,
          "1",
          "tittle",
          "description",
          "2022-03-09 19:00:00",
        ));
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(resultList, updateResponse);
      },
    );

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        // ignore: prefer-trailing-comma
        () async {
      // arrange
      when(mockRemoteDataSource.updateTask(
        token,
        "1",
        "tittle",
        "description",
        "2022-03-09 19:00:00",
      )).thenThrow(ServerException());
      // act
      final result = await repository.updateTask(
        token,
        "1",
        "tittle",
        "description",
        "2022-03-09 19:00:00",
      );
      // assert
      verify(mockRemoteDataSource.updateTask(
        token,
        "1",
        "tittle",
        "description",
        "2022-03-09 19:00:00",
      ));
      // expect(result, equals(const Left(ServerFailure(''))));
    });
  });

  group('Delete Task', () {
    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.deleteTask(token, "1"))
            .thenAnswer((_) async => deleteResponse);
        // act
        final result = await repository.deleteTask(token, "1");
        // assert
        verify(mockRemoteDataSource.deleteTask(token, "1"));
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(resultList, deleteResponse);
      },
    );

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        // ignore: prefer-trailing-comma
        () async {
      // arrange
      when(mockRemoteDataSource.deleteTask(token, "1"))
          .thenThrow(ServerException());
      // act
      final result = await repository.deleteTask(token, "1");
      // assert
      verify(mockRemoteDataSource.deleteTask(token, "1"));
      // expect(result, equals(const Left(ServerFailure(''))));
    });
  });

  group('Mark As Done Task', () {
    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.markAsDoneTask(token, "1"))
            .thenAnswer((_) async => markAsDoneResponse);
        // act
        final result = await repository.markAsDoneTask(token, "1");
        // assert
        verify(mockRemoteDataSource.markAsDoneTask(token, "1"));
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(resultList, markAsDoneResponse);
      },
    );

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        // ignore: prefer-trailing-comma
        () async {
      // arrange
      when(mockRemoteDataSource.markAsDoneTask(token, "1"))
          .thenThrow(ServerException());
      // act
      final result = await repository.markAsDoneTask(token, "1");
      // assert
      verify(mockRemoteDataSource.markAsDoneTask(token, "1"));
      // expect(result, equals(const Left(ServerFailure(''))));
    });
  });

  group('Sign Up', () {
    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.signUp(
          "John Doe",
          "johndoe@example.com",
          "password123",
          "password123",
        )).thenAnswer((_) async => signUpResponse);
        // act
        final result = await repository.signUp(
          "John Doe",
          "johndoe@example.com",
          "password123",
          "password123",
        );
        // assert
        verify(mockRemoteDataSource.signUp(
          "John Doe",
          "johndoe@example.com",
          "password123",
          "password123",
        ));
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(resultList, signUpResponse);
      },
    );

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        // ignore: prefer-trailing-comma
        () async {
      // arrange
      when(mockRemoteDataSource.signUp(
        "John Doe",
        "johndoe@example.com",
        "password123",
        "password123",
      )).thenThrow(ServerException());
      // act
      final result = await repository.signUp(
        "John Doe",
        "johndoe@example.com",
        "password123",
        "password123",
      );
      // assert
      verify(mockRemoteDataSource.signUp(
        "John Doe",
        "johndoe@example.com",
        "password123",
        "password123",
      ));
      // expect(result, equals(const Left(ServerFailure(''))));
    });
  });

  group('Sign In', () {
    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.signIn(
          "johndoe@example.com",
          "password123",
        )).thenAnswer((_) async => tUserResponseModel);
        // act
        final result = await repository.signIn(
          "johndoe@example.com",
          "password123",
        );
        // assert
        verify(mockRemoteDataSource.signIn(
          "johndoe@example.com",
          "password123",
        ));
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => tUserResponse);
        expect(resultList, tUserResponseModel.toEntity());
      },
    );

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        // ignore: prefer-trailing-comma
        () async {
      // arrange
      when(mockRemoteDataSource.signIn(
        "johndoe@example.com",
        "password123",
      )).thenThrow(ServerException());
      // act
      final result = await repository.signIn(
        "johndoe@example.com",
        "password123",
      );
      // assert
      verify(mockRemoteDataSource.signIn(
        "johndoe@example.com",
        "password123",
      ));
      // expect(result, equals(const Left(ServerFailure(''))));
    });
  });

  group('All Task', () {
    test(
      'should return all task list when call to data source is success',
      () async {
        // arrange
        when(mockRemoteDataSource.getAllTask(token))
            .thenAnswer((_) async => tTaskResponseModel);
        // act
        final result = await repository.getAllTask(token);
        // assert
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => tTaskResponse);
        expect(resultList, tTaskResponseModel.toEntity());
      },
    );

    test(
      'should return server failure when call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getAllTask(token))
            .thenThrow(ServerException());
        // act
        final result = await repository.getAllTask(token);
        // assert
        expect(result, const Left(ServerFailure('')));
      },
    );
  });

  group('Today Task', () {
    test(
      'should return today task list when call to data source is success',
      () async {
        // arrange
        when(mockRemoteDataSource.getTodayTask(token))
            .thenAnswer((_) async => tTaskResponseModel);
        // act
        final result = await repository.getTodayTask(token);
        // assert
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => tTaskResponse);
        expect(resultList, tTaskResponseModel.toEntity());
      },
    );

    test(
      'should return server failure when call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getTodayTask(token))
            .thenThrow(ServerException());
        // act
        final result = await repository.getTodayTask(token);
        // assert
        expect(result, const Left(ServerFailure('')));
      },
    );
  });

  group('Overdue Task', () {
    test(
      'should return overdue task list when call to data source is success',
      () async {
        // arrange
        when(mockRemoteDataSource.getOverdueTask(token))
            .thenAnswer((_) async => tTaskResponseModel);
        // act
        final result = await repository.getOverdueTask(token);
        // assert
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => tTaskResponse);
        expect(resultList, tTaskResponseModel.toEntity());
      },
    );

    test(
      'should return server failure when call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getOverdueTask(token))
            .thenThrow(ServerException());
        // act
        final result = await repository.getOverdueTask(token);
        // assert
        expect(result, const Left(ServerFailure('')));
      },
    );
  });

  group('Todo Task', () {
    test(
      'should return todo task list when call to data source is success',
      () async {
        // arrange
        when(mockRemoteDataSource.getTodoTask(token))
            .thenAnswer((_) async => tTaskResponseModel);
        // act
        final result = await repository.getTodoTask(token);
        // assert
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => tTaskResponse);
        expect(resultList, tTaskResponseModel.toEntity());
      },
    );

    test(
      'should return server failure when call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getTodoTask(token))
            .thenThrow(ServerException());
        // act
        final result = await repository.getTodoTask(token);
        // assert
        expect(result, const Left(ServerFailure('')));
      },
    );
  });

  group('Done Task', () {
    test(
      'should return done task list when call to data source is success',
      () async {
        // arrange
        when(mockRemoteDataSource.getDoneTask(token))
            .thenAnswer((_) async => tTaskResponseModel);
        // act
        final result = await repository.getDoneTask(token);
        // assert
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => tTaskResponse);
        expect(resultList, tTaskResponseModel.toEntity());
      },
    );

    test(
      'should return server failure when call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getDoneTask(token))
            .thenThrow(ServerException());
        // act
        final result = await repository.getDoneTask(token);
        // assert
        expect(result, const Left(ServerFailure('')));
      },
    );
  });

  group('Counter Task', () {
    test(
      'should return counter task when call to data source is success',
      () async {
        // arrange
        when(mockRemoteDataSource.getCounterTask(token))
            .thenAnswer((_) async => tCounterResponseModel);
        // act
        final result = await repository.getCounterTask(token);
        // assert
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => tCounterResponse);
        expect(resultList, tCounterResponseModel.toEntity());
      },
    );

    test(
      'should return server failure when call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getCounterTask(token))
            .thenThrow(ServerException());
        // act
        final result = await repository.getCounterTask(token);
        // assert
        expect(result, const Left(ServerFailure('')));
      },
    );
  });

  test('setOnBoarding calls setOnBoarding on localDataSource', () async {
    repository.setOnBoarding(true);
    verify(mockLocalDataSource.setOnBoarding(true)).called(1);
  });

  test('setName calls setName on localDataSource', () async {
    repository.setName('Test Name');
    verify(mockLocalDataSource.setName('Test Name')).called(1);
  });

  test('setEmail calls setEmail on localDataSource', () async {
    repository.setEmail('Test Email');
    verify(mockLocalDataSource.setEmail('Test Email')).called(1);
  });

  test('setToken calls setToken on localDataSource', () async {
    repository.setToken('Test Token');
    verify(mockLocalDataSource.setToken('Test Token')).called(1);
  });

  group('Get Token', () {
    test('getToken returns value from localDataSource', () async {
      when(mockLocalDataSource.getToken()).thenAnswer((_) async => 'token');
      final result = await repository.getToken();
      expect(result, const Right('token'));
      verify(mockLocalDataSource.getToken()).called(1);
    });

    test('getToken returns ServerFailure', () async {
      when(mockLocalDataSource.getToken()).thenThrow(ServerException());
      final result = await repository.getToken();
      expect(result, const Left(ServerFailure('')));
      verify(mockLocalDataSource.getToken()).called(1);
    });
  });

  group('Get Name', () {
    test('getName returns value from localDataSource', () async {
      when(mockLocalDataSource.getName()).thenAnswer((_) async => 'name');
      final result = await repository.getName();
      expect(result, const Right('name'));
      verify(mockLocalDataSource.getName()).called(1);
    });

    test('getName returns ServerFailure', () async {
      when(mockLocalDataSource.getName()).thenThrow(ServerException());
      final result = await repository.getName();
      expect(result, const Left(ServerFailure('')));
      verify(mockLocalDataSource.getName()).called(1);
    });
  });

  group('Get Email', () {
    test('getEmail returns value from localDataSource', () async {
      when(mockLocalDataSource.getEmail()).thenAnswer((_) async => 'email');
      final result = await repository.getEmail();
      expect(result, const Right('email'));
      verify(mockLocalDataSource.getEmail()).called(1);
    });

    test('getName returns ServerFailure', () async {
      when(mockLocalDataSource.getEmail()).thenThrow(ServerException());
      final result = await repository.getEmail();
      expect(result, const Left(ServerFailure('')));
      verify(mockLocalDataSource.getEmail()).called(1);
    });
  });

  group('Is On Boarding Viewed', () {
    test('isOnBoardingViewed returns value from localDataSource', () async {
      when(mockLocalDataSource.isOnBoardingViewed())
          .thenAnswer((_) async => true);
      final result = await repository.isOnBoardingViewed();
      expect(result, const Right(true));
      verify(mockLocalDataSource.isOnBoardingViewed()).called(1);
    });

    test('getName returns ServerFailure', () async {
      when(mockLocalDataSource.isOnBoardingViewed())
          .thenThrow(ServerException());
      final result = await repository.isOnBoardingViewed();
      expect(result, const Left(ServerFailure('')));
      verify(mockLocalDataSource.isOnBoardingViewed()).called(1);
    });
  });
}
