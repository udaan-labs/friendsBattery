import 'package:flutter/material.dart';
import '../../../../theme/app_theme.dart';
import 'admin_sales_period_chips.dart';
import 'admin_sales_payment_filter.dart';
import 'admin_sales_shop_filter.dart';
import 'admin_sales_type_filter.dart';

class AdminSalesFilterBar extends StatelessWidget {
  const AdminSalesFilterBar({
    super.key,
    required this.searchController,
    required this.onSearch,
    required this.exporting,
    required this.onExport,
  });

  final TextEditingController searchController;
  final ValueChanged<String> onSearch;
  final bool exporting;
  final VoidCallback onExport;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: searchController,
                  onChanged: onSearch,
                  decoration: InputDecoration(
                    hintText: 'Search sales',
                    hintStyle: const TextStyle(
                        color: Color(0xFF94A3B8), fontSize: 13),
                    prefixIcon: const Icon(Icons.search_rounded,
                        color: Color(0xFF64748B), size: 20),
                    suffixIcon: searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear_rounded,
                                color: Color(0xFF64748B), size: 18),
                            onPressed: () {
                              searchController.clear();
                              onSearch('');
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: AppTheme.surface,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
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
                      borderSide: const BorderSide(
                          color: AppTheme.primary, width: 1.5),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 48,
                height: 48,
                child: FilledButton(
                  onPressed: exporting ? null : onExport,
                  style: FilledButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: AppTheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: exporting
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.picture_as_pdf_outlined, size: 22),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const AdminSalesShopFilter(),
          const SizedBox(height: 8),
          const AdminSalesPeriodChips(),
          const SizedBox(height: 4),
          const AdminSalesTypeFilter(),
          const SizedBox(height: 4),
          const AdminSalesPaymentFilter(),
        ],
      ),
    );
  }
}
