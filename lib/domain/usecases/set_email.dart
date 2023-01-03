import '../repositories/repository.dart';

class SetEmail {
  final Repository repository;

  SetEmail(this.repository);

  void execute(String value) {
    return repository.setEmail(value);
  }
}
