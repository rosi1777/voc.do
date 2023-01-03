import 'package:dartz/dartz.dart';
import 'package:todo_dafault/domain/entities/task_response.dart';

import '../../common/failure.dart';
import '../repositories/repository.dart';

class GetDoneTask {
  final Repository repository;

  GetDoneTask(this.repository);

  Future<Either<Failure, TaskResponse>> execute(
    String token,
  ) {
    return repository.getDoneTask(token);
  }
}
