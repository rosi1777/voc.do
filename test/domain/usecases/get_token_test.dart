import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_dafault/domain/usecases/get_token.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetToken usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = GetToken(mockRepository);
  });

  const response = "Token";

  test('should call getToken from the repository', () async {
    // arrange
    when(mockRepository.getToken())
        .thenAnswer((_) async => const Right(response));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, const Right(response));
  });
}
