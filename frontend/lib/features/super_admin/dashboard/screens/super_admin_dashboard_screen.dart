import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/auth_provider.dart';
import '../../../../theme/app_theme.dart';

/// Placeholder shell for Super Admin until §1 (all WH/shops, PDF, GPS).
class SuperAdminDashboardScreen extends ConsumerWidget {
  const SuperAdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Super Admin'),
        actions: [
          IconButton(
            tooltip: 'Logout',
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authProvider.notifier).logout();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Super Admin home',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                'Role chain is live: SUPER ADMIN → ADMIN → SELLER → EMPLOYEE.\n\n'
                'Full tools (all warehouses/shops, stock any WH, PDF, GPS) come in roadmap §1.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.black87,
                      height: 1.4,
                    ),
              ),
              const SizedBox(height: 24),
              Card(
                child: ListTile(
                  leading: Icon(Icons.construction, color: AppTheme.primary),
                  title: const Text('Coming next'),
                  subtitle: const Text(
                    '§1 Super Admin: manage all locations, admins, stock, reports',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
