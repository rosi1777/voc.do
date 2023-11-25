import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_dafault/domain/usecases/is_on_boarding_viewed.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late IsOnBoardingViewed usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = IsOnBoardingViewed(mockRepository);
  });

  const response = true;

  test('should call isOnBoardingViewed from the repository', () async {
    // arrange
    when(mockRepository.isOnBoardingViewed())
        .thenAnswer((_) async => const Right(response));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, const Right(response));
  });
}
