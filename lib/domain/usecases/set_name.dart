import '../repositories/repository.dart';

class SetName {
  final Repository repository;

  SetName(this.repository);

  void execute(String value) {
    return repository.setName(value);
  }
}
