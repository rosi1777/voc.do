import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_dafault/domain/usecases/delete_task.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late DeleteTask usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = DeleteTask(mockRepository);
  });

  const deleteResponse = {
    "status": 200,
    "error": null,
    "messages": {
      "success": "Successfully deleted to-do with id = 8",
    },
  };

  test('should delete task from the repository', () async {
    // arrange
    when(mockRepository.deleteTask("token", "1"))
        .thenAnswer((_) async => const Right(deleteResponse));
    // act
    final result = await usecase.execute("token", "1");
    // assert
    expect(result, const Right(deleteResponse));
  });
}
