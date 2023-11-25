import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_dafault/domain/entities/counter.dart';
import 'package:todo_dafault/domain/entities/counter_response.dart';
import 'package:todo_dafault/domain/usecases/get_counter_task.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetCounterTask usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = GetCounterTask(mockRepository);
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

  test('should get counter task from the repository', () async {
    // arrange
    when(mockRepository.getCounterTask('token'))
        .thenAnswer((_) async => const Right(tCounterResponse));
    // act
    final result = await usecase.execute('token');
    // assert
    expect(result, const Right(tCounterResponse));
  });
}
