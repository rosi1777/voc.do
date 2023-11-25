import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:todo_dafault/data/model/user_message_model.dart';
import 'package:todo_dafault/domain/entities/user_messages.dart';

import '../../json_reader.dart';

void main() {
  const tUserMessagesModel =
      UserMessagesModel(success: "Successfully authentication");

  const tUserMessages = UserMessages(success: "Successfully authentication");

  group('Parsing JSON', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/user_messages.json'));
      // act
      final result = UserMessagesModel.fromJson(jsonMap);
      // assert
      expect(result, tUserMessagesModel);
    });

    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tUserMessagesModel.toJson();
      // assert
      final expectedJsonMap = {
        "success": "Successfully authentication",
      };
      expect(result, expectedJsonMap);
    });
  });

  test('should be a subclass of UserMessagesModel entity', () async {
    final result = tUserMessagesModel.toEntity();
    expect(result, tUserMessages);
  });
}
