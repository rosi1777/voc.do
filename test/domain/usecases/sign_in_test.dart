import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_dafault/domain/entities/user.dart';
import 'package:todo_dafault/domain/entities/user_messages.dart';
import 'package:todo_dafault/domain/entities/user_response.dart';
import 'package:todo_dafault/domain/usecases/sign_in.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SignIn usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = SignIn(mockRepository);
  });

  const tUser = User(id: "4", name: "Ade Rizaldi", email: "ade@gmail.com");

  const tUserMessages = UserMessages(success: "Successfully authentication");

  const tUserResponse = UserResponse(
    status: 201,
    error: null,
    messages: tUserMessages,
    data: tUser,
    token:
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQiLCJuYW1lIjoiQWRlIFJpemFsZGkiLCJlbWFpbCI6ImFkZUBnbWFpbC5jb20iLCJpYXQiOjE2NDY3OTAyMTksImV4cCI6MTY0Njg3NjYxOX0.JX_68UdpBJji0imUpXK3iLqEqyUXcNya-mSuAg9FShg",
  );

  test('should sign in from the repository', () async {
    // arrange
    when(mockRepository.signIn(
          "johndoe@example.com",
          "password123",
        ))
        .thenAnswer((_) async => const Right(tUserResponse));
    // act
    final result = await usecase.execute(
          "johndoe@example.com",
          "password123",
        );
    // assert
    expect(result, const Right(tUserResponse));
  });
}
