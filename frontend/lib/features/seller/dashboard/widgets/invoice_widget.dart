import 'package:flutter/material.dart';
import '../../../../shared/utils/app_formatters.dart';

class InvoiceWidget extends StatelessWidget {
  final String invoiceNumber;
  final DateTime saleDate;
  final String customerName;
  final String customerMobile;
  final String productName;
  final String productGroup;
  final String productSubgroup;
  final String serialNumber;
  final int quantity;
  final double sellingPrice;
  final String warrantyDetails;
  final String sellerName;

  const InvoiceWidget({
    super.key,
    required this.invoiceNumber,
    required this.saleDate,
    required this.customerName,
    required this.customerMobile,
    required this.productName,
    this.productGroup = '',
    this.productSubgroup = '',
    required this.serialNumber,
    this.quantity = 1,
    required this.sellingPrice,
    this.warrantyDetails = '',
    required this.sellerName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Friends Battery',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF006B2C)),
                    ),
                    const SizedBox(height: 4),
                    const Text('Your Trusted Power Partner', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('INVOICE', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black54)),
                  const SizedBox(height: 4),
                  Text(invoiceNumber, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),
          // Customer & Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Billed To:', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    const SizedBox(height: 4),
                    Text(customerName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    if (customerMobile.isNotEmpty)
                      Text(customerMobile, style: const TextStyle(fontSize: 14, color: Colors.black87)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Date:', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    const SizedBox(height: 4),
                    Text(formatAppDateTime(saleDate), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    const Text('Seller:', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    Text(sellerName, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Product Details Table
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                  ),
                  child: Row(
                    children: const [
                      Expanded(flex: 3, child: Text('Description', style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(flex: 1, child: Text('Qty', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(flex: 2, child: Text('Amount', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(productName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            const SizedBox(height: 4),
                            if (productGroup.isNotEmpty) Text('Group: $productGroup', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                            if (productSubgroup.isNotEmpty) Text('Subgroup: $productSubgroup', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                            const SizedBox(height: 4),
                            Text('S/N: $serialNumber', style: const TextStyle(fontSize: 13, color: Colors.black54)),
                            if (warrantyDetails.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text('Warranty: $warrantyDetails', style: const TextStyle(fontSize: 12, color: Colors.green, fontWeight: FontWeight.w500)),
                            ],
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(quantity.toString(), textAlign: TextAlign.center, style: const TextStyle(fontSize: 14)),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text('₹${sellingPrice.toStringAsFixed(2)}', textAlign: TextAlign.right, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Total Amount
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text('Total Amount Paid: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(
                '₹${sellingPrice.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF006B2C)),
              ),
            ],
          ),
          const SizedBox(height: 32),
          // Footer
          Center(
            child: Column(
              children: [
                const Text('Thank you for your business!', style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey)),
                const SizedBox(height: 8),
                Text('Please keep this invoice for future warranty claims.', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
