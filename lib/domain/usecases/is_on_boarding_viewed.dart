import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../repositories/repository.dart';

class IsOnBoardingViewed {
  final Repository repository;

  IsOnBoardingViewed(this.repository);

  Future<Either<Failure, bool>> execute() {
    return repository.isOnBoardingViewed();
  }
}
