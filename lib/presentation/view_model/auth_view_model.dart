import 'package:flutter/cupertino.dart';
import 'package:todo_dafault/common/state_enum.dart';
import 'package:todo_dafault/domain/entities/user_response.dart';
import 'package:todo_dafault/domain/usecases/sign_in.dart';
import 'package:todo_dafault/domain/usecases/sign_up.dart';

class AuthViewModel extends ChangeNotifier {
  final SignUp signUp;
  final SignIn signIn;

  AuthViewModel({
    required this.signUp,
    required this.signIn,
  });

  late UserResponse _userResponse;
  UserResponse get user => _userResponse;

  RequestState _authState = RequestState.empty;
  RequestState get authState => _authState;

  String _message = '';
  String get message => _message;

  Future<bool> userSignUp(
    String name,
    String email,
    String password,
    String confirmPassword,
  ) async {
    final result = await signUp.execute(name, email, password, confirmPassword);
    late bool res;

    await result.fold(
      (failure) async {
        _message = failure.message;
        _authState = RequestState.error;
        res = false;
      },
      (successMessage) async {
        _message = '';
        _authState = RequestState.done;
        res = true;
      },
    );

    return res;
  }

  Future<bool> userSignIn(String email, String password) async {
    final result = await signIn.execute(email, password);

    late bool res;

    await result.fold(
      (failure) async {
        _message = failure.message;
        _authState = RequestState.error;
        notifyListeners();

        res = false;
      },
      (user) async {
        _authState = RequestState.done;
        _userResponse = user;
        notifyListeners();

        res = true;
      },
    );

    return res;
  }
}
