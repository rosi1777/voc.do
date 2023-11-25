import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_dafault/domain/usecases/get_name.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetName usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = GetName(mockRepository);
  });

  const response = "Name";

  test('should call getName from the repository', () async {
    // arrange
    when(mockRepository.getName())
        .thenAnswer((_) async => const Right(response));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, const Right(response));
  });
}
