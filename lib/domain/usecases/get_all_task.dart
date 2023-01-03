import 'package:dartz/dartz.dart';
import 'package:todo_dafault/domain/entities/task_response.dart';

import '../../common/failure.dart';
import '../repositories/repository.dart';

class GetAllTask {
  final Repository repository;

  GetAllTask(this.repository);

  Future<Either<Failure, TaskResponse>> execute(
    String token,
  ) {
    return repository.getAllTask(token);
  }
}
