import 'package:equatable/equatable.dart';

class UserMessages extends Equatable {
  const UserMessages({
    required this.success,
  });

  final String success;

  @override
  List<Object?> get props => [
        success,
      ];
}
