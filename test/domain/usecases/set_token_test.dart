import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_dafault/domain/usecases/set_token.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SetToken usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = SetToken(mockRepository);
  });

  const response = "Token";
  // });

  test(
    'should set the token correctly',
    () async {
      // act
      usecase.execute(response);
      // assert
      verify(mockRepository.setToken(response));
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
