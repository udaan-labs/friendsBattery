import 'package:flutter/material.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import '../../../theme/app_theme.dart';

String locationLabel(LocationItem s) {
  final name = s.name ?? s.code ?? 'Location';
  if (s.code != null && s.code!.isNotEmpty && s.name != null) {
    return '$name · ${s.code}';
  }
  return name;
}

class AdminLocationField extends StatelessWidget {
  const AdminLocationField({
    super.key,
    required this.formLoading,
    required this.locations,
    required this.selectedId,
    required this.onOpen,
  });

  final bool formLoading;
  final List<LocationItem> locations;
  final int? selectedId;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    LocationItem? selected;
    for (final s in locations) {
      if (s.id == selectedId) {
        selected = s;
        break;
      }
    }
    final isWh = selected?.type == LocationItemTypeEnum.WAREHOUSE;
    final label = selected == null
        ? 'Tap to choose shop or warehouse'
        : '${isWh ? 'Warehouse' : 'Shop'} · ${locationLabel(selected)}';

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: formLoading ? null : onOpen,
        borderRadius: BorderRadius.circular(8),
        child: InputDecorator(
          decoration: const InputDecoration(
            labelText: 'Location *',
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Icon(Icons.place),
            suffixIcon: Icon(Icons.unfold_more),
          ),
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: selected == null
                  ? AppTheme.textSecondary
                  : AppTheme.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> showAdminLocationPicker({
  required BuildContext context,
  required List<LocationItem> locations,
  required int? selectedId,
  required void Function(LocationItem) onSelected,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (ctx) {
      var query = '';
      return StatefulBuilder(
        builder: (ctx, setSheet) {
          final q = query.trim().toLowerCase();
          bool matches(LocationItem s) {
            if (q.isEmpty) return true;
            final name = (s.name ?? '').toLowerCase();
            final code = (s.code ?? '').toLowerCase();
            return name.contains(q) || code.contains(q);
          }

          final shops = [
            for (final s in locations)
              if (s.type != LocationItemTypeEnum.WAREHOUSE && matches(s)) s,
          ];
          final warehouses = [
            for (final s in locations)
              if (s.type == LocationItemTypeEnum.WAREHOUSE && matches(s)) s,
          ];

          return Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: MediaQuery.viewInsetsOf(ctx).bottom + 16,
            ),
            child: SizedBox(
              height: MediaQuery.sizeOf(ctx).height * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Choose location',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Shops and warehouses are listed separately.',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search name or code',
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                    ),
                    onChanged: (v) => setSheet(() => query = v),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView(
                      children: [
                        _sectionHeader(Icons.storefront, 'Shops', shops.length),
                        if (shops.isEmpty)
                          const _EmptyHint('No shops')
                        else
                          for (final s in shops)
                            _tile(s, ctx, selectedId, onSelected),
                        const SizedBox(height: 8),
                        _sectionHeader(
                          Icons.warehouse_outlined,
                          'Warehouses',
                          warehouses.length,
                        ),
                        if (warehouses.isEmpty)
                          const _EmptyHint('No warehouses')
                        else
                          for (final s in warehouses)
                            _tile(s, ctx, selectedId, onSelected),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

Widget _sectionHeader(IconData icon, String title, int count) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 8, 0, 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: AppTheme.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: AppTheme.primary,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '$count',
          style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
        ),
      ],
    ),
  );
}

Widget _tile(
  LocationItem s,
  BuildContext sheetContext,
  int? selectedId,
  void Function(LocationItem) onSelected,
) {
  final id = s.id;
  if (id == null) return const SizedBox.shrink();
  final selected = id == selectedId;
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 4),
    leading: Icon(
      s.type == LocationItemTypeEnum.WAREHOUSE
          ? Icons.warehouse_outlined
          : Icons.storefront,
      color: selected ? AppTheme.primary : AppTheme.textSecondary,
    ),
    title: Text(
      s.name ?? s.code ?? 'Location',
      style: TextStyle(
        fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
        color: AppTheme.textPrimary,
      ),
    ),
    subtitle: s.code != null && s.code!.isNotEmpty
        ? Text(s.code!, style: const TextStyle(color: AppTheme.textSecondary))
        : null,
    trailing: selected
        ? const Icon(Icons.check_circle, color: AppTheme.primary)
        : null,
    selected: selected,
    selectedTileColor: const Color(0xFFE8F5E9),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    onTap: () {
      onSelected(s);
      Navigator.pop(sheetContext);
    },
  );
}

class _EmptyHint extends StatelessWidget {
  const _EmptyHint(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Text(
        text,
        style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary),
      ),
    );
  }
}
