import 'package:equatable/equatable.dart';
import 'package:todo_dafault/domain/entities/task.dart';

class TaskModel extends Equatable {
  const TaskModel({
    required this.id,
    required this.userId,
    required this.tittle,
    required this.description,
    required this.time,
    required this.status,
  });

  final String? id;
  final String? userId;
  final String? tittle;
  final String? description;
  final String? time;
  final String? status;

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["id"],
        userId: json["user_id"],
        tittle: json["tittle"],
        description: json["description"],
        time: json["time"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "tittle": tittle,
        "description": description,
        "time": time,
        "status": status,
      };

  Task toEntity() {
    return Task(
      id: id,
      userId: userId,
      tittle: tittle,
      description: description,
      time: time,
      status: status,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        tittle,
        description,
        time,
        status,
      ];
}
