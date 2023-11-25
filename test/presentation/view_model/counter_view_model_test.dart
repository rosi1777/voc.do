import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_dafault/common/failure.dart';
import 'package:todo_dafault/common/state_enum.dart';
import 'package:todo_dafault/domain/entities/counter.dart';
import 'package:todo_dafault/domain/entities/counter_response.dart';
import 'package:todo_dafault/domain/usecases/get_counter_task.dart';
import 'package:todo_dafault/presentation/view_model/counter_view_model.dart';

import 'counter_view_model_test.mocks.dart';

@GenerateMocks([GetCounterTask])
void main() {
  late CounterViewModel provider;
  late MockGetCounterTask mockGetCounterTask;

  setUp(() {
    mockGetCounterTask = MockGetCounterTask();
    provider = CounterViewModel(getCounterTask: mockGetCounterTask);
  });

  const tCounter = Counter(
    todo: 0,
    today: 1,
    overdue: 0,
    done: 0,
    all: 5,
  );

  const tCounterResponse =
      CounterResponse(status: 200, error: null, messages: tCounter);

  group('getCounter', () {
    test('success', () async {
      when(mockGetCounterTask.execute('valid-token'))
          .thenAnswer((_) async => const Right(tCounterResponse));

      await provider.getCounter('valid-token');

      verify(mockGetCounterTask.execute('valid-token')).called(1);
      expect(provider.counterState, RequestState.loaded);
      expect(provider.message, '');
    });

    test('failure', () async {
      when(mockGetCounterTask.execute('valid-token')).thenAnswer(
        (_) async => const Left(ServerFailure('something went wrong')),
      );

      await provider.getCounter('valid-token');

      verify(mockGetCounterTask.execute('valid-token')).called(1);
      expect(provider.counterState, RequestState.error);
      expect(provider.message, 'something went wrong');
    });
  });
}
