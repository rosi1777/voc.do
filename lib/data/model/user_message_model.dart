import 'package:equatable/equatable.dart';
import 'package:todo_dafault/domain/entities/user_messages.dart';

class UserMessagesModel extends Equatable {
  const UserMessagesModel({
    required this.success,
  });

  final String success;

  factory UserMessagesModel.fromJson(Map<String, dynamic> json) =>
      UserMessagesModel(
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
      };

  UserMessages toEntity() {
    return UserMessages(
      success: success,
    );
  }

  @override
  List<Object?> get props => [
        success,
      ];
}
