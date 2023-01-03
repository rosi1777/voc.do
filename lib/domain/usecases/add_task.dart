import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../repositories/repository.dart';

class AddTask {
  final Repository repository;

  AddTask(this.repository);

  Future<Either<Failure, dynamic>> execute(
    String token,
    String tittle,
    String description,
    String time,
  ) {
    return repository.addTask(token, tittle, description, time);
  }
}
