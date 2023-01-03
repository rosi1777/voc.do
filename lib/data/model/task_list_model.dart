import 'package:equatable/equatable.dart';
import 'package:todo_dafault/data/model/task_model.dart';
import 'package:todo_dafault/domain/entities/task_list.dart';

class TaskListModel extends Equatable {
  const TaskListModel({
    required this.taskList,
  });

  final List<TaskModel> taskList;

  factory TaskListModel.fromJson(Map<String, dynamic> json) => TaskListModel(
        taskList: List<TaskModel>.from(
          json["list"].map(
            (x) => TaskModel.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(taskList.map((x) => x.toJson())),
      };

  TaskList toEntity() {
    return TaskList(
      taskList: taskList.map((task) => task.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [
        taskList,
      ];
}
