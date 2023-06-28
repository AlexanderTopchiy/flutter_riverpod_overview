import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_overview/app/riverpod_app.dart';
import 'package:flutter_riverpod_overview/core/di.dart';

void main() {
  DI.register();

  runApp(const ProviderScope(child: RiverpodApp()));
}
