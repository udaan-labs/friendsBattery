import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../../../shared/utils/app_formatters.dart';
import '../models/admin_sale_history.dart';

pw.Document buildAdminSalesPdf({
  required List<AdminSaleHistory> sales,
  required String period,
  required int total,
  String filters = '',
}) {
  final truncated = total > sales.length;
  final booked = sales.fold<double>(0, (s, r) => s + r.sellPrice);
  final collected = sales.fold<double>(0, (s, r) => s + r.amountPaid);
  final doc = pw.Document();
  doc.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4.landscape,
      margin: const pw.EdgeInsets.all(24),
      header: (_) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text('Friends Battery — Sales report',
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 4),
          pw.Text(
            '$period  ·  $filters  ·  ${sales.length} row(s)  ·  collected ₹${collected.toStringAsFixed(0)}  ·  booked ₹${booked.toStringAsFixed(0)}'
            '${truncated ? '  ·  truncated (max 2000 of $total)' : ''}',
            style: const pw.TextStyle(fontSize: 9),
          ),
          pw.SizedBox(height: 8),
        ],
      ),
      build: (_) => [
        pw.TableHelper.fromTextArray(
          headerStyle: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
          cellStyle: const pw.TextStyle(fontSize: 7),
          cellAlignment: pw.Alignment.centerLeft,
          headers: const ['Date', 'Bill', 'Shop', 'Type', 'Pay', 'Product', 'Serial', 'Customer', 'Booked', 'Paid'],
          data: [
            for (final s in sales)
              [
                formatAppDate(s.soldAt),
                s.billNumber,
                s.shopName,
                s.saleType,
                s.paymentLabel,
                '${s.productName} -- ${s.productModel}',
                s.hasUnitSerial ? s.serialNumber : '—',
                s.customerName ?? '—',
                s.sellPrice.toStringAsFixed(0),
                s.amountPaid.toStringAsFixed(0),
              ],
          ],
        ),
      ],
    ),
  );
  return doc;
}

Future<void> shareAdminSalesPdf({
  required List<AdminSaleHistory> sales,
  required String period,
  required int total,
  String filters = '',
}) async {
  await Printing.sharePdf(
    bytes: await buildAdminSalesPdf(
      sales: sales,
      period: period,
      total: total,
      filters: filters,
    ).save(),
    filename: 'sales-report.pdf',
  );
}
