import 'package:flutter_riverpod_overview/core/di.dart';
import 'package:flutter_riverpod_overview/data/data_repository.dart';
import 'package:flutter_riverpod_overview/data/model/post.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_provider.g.dart';

@riverpod
Future<List<Post>> fetchPostList(FetchPostListRef ref) async => DI.get<DataRepository>().fetchPostList();
