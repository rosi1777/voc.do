import 'package:equatable/equatable.dart';
import 'package:todo_dafault/domain/entities/counter.dart';

class CounterModel extends Equatable {
  const CounterModel({
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

  factory CounterModel.fromJson(Map<String, dynamic> json) => CounterModel(
        todo: json["todo"],
        today: json["today"],
        overdue: json["overdue"],
        done: json["done"],
        all: json["all"],
      );

  Map<String, dynamic> toJson() => {
        "todo": todo,
        "today": today,
        "overdue": overdue,
        "done": done,
        "all": all,
      };

  Counter toEntity() {
    return Counter(
      todo: todo,
      today: today,
      overdue: overdue,
      done: done,
      all: all,
    );
  }

  @override
  List<Object?> get props => [
        todo,
        today,
        overdue,
        done,
        all,
      ];
}
