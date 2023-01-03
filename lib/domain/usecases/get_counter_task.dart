import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/counter_response.dart';
import '../repositories/repository.dart';

class GetCounterTask {
  final Repository repository;

  GetCounterTask(this.repository);

  Future<Either<Failure, CounterResponse>> execute(
    String token,
  ) {
    return repository.getCounterTask(token);
  }
}
