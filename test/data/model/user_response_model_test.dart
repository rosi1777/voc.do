import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:todo_dafault/data/model/user_message_model.dart';
import 'package:todo_dafault/data/model/user_model.dart';
import 'package:todo_dafault/data/model/user_response_model.dart';
import 'package:todo_dafault/domain/entities/user.dart';
import 'package:todo_dafault/domain/entities/user_messages.dart';
import 'package:todo_dafault/domain/entities/user_response.dart';

import '../../json_reader.dart';

void main() {
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

  group('Parsing JSON', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/user_response_model.json'));
      // act
      final result = UserResponseModel.fromJson(jsonMap);
      // assert
      expect(result, tUserResponseModel);
    });

    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tUserResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "status": 201,
        "error": null,
        "messages": {"success": "Successfully authentication"},
        "data": {"id": "4", "name": "Ade Rizaldi", "email": "ade@gmail.com"},
        "token":
            "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQiLCJuYW1lIjoiQWRlIFJpemFsZGkiLCJlbWFpbCI6ImFkZUBnbWFpbC5jb20iLCJpYXQiOjE2NDY3OTAyMTksImV4cCI6MTY0Njg3NjYxOX0.JX_68UdpBJji0imUpXK3iLqEqyUXcNya-mSuAg9FShg",
      };
      expect(result, expectedJsonMap);
    });
  });

  test('should be a subclass of UserResponseModel entity', () async {
    final result = tUserResponseModel.toEntity();
    expect(result, tUserResponse);
  });
}
