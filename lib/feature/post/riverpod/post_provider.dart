import 'package:flutter_riverpod_overview/core/di.dart';
import 'package:flutter_riverpod_overview/data/model/post.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_provider.g.dart';

@riverpod
class FetchPostList extends _$FetchPostList {
  @override
  FutureOr<List<Post>> build() async => ref.read(dataRepositoryProvider).fetchPostList();
}
