import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'scanner_screen.dart';
import 'scanned_serial_list.dart';

class SerialScanField extends StatelessWidget {
  final List<String> serials;
  final TextEditingController manualController;
  final bool enabled;
  final ValueChanged<String> onAdd;
  final ValueChanged<String> onRemove;
  final int? availableStock;

  const SerialScanField({
    super.key,
    required this.serials,
    required this.manualController,
    required this.enabled,
    required this.onAdd,
    required this.onRemove,
    this.availableStock,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Serial Numbers',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textPrimary),
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          icon: const Icon(Icons.qr_code_scanner),
          label: const Text('Scan Serial Number'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
            backgroundColor: AppTheme.primary,
            foregroundColor: AppTheme.onPrimary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: !enabled
              ? null
              : () async {
                  final scanned = await Navigator.of(context).push<String>(
                    MaterialPageRoute(builder: (_) => const ScannerScreen()),
                  );
                  if (scanned != null && scanned.trim().isNotEmpty && context.mounted) {
                    onAdd(scanned);
                  }
                },
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: manualController,
                enabled: enabled,
                decoration: InputDecoration(
                  hintText: 'Manual Add (Fallback)',
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onFieldSubmitted: onAdd,
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.add_circle, color: AppTheme.primary, size: 32),
              onPressed: !enabled ? null : () => onAdd(manualController.text),
            ),
          ],
        ),
        if (serials.isNotEmpty) ...[
          const SizedBox(height: 12),
          ScannedSerialList(
            serials: serials,
            availableStock: availableStock,
            onRemove: onRemove,
          ),
        ],
      ],
    );
  }
}
