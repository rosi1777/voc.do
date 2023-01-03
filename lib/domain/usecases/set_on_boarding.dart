import 'package:todo_dafault/domain/repositories/repository.dart';

class SetOnBoarding {
  final Repository repository;

  SetOnBoarding(this.repository);

  void execute(bool value) {
    return repository.setOnBoarding(value);
  }
}
