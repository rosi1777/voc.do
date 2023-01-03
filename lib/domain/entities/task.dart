import 'package:equatable/equatable.dart';

class Task extends Equatable {
  const Task({
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
