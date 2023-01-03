import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../repositories/repository.dart';

class SignUp {
  final Repository repository;

  SignUp(this.repository);

  Future<Either<Failure, dynamic>> execute(
    String name,
    String email,
    String password,
    String confirmPassword,
  ) {
    return repository.signUp(name, email, password, confirmPassword);
  }
}
