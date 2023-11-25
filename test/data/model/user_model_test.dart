import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:todo_dafault/data/model/user_model.dart';
import 'package:todo_dafault/domain/entities/user.dart';

import '../../json_reader.dart';

void main() {
  const tUserModel =
      UserModel(id: "4", name: "Ade Rizaldi", email: "ade@gmail.com");

  const tUser = User(id: "4", name: "Ade Rizaldi", email: "ade@gmail.com");

  group('Parsing JSON', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/user.json'));
      // act
      final result = UserModel.fromJson(jsonMap);
      // assert
      expect(result, tUserModel);
    });

    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tUserModel.toJson();
      // assert
      final expectedJsonMap = {
        "id": "4",
        "name": "Ade Rizaldi",
        "email": "ade@gmail.com",
      };
      expect(result, expectedJsonMap);
    });
  });

  test('should be a subclass of User Model entity', () async {
    final result = tUserModel.toEntity();
    expect(result, tUser);
  });
}
