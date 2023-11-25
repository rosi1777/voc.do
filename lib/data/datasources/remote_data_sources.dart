import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:todo_dafault/common/exception.dart';
import 'package:todo_dafault/data/model/counter_response_model.dart';
import 'package:todo_dafault/data/model/task_response_model.dart';
import 'package:todo_dafault/data/model/user_response_model.dart';

abstract class RemoteDataSource {
  Future<dynamic> signUp(
    String name,
    String email,
    String password,
    String confirmPassword,
  );
  Future<UserResponseModel> signIn(
    String email,
    String password,
  );
  Future<TaskResponseModel> getAllTask(String token);
  Future<TaskResponseModel> getTodayTask(String token);
  Future<TaskResponseModel> getOverdueTask(String token);
  Future<TaskResponseModel> getDoneTask(String token);
  Future<TaskResponseModel> getTodoTask(String token);
  Future<CounterResponseModel> getCounterTask(String token);
  Future<dynamic> addTask(
    String token,
    String tittle,
    String description,
    String time,
  );
  // ignore: long-parameter-list
  Future<dynamic> updateTask(
    String token,
    String id,
    String tittle,
    String description,
    String time,
  );
  Future<dynamic> deleteTask(String token, String id);
  Future<dynamic> markAsDoneTask(String token, String id);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  static const String baseUrl = 'https://vocasia.my.id';
  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  @override
  Future<dynamic> signUp(
    String name,
    String email,
    String password,
    String confirmPassword,
  ) async {
    final response = await client.post(Uri.parse('$baseUrl/register'), body: {
      "name": name,
      "email": email,
      "password": password,
      "confirmpassword": confirmPassword,
    });

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserResponseModel> signIn(
    String email,
    String password,
  ) async {
    final response = await client.post(Uri.parse('$baseUrl/login'), body: {
      "email": email,
      "password": password,
    });

    if (response.statusCode == 200) {
      return UserResponseModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TaskResponseModel> getAllTask(String token) async {
    final response = await client.get(
      Uri.parse('$baseUrl/todolist'),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return TaskResponseModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TaskResponseModel> getTodayTask(String token) async {
    final response = await client.get(
      Uri.parse('$baseUrl/todolist/today'),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return TaskResponseModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TaskResponseModel> getOverdueTask(String token) async {
    final response = await client.get(
      Uri.parse('$baseUrl/todolist/overdue'),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return TaskResponseModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TaskResponseModel> getDoneTask(String token) async {
    final response = await client.get(
      Uri.parse('$baseUrl/todolist/done'),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return TaskResponseModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TaskResponseModel> getTodoTask(String token) async {
    final response = await client.get(
      Uri.parse('$baseUrl/todolist/todo'),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return TaskResponseModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<CounterResponseModel> getCounterTask(String token) async {
    final response = await client.get(
      Uri.parse('$baseUrl/todolist/stats'),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return CounterResponseModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<dynamic> markAsDoneTask(String token, String id) async {
    final response = await client.put(
      Uri.parse('$baseUrl/todolist/markasdone/$id'),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<dynamic> deleteTask(String token, String id) async {
    final response = await client.delete(
      Uri.parse('$baseUrl/todolist/delete/$id'),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<dynamic> addTask(
    String token,
    String tittle,
    String description,
    String time,
  ) async {
    final response = await client.post(
      Uri.parse('$baseUrl/todolist/create'),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      body: {'tittle': tittle, 'description': description, 'time': time},
    );

    log(response.body);

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw ServerException();
    }
  }

  @override
  // ignore: long-parameter-list
  Future<dynamic> updateTask(
    String token,
    String id,
    String tittle,
    String description,
    String time,
  ) async {
    final response = await client.put(
      Uri.parse('$baseUrl/todolist/update/$id'),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      body: {'tittle': tittle, 'description': description, 'time': time},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw ServerException();
    }
  }
}
