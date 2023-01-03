import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../repositories/repository.dart';

class DeleteTask {
  final Repository repository;

  DeleteTask(this.repository);

  Future<Either<Failure, dynamic>> execute(
    String token,
    String id,
  ) {
    return repository.deleteTask(token, id);
  }
}
