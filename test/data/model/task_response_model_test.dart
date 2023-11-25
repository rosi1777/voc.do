import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:todo_dafault/data/model/task_list_model.dart';
import 'package:todo_dafault/data/model/task_model.dart';
import 'package:todo_dafault/data/model/task_response_model.dart';
import 'package:todo_dafault/domain/entities/task.dart';
import 'package:todo_dafault/domain/entities/task_list.dart';
import 'package:todo_dafault/domain/entities/task_response.dart';

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

  const tTaskListModel = TaskListModel(taskList: <TaskModel>[tTaskModel]);
  const tTaskList = TaskList(taskList: <Task>[tTask]);

  const tTaskResponseModel =
      TaskResponseModel(status: 200, error: null, messages: tTaskListModel);

  const tTaskResponse =
      TaskResponse(status: 200, error: null, messages: tTaskList);

  group('Parsing JSON', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/all_task.json'));
      // act
      final result = TaskResponseModel.fromJson(jsonMap);
      // assert
      expect(result, tTaskResponseModel);
    });

    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTaskResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "status": 200,
        "error": null,
        "messages": {
          "list": [
            {
              "id": "10",
              "user_id": "4",
              "tittle": "Test menampilkan data todo",
              "description": "Mencoba mengubah data to-do",
              "time": "2022-03-09 07:00:00",
              "status": "1",
            },
          ],
        },
      };
      expect(result, expectedJsonMap);
    });
  });

  test('should be a subclass of TaskResponse entity', () async {
    final result = tTaskResponseModel.toEntity();
    expect(result, tTaskResponse);
  });
}
