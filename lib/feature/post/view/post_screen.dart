import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_overview/data/model/post.dart';
import 'package:flutter_riverpod_overview/feature/common/component/card_list.dart';
import 'package:flutter_riverpod_overview/feature/post/riverpod/post_provider.dart';
import 'package:flutter_riverpod_overview/generated/l10n.dart';

class PostScreen extends ConsumerWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postList = ref.watch(fetchPostListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.posts),
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.refresh(fetchPostListProvider.future),
        child: postList.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          data: (data) => CardList<Post>(itemList: data),
          error: (_, __) => Center(child: Text(S.current.networkError)),
        ),
      ),
    );
  }
}
