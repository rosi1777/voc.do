import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:todo_dafault/data/model/counter_model.dart';
import 'package:todo_dafault/domain/entities/counter.dart';

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

  group('Parsing JSON', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/counter.json'));
      // act
      final result = CounterModel.fromJson(jsonMap);
      // assert
      expect(result, tCounterModel);
    });

    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tCounterModel.toJson();
      // assert
      final expectedJsonMap = {
        "todo": 0,
        "today": 1,
        "overdue": 0,
        "done": 0,
        "all": 5,
      };
      expect(result, expectedJsonMap);
    });
  });

  test('should be a subclass of Counter entity', () async {
    final result = tCounterModel.toEntity();
    expect(result, tCounter);
  });
}
