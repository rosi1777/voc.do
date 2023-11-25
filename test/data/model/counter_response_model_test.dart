import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:todo_dafault/data/model/counter_model.dart';
import 'package:todo_dafault/data/model/counter_response_model.dart';
import 'package:todo_dafault/domain/entities/counter.dart';
import 'package:todo_dafault/domain/entities/counter_response.dart';

import '../../json_reader.dart';

void main() {
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

  group('Parsing JSON', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/counter_task.json'));
      // act
      final result = CounterResponseModel.fromJson(jsonMap);
      // assert
      expect(result, tCounterResponseModel);
    });

    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tCounterResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "status": 200,
        "error": null,
        "messages": {"todo": 0, "today": 1, "overdue": 0, "done": 0, "all": 5},
      };
      expect(result, expectedJsonMap);
    });
  });

  test('should be a subclass of CounterResponse entity', () async {
    final result = tCounterResponseModel.toEntity();
    expect(result, tCounterResponse);
  });
}
