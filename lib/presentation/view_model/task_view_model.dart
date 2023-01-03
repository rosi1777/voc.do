import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_dafault/common/state_enum.dart';
import 'package:todo_dafault/domain/entities/task_response.dart';
import 'package:todo_dafault/domain/usecases/add_task.dart';
import 'package:todo_dafault/domain/usecases/delete_task.dart';
import 'package:todo_dafault/domain/usecases/get_all_task.dart';
import 'package:todo_dafault/domain/usecases/get_done_task.dart';
import 'package:todo_dafault/domain/usecases/get_overdue_task.dart';
import 'package:todo_dafault/domain/usecases/get_today_task.dart';
import 'package:todo_dafault/domain/usecases/get_todo_task.dart';
import 'package:todo_dafault/domain/usecases/mark_as_done_task.dart';
import 'package:todo_dafault/domain/usecases/update_task.dart';

import '../../common/failure.dart';

class TaskViewModel extends ChangeNotifier {
  final AddTask addTask;
  final DeleteTask deleteTask;
  final GetAllTask getAllTask;
  final GetDoneTask getDoneTask;
  final GetOverdueTask getOverdueTask;
  final GetTodayTask getTodayTask;
  final GetTodoTask getTodoTask;
  final UpdateTask updateTask;
  final MarkAsDoneTask markAsDoneTask;

  TaskViewModel({
    required this.addTask,
    required this.deleteTask,
    required this.getAllTask,
    required this.getDoneTask,
    required this.getOverdueTask,
    required this.getTodayTask,
    required this.getTodoTask,
    required this.updateTask,
    required this.markAsDoneTask,
  });

  late TaskResponse _taskResponse;
  TaskResponse get task => _taskResponse;

  RequestState _taskState = RequestState.empty;
  RequestState get taskState => _taskState;

  String _message = '';
  String get message => _message;

  Future<void> getTask(String token, String route) async {
    _taskState = RequestState.loading;
    notifyListeners();

    late Either<Failure, TaskResponse> result;

    if (route == 'todo') {
      result = await getTodoTask.execute(token);
    } else if (route == 'overdue') {
      result = await getOverdueTask.execute(token);
    } else if (route == 'all') {
      result = await getAllTask.execute(token);
    } else if (route == 'done') {
      result = await getDoneTask.execute(token);
    } else if (route == 'today') {
      result = await getTodayTask.execute(token);
    }

    await result.fold(
      (failure) async {
        _message = failure.message;
        _taskState = RequestState.error;
        notifyListeners();
      },
      (task) async {
        _taskState = RequestState.loaded;
        _taskResponse = task;
        notifyListeners();
      },
    );
  }

  Future<void> addTasks(
    String token,
    String tittle,
    String description,
    String time,
  ) async {
    final result = await addTask.execute(token, tittle, description, time);

    await result.fold(
      (failure) async {
        _message = failure.message;
        _taskState = RequestState.error;
      },
      (successMessage) async {
        _message = successMessage.toString();
        _taskState = RequestState.done;
      },
    );
  }

  // ignore: long-parameter-list
  Future<void> updateTasks(
    String token,
    String id,
    String tittle,
    String description,
    String time,
  ) async {
    final result =
        await updateTask.execute(token, id, tittle, description, time);

    await result.fold(
      (failure) async {
        _message = failure.message;
        _taskState = RequestState.error;
      },
      (successMessage) async {
        _message = successMessage.toString();
        _taskState = RequestState.done;
      },
    );
  }

  Future<void> deleteTasks(
    String token,
    String id,
  ) async {
    final result = await deleteTask.execute(token, id);

    await result.fold(
      (failure) async {
        _message = failure.message;
        _taskState = RequestState.error;
      },
      (successMessage) async {
        _message = successMessage.toString();
        _taskState = RequestState.done;
      },
    );
  }

  Future<void> markAsDoneTasks(
    String token,
    String id,
  ) async {
    final result = await markAsDoneTask.execute(token, id);

    await result.fold(
      (failure) async {
        _message = failure.message;
        _taskState = RequestState.error;
      },
      (successMessage) async {
        _message = successMessage.toString();
        _taskState = RequestState.done;
      },
    );
  }
}
