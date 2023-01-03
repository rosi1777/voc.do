import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../repositories/repository.dart';

class GetName {
  final Repository repository;

  GetName(this.repository);

  Future<Either<Failure, String?>> execute() {
    return repository.getName();
  }
}
