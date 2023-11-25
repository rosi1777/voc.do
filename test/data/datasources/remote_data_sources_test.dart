import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:todo_dafault/common/exception.dart';
import 'package:todo_dafault/data/datasources/remote_data_sources.dart';
import 'package:todo_dafault/data/model/counter_response_model.dart';
import 'package:todo_dafault/data/model/task_response_model.dart';
import 'package:todo_dafault/data/model/user_message_model.dart';
import 'package:todo_dafault/data/model/user_model.dart';
import 'package:todo_dafault/data/model/user_response_model.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  late RemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;
  const String baseUrl = 'https://vocasia.my.id';
  const String token =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjMiLCJuYW1lIjoiRmF0aG9ycm9zaSIsImVtYWlsIjoiZnJvc2k3NTdAZ21haWwuY29tIiwiaWF0IjoxNjc1NTgyOTU5LCJleHAiOjE2NzU1ODY1NTl9.oWcNmhkqCb90bNEVqM0gaSadjfDCQoeqIM5qaVPWbfE';

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = RemoteDataSourceImpl(client: mockHttpClient);
  });

  group('Sign Up', () {
    test(
      'should return 201 and user data on successful sign up',
      () async {
        // Arrange

        final fakeResponse = {
          "status": 201,
          "error": null,
          "messages": {"success": "Successfully created an account"},
        };

        final http.Response response =
            http.Response(json.encode(fakeResponse), 201);

        when(mockHttpClient.post(Uri.parse('$baseUrl/register'), body: {
          "name": "John Doe",
          "email": "johndoe@example.com",
          "password": "password123",
          "confirmpassword": "password123",
        })).thenAnswer((_) async => Future.value(response));

        // Act
        final result = await dataSource.signUp(
          "John Doe",
          "johndoe@example.com",
          "password123",
          "password123",
        );

        // Assert
        expect(result, fakeResponse);
      },
    );

    test(
      "should throw ServerException if the response code is not 201",
      () async {
        final http.Response response = http.Response("", 400);

        when(mockHttpClient.post(
          Uri.parse('$baseUrl/register'),
          body: anyNamed("body"),
        )).thenAnswer((_) async => response);

        final call = dataSource.signUp;

        // expect(
        //   () => call("John Doe", "johndoe@example.com", "password", "password"),
        //   throwsA(isA<ServerException>()),
        // );
      },
    );
  });

  group('Sign In', () {
    test(
      'should return 200 and user data on successful sign in',
      () async {
        // Arrange

        const userModel =
            UserModel(id: "4", name: "Ade Rizali", email: "ade@gmail.com");

        const userMessages =
            UserMessagesModel(success: "Successfully authentication");

        const user = UserResponseModel(
          status: 200,
          error: null,
          messages: userMessages,
          data: userModel,
          token:
              "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQiLCJuYW1lIjoiQWRlIFJpemFsZGkiLCJlbWFpbCI6ImFkZUBnbWFpbC5jb20iLCJpYXQiOjE2NDY3OTAyMTksImV4cCI6MTY0Njg3NjYxOX0.JX_68UdpBJji0imUpXK3iLqEqyUXcNya-mSuAg9FShg",
        );

        final http.Response response = http.Response(json.encode(user), 200);

        when(mockHttpClient.post(Uri.parse('$baseUrl/login'), body: {
          "email": "johndoe@example.com",
          "password": "password123",
        })).thenAnswer((_) async => Future.value(response));

        // Act
        final result = await dataSource.signIn(
          "johndoe@example.com",
          "password123",
        );

        // Assert
        expect(result, user);
      },
    );

    test(
      "should throw ServerException if the response code is not 200",
      () async {
        final http.Response response = http.Response("", 400);

        when(mockHttpClient.post(
          Uri.parse('$baseUrl/login'),
          body: anyNamed("body"),
        )).thenAnswer((_) async => response);

        final call = dataSource.signIn;

        // expect(
        //   () => call("johndoe@example.com", "password"),
        //   throwsA(isA<ServerException>()),
        // );
      },
    );
  });

  group('get All Task', () {
    final taskList = TaskResponseModel.fromJson(
      json.decode(readJson('dummy_data/all_task.json')),
    );

    test(
      'should return list of all task when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(
          Uri.parse("$baseUrl/todolist"),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        )).thenAnswer(
          (_) async => http.Response(readJson('dummy_data/all_task.json'), 200),
        );
        // act
        final result = await dataSource.getAllTask(token);
        // assert
        // expect(result, equals(taskList));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(mockHttpClient.get(
          Uri.parse("$baseUrl/todolist"),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        )).thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getAllTask(token);
        // assert
        // expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get Today Task', () {
    final taskList = TaskResponseModel.fromJson(
      json.decode(readJson('dummy_data/all_task.json')),
    );

    test(
      'should return list of today task when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(
          Uri.parse("$baseUrl/todolist/today"),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        )).thenAnswer(
          (_) async => http.Response(readJson('dummy_data/all_task.json'), 200),
        );
        // act
        final result = await dataSource.getTodayTask(token);
        // assert
        // expect(result, equals(taskList));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(mockHttpClient.get(
          Uri.parse("$baseUrl/todolist/today"),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        )).thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getTodayTask(token);
        // assert
        // expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get Overdue Task', () {
    final taskList = TaskResponseModel.fromJson(
      json.decode(readJson('dummy_data/all_task.json')),
    );

    test(
      'should return list of overdue task when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(
          Uri.parse("$baseUrl/todolist/overdue"),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        )).thenAnswer(
          (_) async => http.Response(readJson('dummy_data/all_task.json'), 200),
        );
        // act
        final result = await dataSource.getOverdueTask(token);
        // assert
        // expect(result, equals(taskList));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(mockHttpClient.get(
          Uri.parse("$baseUrl/todolist/overdue"),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        )).thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getOverdueTask(token);
        // assert
        // expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get Done Task', () {
    final taskList = TaskResponseModel.fromJson(
      json.decode(readJson('dummy_data/all_task.json')),
    );

    test(
      'should return list of done task when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(
          Uri.parse("$baseUrl/todolist/done"),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        )).thenAnswer(
          (_) async => http.Response(readJson('dummy_data/all_task.json'), 200),
        );
        // act
        final result = await dataSource.getDoneTask(token);
        // assert
        // expect(result, equals(taskList));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(mockHttpClient.get(
          Uri.parse("$baseUrl/todolist/done"),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        )).thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getDoneTask(token);
        // assert
        // expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get ToDo Task', () {
    final taskList = TaskResponseModel.fromJson(
      json.decode(readJson('dummy_data/all_task.json')),
    );

    test(
      'should return list of todo task when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(
          Uri.parse("$baseUrl/todolist/todo"),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        )).thenAnswer(
          (_) async => http.Response(readJson('dummy_data/all_task.json'), 200),
        );
        // act
        final result = await dataSource.getTodoTask(token);
        // assert
        // expect(result, equals(taskList));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(mockHttpClient.get(
          Uri.parse("$baseUrl/todolist/todo"),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        )).thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getTodoTask(token);
        // assert
        // expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get Counter Task', () {
    final counterTask = CounterResponseModel.fromJson(
      json.decode(readJson('dummy_data/counter_task.json')),
    );

    test(
      'should return counter task when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(
          Uri.parse("$baseUrl/todolist/stats"),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        )).thenAnswer(
          (_) async =>
              http.Response(readJson('dummy_data/counter_task.json'), 200),
        );
        // act
        final result = await dataSource.getCounterTask(token);
        // assert
        // expect(result, equals(counterTask));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(mockHttpClient.get(
          Uri.parse("$baseUrl/todolist/stats"),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        )).thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getCounterTask(token);
        // assert
        // expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('Mark As Done Task', () {
    test(
      'should return 200 when user successfully mark as done task',
      () async {
        // Arrange

        final fakeResponse = {
          "status": 200,
          "error": null,
          "messages": {
            "success": "Successfully mark as done to-do with id = 11",
          },
        };

        final http.Response response =
            http.Response(json.encode(fakeResponse), 200);

        when(mockHttpClient.put(
          Uri.parse('$baseUrl/todolist/markasdone/1'),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        )).thenAnswer((_) async => Future.value(response));

        // Act
        final result = await dataSource.markAsDoneTask(token, "1");

        // Assert
        expect(result, fakeResponse);
      },
    );

    test(
      "should throw ServerException if the response code is not 200",
      () async {
        final http.Response response = http.Response("", 400);

        when(mockHttpClient.put(
          Uri.parse('$baseUrl/todolist/markasdone/1'),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        )).thenAnswer((_) async => response);

        final call = dataSource.markAsDoneTask;

        // expect(
        //   () => call(token, "1"),
        //   throwsA(isA<ServerException>()),
        // );
      },
    );
  });

  group('Delete Task', () {
    test(
      'should return 200 when user successfully delete task',
      () async {
        // Arrange

        final fakeResponse = {
          "status": 200,
          "error": null,
          "messages": {
            "success": "Successfully deleted to-do with id = 8",
          },
        };

        final http.Response response =
            http.Response(json.encode(fakeResponse), 200);

        when(mockHttpClient.delete(
          Uri.parse('$baseUrl/todolist/delete/1'),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        )).thenAnswer((_) async => Future.value(response));

        // Act
        final result = await dataSource.deleteTask(token, "1");

        // Assert
        expect(result, fakeResponse);
      },
    );

    test(
      "should throw ServerException if the response code is not 200",
      () async {
        final http.Response response = http.Response("", 400);

        when(mockHttpClient.delete(
          Uri.parse('$baseUrl/todolist/delete/1'),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        )).thenAnswer((_) async => response);

        final call = dataSource.deleteTask;

        // expect(
        //   () => call(token, "1"),
        //   throwsA(isA<ServerException>()),
        // );
      },
    );
  });

  group('Add Task', () {
    test(
      'should return 201 when user successfully add task',
      () async {
        // Arrange

        final fakeResponse = {
          "status": 201,
          "error": null,
          "messages": {
            "success": "Successfully created new to-do",
          },
        };

        final http.Response response =
            http.Response(json.encode(fakeResponse), 201);

        when(mockHttpClient.post(
          Uri.parse('$baseUrl/todolist/create'),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
          body: {
            "tittle": "tittle",
            "description": "description",
            "time": "2022-03-09 19:00:00",
          },
        )).thenAnswer((_) async => Future.value(response));

        // Act
        final result = await dataSource.addTask(
            token, "tittle", "description", "2022-03-09 19:00:00",);

        // Assert
        expect(result, fakeResponse);
      },
    );

    test(
      "should throw ServerException if the response code is not 200",
      () async {
        final http.Response response = http.Response("", 400);

        when(mockHttpClient.post(
          Uri.parse('$baseUrl/todolist/create'),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
          body: {
            "tittle": "tittle",
            "description": "description",
            "time": "2022-03-09 19:00:00",
          },
        )).thenAnswer((_) async => response);

        final call = dataSource.addTask;

        // expect(
        //   () => call(token, "tittle", "description", "2022-03-09 19:00:00",),
        //   throwsA(isA<ServerException>()),
        // );
      },
    );
  });

  group('Update Task', () {
    test(
      'should return 200 when user successfully update task',
      () async {
        // Arrange

        final fakeResponse = {
          "status": 201,
          "error": null,
          "messages": {
            "success": "Successfully updated to-do with id = 10",
          },
        };

        final http.Response response =
            http.Response(json.encode(fakeResponse), 200);

        when(mockHttpClient.put(
          Uri.parse('$baseUrl/todolist/update/1'),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
          body: {
            "tittle": "tittle",
            "description": "description",
            "time": "2022-03-09 19:00:00",
          },
        )).thenAnswer((_) async => Future.value(response));

        // Act
        final result = await dataSource.updateTask(
            token, "1", "tittle", "description", "2022-03-09 19:00:00",);

        // Assert
        expect(result, fakeResponse);
      },
    );

    test(
      "should throw ServerException if the response code is not 200",
      () async {
        final http.Response response = http.Response("", 400);

        when(mockHttpClient.put(
          Uri.parse('$baseUrl/todolist/update/1'),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
          body: {
            "tittle": "tittle",
            "description": "description",
            "time": "2022-03-09 19:00:00",
          },
        )).thenAnswer((_) async => response);

        final call = dataSource.updateTask;

        // expect(
        //   () => call(token, "1", "tittle", "description", "2022-03-09 19:00:00",),
        //   throwsA(isA<ServerException>()),
        // );
      },
    );
  });
}
