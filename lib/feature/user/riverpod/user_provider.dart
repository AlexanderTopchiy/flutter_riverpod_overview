import 'package:flutter_riverpod_overview/core/di.dart';
import 'package:flutter_riverpod_overview/data/data_repository.dart';
import 'package:flutter_riverpod_overview/data/model/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@riverpod
Future<List<User>> fetchUserList(FetchUserListRef ref) async => DI.get<DataRepository>().fetchUserList();
