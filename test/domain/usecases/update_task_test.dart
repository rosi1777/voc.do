import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_dafault/domain/usecases/update_task.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late UpdateTask usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = UpdateTask(mockRepository);
  });

  const updateResponse = {
    "status": 201,
    "error": null,
    "messages": {
      "success": "Successfully updated to-do with id = 10",
    },
  };

  test('should update task from the repository', () async {
    // arrange
    when(mockRepository.updateTask(
          "token",
          "1",
          "tittle",
          "description",
          "2022-03-09 19:00:00",
        ))
        .thenAnswer((_) async => const Right(updateResponse));
    // act
    final result = await usecase.execute(
          "token",
          "1",
          "tittle",
          "description",
          "2022-03-09 19:00:00",
        );
    // assert
    expect(result, const Right(updateResponse));
  });
}
