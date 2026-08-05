import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/responsive_helper.dart';
import '../../../../shared/widgets/snackbar_helper.dart';
import '../../../../theme/app_theme.dart';
import '../providers/locations_providers.dart';

/// Admin create shop (`SHOP`) or warehouse (`WAREHOUSE`).
class AddLocationScreen extends ConsumerStatefulWidget {
  const AddLocationScreen({super.key, required this.type});

  /// `SHOP` or `WAREHOUSE`
  final String type;

  @override
  ConsumerState<AddLocationScreen> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends ConsumerState<AddLocationScreen> {
  final _codeController = TextEditingController();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _submitting = false;

  bool get _isShop => widget.type == 'SHOP';

  @override
  void dispose() {
    _codeController.dispose();
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final code = _codeController.text.trim();
    final name = _nameController.text.trim();
    if (code.isEmpty || name.isEmpty) {
      context.showErrorSnackBar('Code and name are required');
      return;
    }

    setState(() => _submitting = true);
    try {
      await ref.read(locationsRepositoryProvider).create(
            code: code,
            name: name,
            type: widget.type,
            address: _addressController.text.trim(),
            phone: _phoneController.text.trim(),
          );
      ref.invalidate(locationsByTypeProvider(widget.type));
      if (!mounted) return;
      context.showSuccessSnackBar(
        _isShop ? 'Shop created' : 'Warehouse created',
      );
      context.pop(true);
    } catch (e) {
      if (!mounted) return;
      context.showErrorSnackBar(e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: Text(
          _isShop ? 'Add Shop' : 'Add Warehouse',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(ResponsiveHelper.responsivePadding(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                _isShop ? Icons.storefront_outlined : Icons.warehouse_outlined,
                size: 48,
                color: AppTheme.primary,
              ),
              const SizedBox(height: 12),
              Text(
                _isShop
                    ? 'Create a shop to assign sellers and staff'
                    : 'Create a warehouse for inventory storage',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15, color: Color(0xFF545F73)),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(ResponsiveHelper.cardPadding(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: _codeController,
                      enabled: !_submitting,
                      textCapitalization: TextCapitalization.characters,
                      decoration: InputDecoration(
                        labelText: 'Code',
                        hintText: _isShop ? 'e.g. SHOP002' : 'e.g. WH002',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _nameController,
                      enabled: !_submitting,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        hintText: _isShop
                            ? 'e.g. Andheri Shop'
                            : 'e.g. Main Warehouse',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _addressController,
                      enabled: !_submitting,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: 'Address (optional)',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _phoneController,
                      enabled: !_submitting,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Phone (optional)',
                      ),
                    ),
                    const SizedBox(height: 28),
                    ElevatedButton(
                      onPressed: _submitting ? null : _submit,
                      child: _submitting
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(
                              _isShop ? 'Create shop' : 'Create warehouse',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
