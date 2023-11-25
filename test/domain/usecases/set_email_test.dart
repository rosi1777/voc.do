import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_dafault/domain/usecases/set_email.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SetEmail usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = SetEmail(mockRepository);
  });

  const response = "Email";
  // });

  test(
    'should set the email correctly',
    () async {
      // act
      usecase.execute(response);
      // assert
      verify(mockRepository.setEmail(response));
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
