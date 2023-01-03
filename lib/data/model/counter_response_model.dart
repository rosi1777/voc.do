import 'package:equatable/equatable.dart';
import 'package:todo_dafault/data/model/counter_model.dart';
import 'package:todo_dafault/domain/entities/counter_response.dart';

class CounterResponseModel extends Equatable {
  const CounterResponseModel({
    required this.status,
    required this.error,
    required this.messages,
  });

  final int? status;
  final dynamic error;
  final CounterModel messages;

  factory CounterResponseModel.fromJson(Map<String, dynamic> json) =>
      CounterResponseModel(
        status: json["status"],
        error: json["error"],
        messages: CounterModel.fromJson(json["messages"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "error": error,
        "messages": messages.toJson(),
      };

  CounterResponse toEntity() {
    return CounterResponse(
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
