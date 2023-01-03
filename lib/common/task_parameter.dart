import 'package:equatable/equatable.dart';

class TaskParameter extends Equatable {
  const TaskParameter({
    required this.token,
    required this.id,
    required this.tittle,
    required this.description,
    required this.time,
  });

  final String token;
  final String id;
  final String tittle;
  final String description;
  final String time;

  @override
  List<Object> get props => [token, id, tittle, description, time];
}
