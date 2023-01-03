import 'package:equatable/equatable.dart';
import 'package:todo_dafault/data/model/user_message_model.dart';
import 'package:todo_dafault/data/model/user_model.dart';
import 'package:todo_dafault/domain/entities/user_response.dart';

class UserResponseModel extends Equatable {
  const UserResponseModel({
    required this.status,
    required this.error,
    required this.messages,
    required this.data,
    required this.token,
  });

  final int status;
  final dynamic error;
  final UserMessagesModel messages;
  final UserModel data;
  final String token;

  factory UserResponseModel.fromJson(Map<String, dynamic> json) =>
      UserResponseModel(
        status: json["status"],
        error: json["error"],
        messages: UserMessagesModel.fromJson(json["messages"]),
        data: UserModel.fromJson(json["data"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "error": error,
        "messages": messages.toJson(),
        "data": data.toJson(),
        "token": token,
      };

  UserResponse toEntity() {
    return UserResponse(
      status: status,
      error: error,
      messages: messages.toEntity(),
      data: data.toEntity(),
      token: token,
    );
  }

  @override
  List<Object?> get props => [
        status,
        error,
        messages,
        data,
        token,
      ];
}
