import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/utils/app_formatters.dart';
import '../../../../theme/app_theme.dart';
import '../models/seller_sale.dart';

class SellerSaleListTile extends StatelessWidget {
  final SellerSale sale;
  final String detailsPathPrefix;
  final VoidCallback? onPay;

  const SellerSaleListTile({
    super.key,
    required this.sale,
    this.detailsPathPrefix = '/seller/sales',
    this.onPay,
  });

  @override
  Widget build(BuildContext context) {
    final due = sale.hasCreditDue;

    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () => context.push(
          '$detailsPathPrefix/${sale.id}',
          extra: sale,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${sale.productName} -- ${sale.productModel}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF191C1E),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '₹${sale.sellPrice.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.success,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                '${sale.billNumber}  ·  ${sale.customerName ?? 'Walk-in'}  ·  ${sale.paymentLabel}  ·  ${formatAppDate(sale.soldAt)}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  color: due ? const Color(0xFFC2410C) : const Color(0xFF64748B),
                ),
              ),
              if (onPay != null)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: onPay,
                    child: const Text('Collect'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
