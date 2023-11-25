import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_dafault/domain/usecases/add_task.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late AddTask usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = AddTask(mockRepository);
  });

  const addResponse = {
    "status": 201,
    "error": null,
    "messages": {
      "success": "Successfully created new to-do",
    },
  };

  test('should add task from the repository', () async {
    // arrange
    when(mockRepository.addTask(
      "token",
      "tittle",
      "description",
      "2022-03-09 19:00:00",
    )).thenAnswer((_) async => const Right(addResponse));
    // act
    final result = await usecase.execute(
      "token",
      "tittle",
      "description",
      "2022-03-09 19:00:00",
    );
    // assert
    expect(result, const Right(addResponse));
  });
}
