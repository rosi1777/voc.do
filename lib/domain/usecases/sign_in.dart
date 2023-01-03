import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../repositories/repository.dart';

class SignIn {
  final Repository repository;

  SignIn(this.repository);

  Future<Either<Failure, dynamic>> execute(
    String email,
    String password,
  ) {
    return repository.signIn(email, password);
  }
}
