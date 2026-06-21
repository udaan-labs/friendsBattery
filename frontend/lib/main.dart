import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app/app.dart';
import 'core/storage/local_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize dotenv
  await dotenv.load(fileName: ".env");
  
  // Initialize local storage (Hive)
  await Hive.initFlutter();
  await LocalStorage.init();

  runApp(
    const ProviderScope(
      child: BatteryApp(),
    ),
  );
}
