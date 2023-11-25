import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_dafault/common/failure.dart';
import 'package:todo_dafault/common/state_enum.dart';
import 'package:todo_dafault/domain/entities/user.dart';
import 'package:todo_dafault/domain/entities/user_messages.dart';
import 'package:todo_dafault/domain/entities/user_response.dart';
import 'package:todo_dafault/domain/usecases/sign_in.dart';
import 'package:todo_dafault/domain/usecases/sign_up.dart';
import 'package:todo_dafault/presentation/view_model/auth_view_model.dart';

import 'auth_view_model_test.mocks.dart';

@GenerateMocks([
  SignUp,
  SignIn,
])
void main() {
  late AuthViewModel provider;
  late MockSignUp mockSignUp;
  late MockSignIn mockSignIn;

  setUp(() {
    mockSignUp = MockSignUp();
    mockSignIn = MockSignIn();
    provider = AuthViewModel(signUp: mockSignUp, signIn: mockSignIn);
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

  group('User Sign Up', () {
    test('should sign up from the usecase', () async {
      // arrange
      when(mockSignUp.execute(
        "John Doe",
        "johndoe@example.com",
        "password123",
        "password123",
      )).thenAnswer((_) async => const Right('signUpResponse'));
      // act
      await provider.userSignUp(
        "John Doe",
        "johndoe@example.com",
        "password123",
        "password123",
      );
      // assert
      verify(mockSignUp.execute(
        "John Doe",
        "johndoe@example.com",
        "password123",
        "password123",
      ));
    });

    test('should change state to Done when sign up process done', () {
      // arrange
      when(mockSignUp.execute(
        "John Doe",
        "johndoe@example.com",
        "password123",
        "password123",
      )).thenAnswer((_) async => const Right('signUpResponse'));
      // act
      provider.userSignUp(
        "John Doe",
        "johndoe@example.com",
        "password123",
        "password123",
      );
      // assert
      expect(provider.authState, RequestState.empty);
    });

    test('should set authState to error when the sign up process fails', () async {
      // arrange
      when(mockSignUp.execute(
        "John Doe",
        "johndoe@example.com",
        "password123",
        "password123",
      )).thenAnswer((_) async => const Left(ServerFailure('message')));
      // act
      provider.userSignUp(
        "John Doe",
        "johndoe@example.com",
        "password123",
        "password123",
      );
      // assert
      expect(provider.authState, RequestState.empty);
    });
  });


  group('User Sign in', () {
    test('should sign in from the usecase', () async {
      // arrange
      when(mockSignIn.execute(
        "johndoe@example.com",
        "password123",
      )).thenAnswer((_) async => const Right(tUserResponse));
      // act
      await provider.userSignIn(
        "johndoe@example.com",
        "password123",
      );
      // assert
      verify(mockSignIn.execute(
        "johndoe@example.com",
        "password123",
      ));
    });

    test('should change state to Done when sign in process done', () {
      // arrange
      when(mockSignIn.execute(
        "johndoe@example.com",
        "password123",
      )).thenAnswer((_) async => const Right(tUserResponse));
      // act
      provider.userSignIn(
        "johndoe@example.com",
        "password123",
      );
      // assert
      expect(provider.authState, RequestState.empty);
    });

    test('should set authState to error when the sign in process fails', () async {
      // arrange
      when(mockSignIn.execute(
        "johndoe@example.com",
        "password123",
      )).thenAnswer((_) async => const Left(ServerFailure('message')));
      // act
      provider.userSignIn(
        "johndoe@example.com",
        "password123",
      );
      // assert
      expect(provider.authState, RequestState.empty);
    });
  });
}
