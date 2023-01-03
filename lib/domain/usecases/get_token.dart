import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../repositories/repository.dart';

class GetToken {
  final Repository repository;

  GetToken(this.repository);

  Future<Either<Failure, String?>> execute() {
    return repository.getToken();
  }
}
