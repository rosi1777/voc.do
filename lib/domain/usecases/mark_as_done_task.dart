import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../repositories/repository.dart';

class MarkAsDoneTask {
  final Repository repository;

  MarkAsDoneTask(this.repository);

  Future<Either<Failure, dynamic>> execute(
    String token,
    String id,
  ) {
    return repository.markAsDoneTask(token, id);
  }
}
