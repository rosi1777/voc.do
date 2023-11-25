import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_dafault/domain/usecases/get_email.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetEmail usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = GetEmail(mockRepository);
  });

  const response = "Email";

  test('should call getEmail from the repository', () async {
    // arrange
    when(mockRepository.getEmail())
        .thenAnswer((_) async => const Right(response));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, const Right(response));
  });
}
