import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../repositories/repository.dart';

class GetEmail {
  final Repository repository;

  GetEmail(this.repository);

  Future<Either<Failure, String?>> execute() {
    return repository.getEmail();
  }
}
