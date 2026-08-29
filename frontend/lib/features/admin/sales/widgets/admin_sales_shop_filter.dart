import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../theme/app_theme.dart';
import '../../locations/providers/locations_providers.dart';
import '../providers/admin_sales_history_provider.dart';

class AdminSalesShopFilter extends ConsumerWidget {
  const AdminSalesShopFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shops = ref.watch(locationsByTypeProvider('SHOP'));
    final selected = ref.watch(adminSalesHistoryProvider).locationId;

    return shops.when(
      loading: () => const SizedBox(height: 48),
      error: (_, __) => const SizedBox.shrink(),
      data: (list) {
        final shopsWithId = list.where((s) => s.id != null).toList();
        if (shopsWithId.isEmpty) return const SizedBox.shrink();
        return DropdownButtonFormField<int?>(
          // ignore: deprecated_member_use — controlled field needs value
          value: selected,
          isExpanded: true,
          decoration: InputDecoration(
            hintText: 'All shops',
            prefixIcon: const Icon(Icons.storefront_outlined,
                size: 20, color: Color(0xFF64748B)),
            filled: true,
            fillColor: AppTheme.surface,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppTheme.primary, width: 1.5),
            ),
          ),
            items: [
              const DropdownMenuItem<int?>(
                value: null,
                child: Text('All shops'),
              ),
              if (selected != null &&
                  shopsWithId.every((s) => s.id != selected))
                DropdownMenuItem<int?>(
                  value: selected,
                  child: Text('Shop #$selected'),
                ),
              ...shopsWithId.map(
                (s) => DropdownMenuItem<int?>(
                  value: s.id,
                  child: Text(
                    s.name ?? 'Shop #${s.id}',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          onChanged: (id) =>
              ref.read(adminSalesHistoryProvider.notifier).setLocationId(id),
        );
      },
    );
  }
}
