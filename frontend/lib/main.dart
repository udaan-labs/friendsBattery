import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/storage/local_store.dart';
import 'core/storage/session_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const envFile = String.fromEnvironment('ENV_FILE', defaultValue: '.env.local');
  await dotenv.load(fileName: envFile);
  await LocalStore.init();

  runApp(const _RestartHost());
}

/// New [ProviderScope] after logout so no screen keeps the previous user's data.
class _RestartHost extends StatelessWidget {
  const _RestartHost();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: SessionManager.restartTick,
      builder: (context, tick, _) {
        return ProviderScope(
          key: ValueKey(tick),
          child: const BatteryApp(),
        );
      },
    );
  }
}
