import 'package:equatable/equatable.dart';
import 'package:todo_dafault/domain/entities/task.dart';

class TaskList extends Equatable {
  const TaskList({
    required this.taskList,
  });

  final List<Task> taskList;

  @override
  List<Object> get props => [taskList];
}
