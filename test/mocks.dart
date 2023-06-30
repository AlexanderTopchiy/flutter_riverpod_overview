import 'package:flutter_riverpod_overview/data/data_repository.dart';
import 'package:mocktail/mocktail.dart';

class Listener<T> extends Mock {
  void call(T? previous, T next);
}

class MockDataRepository extends Mock implements DataRepository {}
