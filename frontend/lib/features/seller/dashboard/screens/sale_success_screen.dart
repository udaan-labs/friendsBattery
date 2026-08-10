import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
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
  bool _isSharing = false;

  String _getWhatsAppMessage(SaleSuccessData data) {
    final dateStr = formatAppDate(data.saleDate);

    return '''Hello ${data.customerName},

Thank you for purchasing from *Friends Battery*.

🧾 Invoice No: ${data.invoiceNumber}
📅 Date: $dateStr

Battery Details
• Product: ${data.productName}
• Serial No: ${data.serialNumber}
• Amount Paid: ₹${data.sellPrice}

Your invoice is attached as an image.
Please keep this invoice for future warranty claims.

Thank you for choosing Friends Battery.''';
  }

  Future<void> _shareOnWhatsApp() async {
    setState(() {
      _isSharing = true;
    });

    try {
      final imageBytes = await _screenshotController.capture(delay: const Duration(milliseconds: 10));
      if (imageBytes == null) {
        throw Exception('Failed to generate invoice image');
      }

      final tempDir = await getTemporaryDirectory();
      final invoiceNumber = widget.saleData.invoiceNumber;
      final file = await File('${tempDir.path}/invoice_$invoiceNumber.png').create();
      await file.writeAsBytes(imageBytes);

      final message = _getWhatsAppMessage(widget.saleData);

      final result = await Share.shareXFiles(
        [XFile(file.path, mimeType: 'image/png')],
        text: message,
      );

      if (result.status == ShareResultStatus.success) {
        if (mounted) context.showSuccessSnackBar('Invoice shared successfully');
      }
    } catch (e) {
      if (mounted) {
        context.showErrorSnackBar('Could not share invoice: $e');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSharing = false;
        });
      }
    }
  }

  String get _dashboardPath {
    final path = GoRouterState.of(context).uri.path;
    return path.startsWith('/admin') ? '/admin/dashboard' : '/seller/dashboard';
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.saleData;
    final home = _dashboardPath;

    final invoiceWidget = InvoiceWidget(
      invoiceNumber: data.invoiceNumber,
      saleDate: data.saleDate,
      customerName: data.customerName,
      customerMobile: data.customerNumber,
      productName: data.productName,
      serialNumber: data.serialNumber,
      sellingPrice: data.sellPrice,
      sellerName: data.sellerName,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        title: const Text('Sale Successful'),
        backgroundColor: const Color(0xFFF7F9FB),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Color(0xFF3E4A3D)),
          onPressed: () {
            context.go(home);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24.0),
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
                        const Icon(
                          Icons.check_circle,
                          color: Color(0xFF006B2C),
                          size: 64,
                        ),
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
                          'You can now share the digital invoice with the customer via WhatsApp.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: _isSharing ? null : _shareOnWhatsApp,
                          icon: _isSharing
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                )
                              : const Icon(Icons.share),
                          label: Text(_isSharing ? 'Preparing...' : 'Share on WhatsApp'),
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
                        OutlinedButton(
                          onPressed: () => context.go(home),
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
                  Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x1A000000),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Screenshot(
                        controller: _screenshotController,
                        child: invoiceWidget,
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
