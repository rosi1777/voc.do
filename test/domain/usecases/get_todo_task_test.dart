import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_dafault/domain/entities/task_list.dart';
import 'package:todo_dafault/domain/entities/task.dart' as tk;
import 'package:todo_dafault/domain/entities/task_response.dart';
import 'package:todo_dafault/domain/usecases/get_todo_task.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTodoTask usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = GetTodoTask(mockRepository);
  });

  const tTask = tk.Task(
    id: "10",
    userId: "4",
    tittle: "Test menampilkan data todo",
    description: "Mencoba mengubah data to-do",
    time: "2022-03-09 07:00:00",
    status: "1",
  );

  const tTaskList = TaskList(taskList: <tk.Task>[tTask]);

  const tTaskResponse =
      TaskResponse(status: 200, error: null, messages: tTaskList);

  test('should get list of todo task from the repository', () async {
    // arrange
    when(mockRepository.getTodoTask('token'))
        .thenAnswer((_) async => const Right(tTaskResponse));
    // act
    final result = await usecase.execute('token');
    // assert
    expect(result, const Right(tTaskResponse));
  });
}
