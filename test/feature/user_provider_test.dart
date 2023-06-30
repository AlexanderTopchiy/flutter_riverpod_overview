import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_overview/core/di.dart';
import 'package:flutter_riverpod_overview/data/model/user.dart';
import 'package:flutter_riverpod_overview/feature/user/riverpod/user_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks.dart';

void main() {
  group('UserProvider - fetchUserList -', () {
    const userList = [
      User(
        id: 0,
        name: 'first',
      ),
      User(
        id: 1,
        name: 'second',
      ),
    ];

    late final MockDataRepository repository;

    ProviderContainer makeProviderContainer(MockDataRepository mockDataRepository) {
      final container = ProviderContainer(
        overrides: [
          dataRepositoryProvider.overrideWithValue(mockDataRepository),
        ],
      );
      addTearDown(container.dispose);
      return container;
    }

    setUpAll(() {
      repository = MockDataRepository();

      registerFallbackValue(const AsyncLoading<List<User>>());
    });

    test('success state is AsyncData with fetched user list', () async {
      // GIVEN
      when(repository.fetchUserList).thenAnswer((_) async => userList);
      final container = makeProviderContainer(repository);
      final listener = Listener<AsyncValue<List<User>>>();

      // WHEN
      container.listen(
        fetchUserListProvider,
        listener,
        fireImmediately: true,
      );
      await container.read(fetchUserListProvider.future);

      // THEN
      verifyInOrder([
        () => listener(null, const AsyncLoading()),
        () => listener(const AsyncLoading(), const AsyncData(userList)),
      ]);
      verifyNoMoreInteractions(listener);
      verify(repository.fetchUserList).called(1);
    });
  });
}
