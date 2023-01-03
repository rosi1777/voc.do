import 'package:flutter/cupertino.dart';
import 'package:todo_dafault/common/state_enum.dart';
import 'package:todo_dafault/domain/entities/counter_response.dart';
import 'package:todo_dafault/domain/usecases/get_counter_task.dart';

class CounterViewModel extends ChangeNotifier {
  final GetCounterTask getCounterTask;

  CounterViewModel({
    required this.getCounterTask,
  });

  late CounterResponse _counterResponse;
  CounterResponse get counter => _counterResponse;

  RequestState _counterState = RequestState.empty;
  RequestState get counterState => _counterState;

  String _message = '';
  String get message => _message;

  Future<void> getCounter(String token) async {
    _counterState = RequestState.loading;
    notifyListeners();

    final result = await getCounterTask.execute(token);

    await result.fold(
      (failure) async {
        _message = failure.message;
        _counterState = RequestState.error;
        notifyListeners();
      },
      (counter) async {
        _counterState = RequestState.loaded;
        _counterResponse = counter;
        notifyListeners();
      },
    );
  }
}
