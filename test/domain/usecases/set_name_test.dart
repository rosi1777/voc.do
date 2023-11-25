import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_dafault/domain/usecases/set_name.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SetName usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = SetName(mockRepository);
  });

  const response = "Name";
  // });

  test(
    'should set the name correctly',
    () async {
      // act
      usecase.execute(response);
      // assert
      verify(mockRepository.setName(response));
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
