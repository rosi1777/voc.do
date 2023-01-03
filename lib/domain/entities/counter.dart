import 'package:equatable/equatable.dart';

class Counter extends Equatable {
  const Counter({
    required this.todo,
    required this.today,
    required this.overdue,
    required this.done,
    required this.all,
  });

  final int? todo;
  final int? today;
  final int? overdue;
  final int? done;
  final int? all;

  @override
  List<Object?> get props => [
        todo,
        today,
        overdue,
        done,
        all,
      ];
}
