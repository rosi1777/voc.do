import 'package:equatable/equatable.dart';
import 'package:todo_dafault/domain/entities/task_list.dart';

class TaskResponse extends Equatable {
  const TaskResponse({
    required this.status,
    required this.error,
    required this.messages,
  });

  final int? status;
  final dynamic error;
  final TaskList messages;

  @override
  List<Object?> get props => [
        status,
        error,
        messages,
      ];
}
