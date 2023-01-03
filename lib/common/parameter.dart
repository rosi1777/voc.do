import 'package:equatable/equatable.dart';

class Parameter extends Equatable {
  const Parameter({
    required this.token,
    required this.route,
  });

  final String token;
  final String route;

  @override
  List<Object> get props => [token, route];
}
