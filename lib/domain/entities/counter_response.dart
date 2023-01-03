import 'package:equatable/equatable.dart';
import 'package:todo_dafault/domain/entities/counter.dart';

class CounterResponse extends Equatable {
  const CounterResponse({
    required this.status,
    required this.error,
    required this.messages,
  });

  final int? status;
  final dynamic error;
  final Counter messages;

  @override
  List<Object?> get props => [
        status,
        error,
        messages,
      ];
}
