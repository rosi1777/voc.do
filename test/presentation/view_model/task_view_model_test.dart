import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_dafault/domain/entities/task_list.dart';
import 'package:todo_dafault/domain/entities/task.dart' as tk;
import 'package:todo_dafault/domain/entities/task_response.dart';
import 'package:todo_dafault/common/failure.dart';
import 'package:todo_dafault/common/state_enum.dart';
import 'package:todo_dafault/domain/usecases/add_task.dart';
import 'package:todo_dafault/domain/usecases/delete_task.dart';
import 'package:todo_dafault/domain/usecases/get_all_task.dart';
import 'package:todo_dafault/domain/usecases/get_done_task.dart';
import 'package:todo_dafault/domain/usecases/get_overdue_task.dart';
import 'package:todo_dafault/domain/usecases/get_today_task.dart';
import 'package:todo_dafault/domain/usecases/get_todo_task.dart';
import 'package:todo_dafault/domain/usecases/mark_as_done_task.dart';
import 'package:todo_dafault/domain/usecases/update_task.dart';
import 'package:todo_dafault/presentation/view_model/task_view_model.dart';

import 'task_view_model_test.mocks.dart';

@GenerateMocks([
  AddTask,
  UpdateTask,
  DeleteTask,
  MarkAsDoneTask,
  GetAllTask,
  GetTodayTask,
  GetTodoTask,
  GetOverdueTask,
  GetDoneTask,
])
void main() {
  late TaskViewModel provider;
  late MockAddTask mockAddTask;
  late MockUpdateTask mockUpdateTask;
  late MockDeleteTask mockDeleteTask;
  late MockMarkAsDoneTask mockMarkAsDoneTask;
  late MockGetAllTask mockGetAllTask;
  late MockGetDoneTask mockGetDoneTask;
  late MockGetOverdueTask mockGetOverdueTask;
  late MockGetTodayTask mockGetTodayTask;
  late MockGetTodoTask mockGetTodoTask;

  setUp(() {
    mockGetDoneTask = MockGetDoneTask();
    mockGetOverdueTask = MockGetOverdueTask();
    mockGetTodayTask = MockGetTodayTask();
    mockGetTodoTask = MockGetTodoTask();
    mockAddTask = MockAddTask();
    mockDeleteTask = MockDeleteTask();
    mockGetAllTask = MockGetAllTask();
    mockMarkAsDoneTask = MockMarkAsDoneTask();
    mockUpdateTask = MockUpdateTask();
    provider = TaskViewModel(
      addTask: mockAddTask,
      deleteTask: mockDeleteTask,
      getAllTask: mockGetAllTask,
      getDoneTask: mockGetDoneTask,
      getOverdueTask: mockGetOverdueTask,
      getTodayTask: mockGetTodayTask,
      getTodoTask: mockGetTodoTask,
      updateTask: mockUpdateTask,
      markAsDoneTask: mockMarkAsDoneTask,
    );
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

  group('Get Task', () {
    test('should call getTodoTask', () async {
      // arrange
      when(mockGetTodoTask.execute('token'))
          .thenAnswer((_) async => const Right(tTaskResponse));
      // act
      await provider.getTask('token', 'todo');
      // assert
      verify(mockGetTodoTask.execute('token')).called(1);
    });

    test('should call getTodayTask', () async {
      // arrange
      when(mockGetTodayTask.execute('token'))
          .thenAnswer((_) async => const Right(tTaskResponse));
      // act
      await provider.getTask('token', 'today');
      // assert
      verify(mockGetTodayTask.execute('token')).called(1);
    });

    test('should call getAllTask', () async {
      // arrange
      when(mockGetAllTask.execute('token'))
          .thenAnswer((_) async => const Right(tTaskResponse));
      // act
      await provider.getTask('token', 'all');
      // assert
      verify(mockGetAllTask.execute('token')).called(1);
    });

    test('should call getOverdueTask', () async {
      // arrange
      when(mockGetOverdueTask.execute('token'))
          .thenAnswer((_) async => const Right(tTaskResponse));
      // act
      await provider.getTask('token', 'overdue');
      // assert
      verify(mockGetOverdueTask.execute('token')).called(1);
    });

    test('should call getDoneTask', () async {
      // arrange
      when(mockGetDoneTask.execute('token'))
          .thenAnswer((_) async => const Right(tTaskResponse));
      // act
      await provider.getTask('token', 'done');
      // assert
      verify(mockGetDoneTask.execute('token')).called(1);
    });

    test('success', () async {
      when(mockGetDoneTask.execute('token'))
          .thenAnswer((_) async => const Right(tTaskResponse));

      await provider.getTask('token', 'done');

      verify(mockGetDoneTask.execute('token')).called(1);
      expect(provider.taskState, RequestState.loaded);
      expect(provider.message, '');
    });

    test('failure', () async {
      when(mockGetDoneTask.execute('token')).thenAnswer(
        (_) async => const Left(ServerFailure('something went wrong')),
      );

      await provider.getTask('token', 'done');

      verify(mockGetDoneTask.execute('token')).called(1);
      expect(provider.taskState, RequestState.error);
      expect(provider.message, 'something went wrong');
    });
  });

  group('Update Task', () {
    test('should change state to Done when update task process done', () {
      // arrange
      when(mockUpdateTask.execute(
        "token",
        "1",
        "tittle",
        "description",
        "2022-03-09 19:00:00",
      )).thenAnswer((_) async => const Right('updateResponse'));
      // act
      provider.updateTasks(
        "token",
        "1",
        "tittle",
        "description",
        "2022-03-09 19:00:00",
      );
      // assert
      expect(provider.taskState, RequestState.empty);
    });

    test(
      'should set taskState to error when the update task process fails',
      () async {
        // arrange
        when(mockUpdateTask.execute(
          "token",
          "1",
          "tittle",
          "description",
          "2022-03-09 19:00:00",
        )).thenAnswer((_) async => const Left(ServerFailure('message')));
        // act
        provider.updateTasks(
          "token",
          "1",
          "tittle",
          "description",
          "2022-03-09 19:00:00",
        );
        // assert
        expect(provider.taskState, RequestState.empty);
      },
    );
  });

  group('Add Task', () {
    test('should change state to Done when add task process done', () {
      // arrange
      when(mockAddTask.execute(
        "token",
        "tittle",
        "description",
        "2022-03-09 19:00:00",
      )).thenAnswer((_) async => const Right('addResponse'));
      // act
      provider.addTasks(
        "token",
        "tittle",
        "description",
        "2022-03-09 19:00:00",
      );
      // assert
      expect(provider.taskState, RequestState.empty);
    });

    test(
      'should set taskState to error when the add task process fails',
      () async {
        // arrange
        when(mockAddTask.execute(
          "token",
          "tittle",
          "description",
          "2022-03-09 19:00:00",
        )).thenAnswer((_) async => const Left(ServerFailure('message')));
        // act
        provider.addTasks(
          "token",
          "tittle",
          "description",
          "2022-03-09 19:00:00",
        );
        // assert
        expect(provider.taskState, RequestState.empty);
      },
    );
  });

  group('Delete Task', () {
    test('should change state to Done when delete task process done', () {
      // arrange
      when(mockDeleteTask.execute(
        "token",
        "1",
      )).thenAnswer((_) async => const Right('deleteResponse'));
      // act
      provider.deleteTasks(
        "token",
        "1",
      );
      // assert
      expect(provider.taskState, RequestState.empty);
    });

    test(
      'should set taskState to error when the delete task process fails',
      () async {
        // arrange
        when(mockDeleteTask.execute(
          "token",
          "1",
        )).thenAnswer((_) async => const Left(ServerFailure('message')));
        // act
        provider.deleteTasks(
          "token",
          "1",
        );
        // assert
        expect(provider.taskState, RequestState.empty);
      },
    );
  });

  group('Mark As Done Task', () {
    test('should change state to Done when mark as done task process done', () {
      // arrange
      when(mockMarkAsDoneTask.execute(
        "token",
        "1",
      )).thenAnswer((_) async => const Right('markAsDoneResponse'));
      // act
      provider.markAsDoneTasks(
        "token",
        "1",
      );
      // assert
      expect(provider.taskState, RequestState.empty);
    });

    test(
      'should set taskState to error when the markAsDone task process fails',
      () async {
        // arrange
        when(mockMarkAsDoneTask.execute(
          "token",
          "1",
        )).thenAnswer((_) async => const Left(ServerFailure('message')));
        // act
        provider.markAsDoneTasks(
          "token",
          "1",
        );
        // assert
        expect(provider.taskState, RequestState.empty);
      },
    );
  });
}
