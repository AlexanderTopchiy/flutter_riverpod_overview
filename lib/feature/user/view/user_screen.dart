import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_overview/data/model/user.dart';
import 'package:flutter_riverpod_overview/feature/common/component/card_list.dart';
import 'package:flutter_riverpod_overview/feature/user/riverpod/user_provider.dart';
import 'package:flutter_riverpod_overview/generated/l10n.dart';

class UserScreen extends ConsumerWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userList = ref.watch(fetchUserListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.users),
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.refresh(fetchUserListProvider.future),
        child: userList.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          data: (data) => CardList<User>(itemList: data),
          error: (_, __) => Center(child: Text(S.current.networkError)),
        ),
      ),
    );
  }
}
