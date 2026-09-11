import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import '../../../../theme/app_theme.dart';
import '../models/admin_sale_history.dart';
import 'admin_sales_report_pdf.dart';

class AdminSalesPdfPreview extends StatelessWidget {
  final List<AdminSaleHistory> sales;
  final String period;
  final int total;
  final String filters;

  const AdminSalesPdfPreview({
    super.key,
    required this.sales,
    required this.period,
    required this.total,
    required this.filters,
  });

  Future<void> _share() {
    return shareAdminSalesPdf(
      sales: sales,
      period: period,
      total: total,
      filters: filters,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF preview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0F172A),
        elevation: 0,
      ),
      body: PdfPreview(
        build: (_) async => buildAdminSalesPdf(
          sales: sales,
          period: period,
          total: total,
          filters: filters,
        ).save(),
        initialPageFormat: PdfPageFormat.a4.landscape,
        canChangeOrientation: false,
        canChangePageFormat: false,
        canDebug: false,
        pdfFileName: 'sales-report.pdf',
        actionBarTheme: const PdfActionBarTheme(
          backgroundColor: AppTheme.primary,
          iconColor: Colors.white,
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: FilledButton.icon(
            onPressed: _share,
            icon: const Icon(Icons.picture_as_pdf_outlined, size: 18),
            label: const Text('Share PDF'),
            style: FilledButton.styleFrom(
              backgroundColor: AppTheme.primary,
              minimumSize: const Size.fromHeight(48),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
      ),
    );
  }
}
