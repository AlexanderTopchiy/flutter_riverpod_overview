import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_overview/core/di.dart';
import 'package:flutter_riverpod_overview/data/model/post.dart';
import 'package:flutter_riverpod_overview/data/network_exception.dart';
import 'package:flutter_riverpod_overview/feature/post/riverpod/post_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks.dart';

void main() {
  group('PostProvider - fetchPostList -', () {
    const postList = [
      Post(
        id: 0,
        title: 'first',
        body: 'body',
      ),
      Post(
        id: 1,
        title: 'second',
        body: 'body',
      ),
    ];
    const exception = NetworkException();

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

      registerFallbackValue(const AsyncLoading<List<Post>>());
    });

    test('success state is AsyncData with fetched post list', () async {
      // GIVEN
      when(repository.fetchPostList).thenAnswer((_) async => postList);
      final container = makeProviderContainer(repository);
      final listener = Listener<AsyncValue<List<Post>>>();

      // WHEN
      container.listen(
        fetchPostListProvider,
        listener,
        fireImmediately: true,
      );
      await container.read(fetchPostListProvider.future);

      // THEN
      verifyInOrder([
        () => listener(null, const AsyncLoading()),
        () => listener(const AsyncLoading(), const AsyncData(postList)),
      ]);
      verifyNoMoreInteractions(listener);
      verify(repository.fetchPostList).called(1);
    });

    test('error state is AsyncError with exception', () async {
      // GIVEN
      when(repository.fetchPostList).thenThrow(exception);
      final container = makeProviderContainer(repository);

      try {
        // WHEN
        await container.read(fetchPostListProvider.future);
      } catch (error) {
        // THEN
        verify(repository.fetchPostList).called(1);
        expect(error, exception);
      }
    });
  });
}
