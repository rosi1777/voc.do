import '../repositories/repository.dart';

class Logout {
  final Repository repository;

  Logout(this.repository);

  Future execute() {
    return repository.logout();
  }
}
