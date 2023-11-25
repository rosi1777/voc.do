import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_dafault/domain/usecases/set_on_boarding.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SetOnBoarding usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = SetOnBoarding(mockRepository);
  });

  const response = true;
  // });

  test(
    'should set the onBoarding correctly',
    () async {
      // act
      usecase.execute(response);
      // assert
      verify(mockRepository.setOnBoarding(response));
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
