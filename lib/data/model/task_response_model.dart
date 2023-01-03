import 'package:equatable/equatable.dart';
import 'package:todo_dafault/data/model/task_list_model.dart';
import 'package:todo_dafault/domain/entities/task_response.dart';

class TaskResponseModel extends Equatable {
  const TaskResponseModel({
    required this.status,
    required this.error,
    required this.messages,
  });

  final int? status;
  final dynamic error;
  final TaskListModel messages;

  factory TaskResponseModel.fromJson(Map<String, dynamic> json) =>
      TaskResponseModel(
        status: json["status"],
        error: json["error"],
        messages: TaskListModel.fromJson(json["messages"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "error": error,
        "messages": messages.toJson(),
      };

  TaskResponse toEntity() {
    return TaskResponse(
      status: status,
      error: error,
      messages: messages.toEntity(),
    );
  }

  @override
  List<Object?> get props => [
        status,
        error,
        messages,
      ];
}
