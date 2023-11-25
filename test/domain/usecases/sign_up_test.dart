import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_dafault/domain/usecases/sign_up.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SignUp usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = SignUp(mockRepository);
  });

  const signUpResponse = {
    "status": 201,
    "error": null,
    "messages": {"success": "Successfully created an account"},
  };

  test('should sign up from the repository', () async {
    // arrange
    when(mockRepository.signUp(
          "John Doe",
          "johndoe@example.com",
          "password123",
          "password123",
        ))
        .thenAnswer((_) async => const Right(signUpResponse));
    // act
    final result = await usecase.execute(
          "John Doe",
          "johndoe@example.com",
          "password123",
          "password123",
        );
    // assert
    expect(result, const Right(signUpResponse));
  });
}
