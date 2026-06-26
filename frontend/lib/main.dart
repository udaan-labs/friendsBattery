import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app/app.dart';
import 'core/storage/local_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Determine environment and load appropriate env file
  const envFile = String.fromEnvironment('ENV_FILE', defaultValue: '.env.local');
  await dotenv.load(fileName: envFile);
  
  // Initialize local storage (Hive)
  await Hive.initFlutter();
  await LocalStorage.init();

  runApp(
    const ProviderScope(
      child: BatteryApp(),
    ),
  );
}
