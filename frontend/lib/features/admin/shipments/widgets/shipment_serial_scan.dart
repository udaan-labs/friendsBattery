import 'package:flutter/material.dart';
import '../../../../shared/widgets/scanner_screen.dart';
import '../../../../theme/app_theme.dart';
import '../repository/shipment_repository.dart';

class ShipmentSerialScan extends StatelessWidget {
  final List<ScannedShipmentUnit> units;
  final TextEditingController manualController;
  final bool busy;
  final ValueChanged<String> onAdd;
  final ValueChanged<String> onRemove;

  const ShipmentSerialScan({
    super.key,
    required this.units,
    required this.manualController,
    required this.busy,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Serial Numbers',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
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
          onPressed: busy
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
                enabled: !busy,
                decoration: InputDecoration(
                  hintText: 'Type serial number',
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
              onPressed: busy ? null : () => onAdd(manualController.text),
            ),
          ],
        ),
        if (busy) ...[
          const SizedBox(height: 8),
          const LinearProgressIndicator(minHeight: 2),
        ],
        if (units.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(
            'Scanned ${units.length}',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 320),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: units.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final u = units[i];
                final product = [u.productName, u.productModel]
                    .where((s) => s.isNotEmpty)
                    .join(' / ');
                return ListTile(
                  dense: true,
                  title: Text(u.serial, maxLines: 1, overflow: TextOverflow.ellipsis),
                  subtitle: product.isEmpty
                      ? null
                      : Text(product, maxLines: 1, overflow: TextOverflow.ellipsis),
                  trailing: IconButton(
                    icon: const Icon(Icons.close, size: 18, color: AppTheme.error),
                    tooltip: 'Remove',
                    visualDensity: VisualDensity.compact,
                    onPressed: () => onRemove(u.serial),
                  ),
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}
