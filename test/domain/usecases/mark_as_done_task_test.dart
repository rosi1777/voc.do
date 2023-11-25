import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_dafault/domain/usecases/mark_as_done_task.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MarkAsDoneTask usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = MarkAsDoneTask(mockRepository);
  });

  const markAsDoneResponse = {
    "status": 200,
    "error": null,
    "messages": {
      "success": "Successfully mark as done to-do with id = 8",
    },
  };

  test('should mark as done task from the repository', () async {
    // arrange
    when(mockRepository.markAsDoneTask("token", "1"))
        .thenAnswer((_) async => const Right(markAsDoneResponse));
    // act
    final result = await usecase.execute("token", "1");
    // assert
    expect(result, const Right(markAsDoneResponse));
  });
}
