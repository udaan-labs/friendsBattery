import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../theme/app_theme.dart';
import '../../locations/providers/locations_providers.dart';
import '../providers/admin_sales_history_provider.dart';

const _types = <(String?, String)>[
  (null, 'All types'),
  ('NORMAL', 'Normal'),
  ('SCRAP', 'Scrap'),
  ('MECHANIC', 'Mechanic'),
  ('SERVICE', 'Service'),
  ('RENT', 'Rent'),
];

const _pay = <(String?, String)>[
  (null, 'All pay'),
  ('CASH', 'Cash'),
  ('ONLINE', 'Online'),
  ('CREDIT', 'Credit'),
];

const _periods = <AdminSalesPeriod>[
  AdminSalesPeriod.today,
  AdminSalesPeriod.week,
  AdminSalesPeriod.month,
  AdminSalesPeriod.year,
  AdminSalesPeriod.all,
];

class AdminSalesPdfChoice {
  final AdminSalesPeriod period;
  final String? saleType;
  final String? paymentMode;
  final int? locationId;

  const AdminSalesPdfChoice({
    required this.period,
    this.saleType,
    this.paymentMode,
    this.locationId,
  });
}

Future<AdminSalesPdfChoice?> showAdminSalesPdfSheet(BuildContext context) {
  return showModalBottomSheet<AdminSalesPdfChoice>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) => const _AdminSalesPdfSheet(),
  );
}

class _AdminSalesPdfSheet extends ConsumerStatefulWidget {
  const _AdminSalesPdfSheet();

  @override
  ConsumerState<_AdminSalesPdfSheet> createState() => _AdminSalesPdfSheetState();
}

class _AdminSalesPdfSheetState extends ConsumerState<_AdminSalesPdfSheet> {
  late AdminSalesPeriod _period;
  late String? _saleType;
  late String? _paymentMode;
  late int? _locationId;

  @override
  void initState() {
    super.initState();
    final s = ref.read(adminSalesHistoryProvider);
    _period = s.period == AdminSalesPeriod.custom ? AdminSalesPeriod.today : s.period;
    _saleType = s.saleType;
    _paymentMode = s.paymentMode;
    _locationId = s.locationId;
  }

  @override
  Widget build(BuildContext context) {
    final shops = ref.watch(locationsByTypeProvider('SHOP'));

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 12, 16, 16 + MediaQuery.paddingOf(context).bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Export PDF',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
          ),
          const SizedBox(height: 16),
          const Text('Period', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final p in _periods)
                _chip(
                  label: p.label(null),
                  selected: _period == p,
                  onTap: () => setState(() => _period = p),
                ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Bill type', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final (value, label) in _types)
                _chip(
                  label: label,
                  selected: _saleType == value,
                  onTap: () => setState(() => _saleType = value),
                ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Payment', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final (value, label) in _pay)
                _chip(
                  label: label,
                  selected: _paymentMode == value,
                  onTap: () => setState(() => _paymentMode = value),
                ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Shop', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
          const SizedBox(height: 8),
          shops.when(
            loading: () => const SizedBox(height: 48),
            error: (_, __) => const SizedBox.shrink(),
            data: (list) {
              final shopsWithId = list.where((s) => s.id != null).toList();
              if (shopsWithId.isEmpty) return const SizedBox.shrink();
              return DropdownButtonFormField<int?>(
                // ignore: deprecated_member_use — controlled field needs value
                value: _locationId,
                isExpanded: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppTheme.surface,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                ),
                items: [
                  const DropdownMenuItem<int?>(value: null, child: Text('All shops')),
                  ...shopsWithId.map(
                    (s) => DropdownMenuItem<int?>(
                      value: s.id,
                      child: Text(s.name ?? 'Shop #${s.id}', overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
                onChanged: (id) => setState(() => _locationId = id),
              );
            },
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () => Navigator.pop(
              context,
              AdminSalesPdfChoice(
                period: _period,
                saleType: _saleType,
                paymentMode: _paymentMode,
                locationId: _locationId,
              ),
            ),
            icon: const Icon(Icons.picture_as_pdf_outlined, size: 18),
            label: const Text('Continue'),
            style: FilledButton.styleFrom(
              backgroundColor: AppTheme.primary,
              minimumSize: const Size.fromHeight(48),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      selectedColor: AppTheme.primary,
      backgroundColor: const Color(0xFFF1F5F9),
      showCheckmark: false,
      labelStyle: TextStyle(
        color: selected ? Colors.white : const Color(0xFF475569),
        fontWeight: FontWeight.w600,
        fontSize: 13,
      ),
      side: BorderSide(
        color: selected ? AppTheme.primary : const Color(0xFFE2E8F0),
      ),
    );
  }
}
