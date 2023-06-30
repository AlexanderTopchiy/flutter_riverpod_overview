import 'package:dio/dio.dart';
import 'package:flutter_riverpod_overview/data/app_constants.dart';
import 'package:flutter_riverpod_overview/data/data_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'di.g.dart';

@riverpod
DataRepository dataRepository(DataRepositoryRef ref) {
  final dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
  return DataRepository(client: dio);
}
