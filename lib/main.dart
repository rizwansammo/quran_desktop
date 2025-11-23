import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'src/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SQLite for Desktop
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
