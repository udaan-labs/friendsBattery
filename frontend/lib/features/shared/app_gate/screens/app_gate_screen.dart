import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../theme/app_theme.dart';
import '../providers/app_gate_provider.dart';

/// Full-screen block for force-update or maintenance (all roles).
class AppGateScreen extends ConsumerWidget {
  const AppGateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gate = ref.watch(appGateProvider);
    final isMaintenance = gate.mode == AppGateMode.maintenance;

    final title = isMaintenance ? 'Under maintenance' : 'Update available';
    final defaultBody = isMaintenance
        ? 'Friends Battery is temporarily unavailable. Please try again later.'
        : 'A new version of the app is required to continue.';
    final body = (gate.message != null && gate.message!.trim().isNotEmpty)
        ? gate.message!.trim()
        : defaultBody;

    final icon = isMaintenance ? Icons.construction_rounded : Icons.system_update_rounded;

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppTheme.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              children: [
                const Spacer(),
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    color: AppTheme.surface,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Icon(icon, size: 48, color: AppTheme.primary),
                ),
                const SizedBox(height: 24),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  body,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15,
                    height: 1.45,
                    color: AppTheme.textSecondary,
                  ),
                ),
                if (!isMaintenance &&
                    (gate.localVersion != null || gate.latestVersion != null)) ...[
                  const SizedBox(height: 20),
                  Text(
                    [
                      if (gate.localVersion != null) 'Current: ${gate.localVersion}',
                      if (gate.latestVersion != null) 'Required: ${gate.latestVersion}',
                    ].join('  ·  '),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
                const Spacer(),
                if (!isMaintenance &&
                    gate.updateUrl != null &&
                    gate.updateUrl!.trim().isNotEmpty) ...[
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _openUpdateUrl(gate.updateUrl!.trim()),
                      child: const Text('Update now'),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: gate.isLoading
                        ? null
                        : () => ref.read(appGateProvider.notifier).check(),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(64, 48),
                      foregroundColor: AppTheme.primary,
                      side: const BorderSide(color: AppTheme.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9999),
                      ),
                    ),
                    child: gate.isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Check again'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openUpdateUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
