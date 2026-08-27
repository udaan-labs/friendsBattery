import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ScannedSerialList extends StatelessWidget {
  final List<String> serials;
  final int? availableStock;
  final ValueChanged<String> onRemove;

  const ScannedSerialList({
    super.key,
    required this.serials,
    this.availableStock,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    if (serials.isEmpty) return const SizedBox.shrink();

    final cap = availableStock;
    final label = cap != null ? 'Scanned ${serials.length} / $cap' : 'Scanned ${serials.length}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppTheme.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 280),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: serials.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, i) {
              final s = serials[i];
              return ListTile(
                dense: true,
                title: Text(s, maxLines: 1, overflow: TextOverflow.ellipsis),
                trailing: IconButton(
                  icon: const Icon(Icons.close, size: 18, color: AppTheme.error),
                  tooltip: 'Remove',
                  visualDensity: VisualDensity.compact,
                  onPressed: () => onRemove(s),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
