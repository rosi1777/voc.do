import '../repositories/repository.dart';

class SetToken {
  final Repository repository;

  SetToken(this.repository);

  void execute(String value) {
    return repository.setToken(value);
  }
}
