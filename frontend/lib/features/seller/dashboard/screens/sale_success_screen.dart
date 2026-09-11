import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../shared/utils/app_formatters.dart';
import '../../../../shared/widgets/snackbar_helper.dart';
import '../models/sale_success_data.dart';
import '../widgets/invoice_widget.dart';

class SaleSuccessScreen extends StatefulWidget {
  final SaleSuccessData saleData;

  const SaleSuccessScreen({super.key, required this.saleData});

  @override
  State<SaleSuccessScreen> createState() => _SaleSuccessScreenState();
}

class _SaleSuccessScreenState extends State<SaleSuccessScreen> {
  final ScreenshotController _screenshotController = ScreenshotController();
  /// One busy flag for WA / print / share (only one action at a time).
  String? _busy;

  String _whatsAppMessage(SaleSuccessData data) {
    final dateStr = formatAppDate(data.saleDate);
    final isReturn = data.invoiceNumber.startsWith('RET-');
    final thanks = isReturn
        ? 'Thank you for returning the battery to *Friends Battery*.'
        : 'Thank you for purchasing from *Friends Battery*.';
    final amountLine = data.isCredit
        ? '• Paid now: ₹${data.paid}\n• Amount due (credit): ₹${data.due}'
        : '• Amount Paid: ₹${data.sellPrice}';
    return '''Hello ${data.customerName},

$thanks

🧾 Invoice No: ${data.invoiceNumber}
📅 Date: $dateStr

Battery Details
• Product: ${data.productName}
• Serial No: ${data.serialNumber}
$amountLine

Please keep this invoice for future warranty claims.

Thank you for choosing Friends Battery.''';
  }

  Future<Uint8List?> _captureInvoicePng() => _screenshotController.capture(
        delay: const Duration(milliseconds: 10),
      );

  Future<void> _run(String key, Future<void> Function() action) async {
    if (_busy != null) return;
    setState(() => _busy = key);
    try {
      await action();
    } catch (e) {
      if (mounted) {
        final msg = e.toString().replaceFirst(RegExp(r'^Exception:\s*'), '');
        context.showErrorSnackBar(msg);
      }
    } finally {
      if (mounted) setState(() => _busy = null);
    }
  }

  Future<void> _messageCustomerOnWhatsApp() => _run('wa', () async {
        final digits =
            widget.saleData.customerNumber.replaceAll(RegExp(r'\D'), '');
        if (digits.length != 10) {
          throw Exception('Customer mobile must be 10 digits to open WhatsApp');
        }
        final uri = Uri.parse(
          'https://wa.me/91$digits?text=${Uri.encodeComponent(_whatsAppMessage(widget.saleData))}',
        );
        final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
        if (!ok) throw Exception('Could not open WhatsApp');
      });

  Future<void> _printBill() => _run('print', () async {
        final imageBytes = await _captureInvoicePng();
        if (imageBytes == null) throw Exception('Failed to generate invoice image');

        final doc = pw.Document();
        doc.addPage(
          pw.Page(
            pageFormat: PdfPageFormat.a4,
            margin: const pw.EdgeInsets.all(24),
            build: (_) =>
                pw.Center(child: pw.Image(pw.MemoryImage(imageBytes), fit: pw.BoxFit.contain)),
          ),
        );
        await Printing.layoutPdf(
          onLayout: (_) async => doc.save(),
          name: 'invoice_${widget.saleData.invoiceNumber}',
        );
      });

  Future<void> _shareInvoiceImage() => _run('share', () async {
        final imageBytes = await _captureInvoicePng();
        if (imageBytes == null) throw Exception('Failed to generate invoice image');

        final tempDir = await getTemporaryDirectory();
        final file = await File(
          '${tempDir.path}/invoice_${widget.saleData.invoiceNumber}.png',
        ).create();
        await file.writeAsBytes(imageBytes);

        final result = await Share.shareXFiles(
          [XFile(file.path, mimeType: 'image/png')],
          text: _whatsAppMessage(widget.saleData),
        );
        if (result.status == ShareResultStatus.success && mounted) {
          context.showSuccessSnackBar('Invoice shared successfully');
        }
      });

  String get _home {
    final path = GoRouterState.of(context).uri.path;
    if (path.startsWith('/admin')) return '/admin/dashboard';
    if (path.startsWith('/employee')) return '/employee/home';
    return '/seller/dashboard';
  }

  Widget _spinner({Color color = Colors.white}) => SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(strokeWidth: 2, color: color),
      );

  @override
  Widget build(BuildContext context) {
    final data = widget.saleData;
    final busy = _busy != null;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        title: const Text('Sale Successful'),
        backgroundColor: const Color(0xFFF7F9FB),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Color(0xFF3E4A3D)),
          onPressed: () => context.go(_home),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0A000000),
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.check_circle, color: Color(0xFF006B2C), size: 64),
                        const SizedBox(height: 16),
                        const Text(
                          'Sale Recorded Successfully!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF191C1E),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'WhatsApp the customer, print the bill, or share the invoice image.',
                          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: busy ? null : _messageCustomerOnWhatsApp,
                          icon: _busy == 'wa'
                              ? _spinner()
                              : const Icon(Icons.chat),
                          label: Text(_busy == 'wa' ? 'Opening WhatsApp...' : 'WhatsApp customer'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF25D366),
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton.icon(
                          onPressed: busy ? null : _printBill,
                          icon: _busy == 'print'
                              ? _spinner()
                              : const Icon(Icons.print),
                          label: Text(_busy == 'print' ? 'Preparing print...' : 'Print bill'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF006B2C),
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton.icon(
                          onPressed: busy ? null : _shareInvoiceImage,
                          icon: _busy == 'share'
                              ? _spinner(color: const Color(0xFF006B2C))
                              : const Icon(Icons.image_outlined),
                          label: Text(_busy == 'share' ? 'Preparing...' : 'Share invoice image'),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton(
                          onPressed: () => context.go(_home),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Back to Dashboard'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Invoice Preview',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Screenshot(
                      controller: _screenshotController,
                      child: InvoiceWidget(
                        invoiceNumber: data.invoiceNumber,
                        saleDate: data.saleDate,
                        customerName: data.customerName,
                        customerMobile: data.customerNumber,
                        productName: data.productName,
                        serialNumber: data.serialNumber,
                        sellingPrice: data.sellPrice,
                        sellerName: data.sellerName,
                        paymentMode: data.paymentMode,
                        amountPaid: data.paid,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
