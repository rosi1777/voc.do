import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../repositories/repository.dart';

class UpdateTask {
  final Repository repository;

  UpdateTask(this.repository);

  // ignore: long-parameter-list
  Future<Either<Failure, dynamic>> execute(
    String token,
    String id,
    String tittle,
    String description,
    String time,
  ) {
    return repository.updateTask(token, id, tittle, description, time);
  }
}
