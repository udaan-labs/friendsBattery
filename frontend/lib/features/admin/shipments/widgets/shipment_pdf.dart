import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../../../shared/utils/app_formatters.dart';
import '../repository/shipment_repository.dart';

pw.Document buildShipmentPdf(ShipmentDetailModel d) {
  final doc = pw.Document();
  doc.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(24),
      header: (_) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Friends Battery — Shipment',
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            '${d.shipmentNumber}  ·  ${d.status}  ·  ${formatAppDate(d.createdAt)}',
            style: const pw.TextStyle(fontSize: 9),
          ),
          pw.Text(
            [
              if (d.sellerShopName.isNotEmpty) d.sellerShopName,
              d.sellerUserName,
              if (d.sellerPhone != null && d.sellerPhone!.isNotEmpty) d.sellerPhone!,
            ].join('  ·  '),
            style: const pw.TextStyle(fontSize: 9),
          ),
          pw.SizedBox(height: 8),
        ],
      ),
      footer: (ctx) => pw.Text(
        '${d.totalQuantity} unit(s)  ·  Page ${ctx.pageNumber} of ${ctx.pagesCount}',
        style: const pw.TextStyle(fontSize: 8),
      ),
      build: (_) => [
        pw.TableHelper.fromTextArray(
          headerStyle: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
          cellStyle: const pw.TextStyle(fontSize: 8),
          cellAlignment: pw.Alignment.centerLeft,
          headers: const ['#', 'Product', 'Model', 'Serial'],
          data: [
            for (var i = 0; i < d.items.length; i++)
              [
                '${i + 1}',
                d.items[i].productName.isNotEmpty ? d.items[i].productName : '—',
                d.items[i].productModel.isNotEmpty ? d.items[i].productModel : '—',
                (d.items[i].serialNumber != null && d.items[i].serialNumber!.isNotEmpty)
                    ? d.items[i].serialNumber!
                    : '—',
              ],
          ],
        ),
      ],
    ),
  );
  return doc;
}

Future<void> shareShipmentPdf(ShipmentDetailModel d) async {
  final name = d.shipmentNumber.isNotEmpty ? d.shipmentNumber : 'shipment';
  await Printing.sharePdf(
    bytes: await buildShipmentPdf(d).save(),
    filename: '$name.pdf',
  );
}
