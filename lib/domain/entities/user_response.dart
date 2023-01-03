import 'package:equatable/equatable.dart';
import 'package:todo_dafault/domain/entities/user.dart';

import 'user_messages.dart';

class UserResponse extends Equatable {
  const UserResponse({
    required this.status,
    required this.error,
    required this.messages,
    required this.data,
    required this.token,
  });

  final int status;
  final dynamic error;
  final UserMessages messages;
  final User data;
  final String token;

  @override
  List<Object?> get props => [
        status,
        error,
        messages,
        data,
        token,
      ];
}
