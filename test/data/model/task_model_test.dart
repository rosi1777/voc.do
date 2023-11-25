import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:todo_dafault/data/model/task_model.dart';
import 'package:todo_dafault/domain/entities/task.dart';

import '../../json_reader.dart';

void main() {
  const tTaskModel = TaskModel(
    id: "10",
    userId: "4",
    tittle: "Test menampilkan data todo",
    description: "Mencoba mengubah data to-do",
    time: "2022-03-09 07:00:00",
    status: "1",
  );

  const tTask = Task(
    id: "10",
    userId: "4",
    tittle: "Test menampilkan data todo",
    description: "Mencoba mengubah data to-do",
    time: "2022-03-09 07:00:00",
    status: "1",
  );

  group('Parsing JSON', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/task.json'));
      // act
      final result = TaskModel.fromJson(jsonMap);
      // assert
      expect(result, tTaskModel);
    });

    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTaskModel.toJson();
      // assert
      final expectedJsonMap = {
        "id": "10",
        "user_id": "4",
        "tittle": "Test menampilkan data todo",
        "description": "Mencoba mengubah data to-do",
        "time": "2022-03-09 07:00:00",
        "status": "1",
      };
      expect(result, expectedJsonMap);
    });
  });

  test('should be a subclass of Task entity', () async {
    final result = tTaskModel.toEntity();
    expect(result, tTask);
  });
}
