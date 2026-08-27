import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/state/data_sync.dart';
import '../../../../shared/widgets/responsive_helper.dart';
import '../../../../shared/widgets/snackbar_helper.dart';
import '../../../shared/products/providers/product_catalog_providers.dart';

/// Super Admin catalog: add name, add model, or configure pricing.
class AddProductHubScreen extends StatelessWidget {
  const AddProductHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        title: const Text('Add Product'),
        backgroundColor: const Color(0xFFF7F9FB),
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(ResponsiveHelper.responsivePadding(context)),
        children: [
          _HubTile(
            title: 'Add Product',
            subtitle: 'New product name',
            icon: Icons.inventory_2_outlined,
            onTap: () => context.push('/admin/add-product/name'),
          ),
          const SizedBox(height: 8),
          _HubTile(
            title: 'Add Model',
            subtitle: 'New model under a product name',
            icon: Icons.category_outlined,
            onTap: () => context.push('/admin/add-product/model'),
          ),
          const SizedBox(height: 8),
          _HubTile(
            title: 'Configure Product',
            subtitle: 'Pricing and unit thresholds',
            icon: Icons.price_change_outlined,
            onTap: () => context.push('/admin/add-product/configure'),
          ),
        ],
      ),
    );
  }
}

class _HubTile extends StatelessWidget {
  const _HubTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      leading: Icon(icon, color: const Color(0xFF006B2C)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

class AddProductNameScreen extends ConsumerStatefulWidget {
  const AddProductNameScreen({super.key});

  @override
  ConsumerState<AddProductNameScreen> createState() =>
      _AddProductNameScreenState();
}

class _AddProductNameScreenState extends ConsumerState<AddProductNameScreen> {
  final _name = TextEditingController();
  bool _busy = false;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final name = _name.text.trim();
    if (name.isEmpty) {
      context.showErrorSnackBar('Enter a product name');
      return;
    }
    if (_busy) return;
    setState(() => _busy = true);
    try {
      final id =
          await ref.read(productCatalogRepositoryProvider).createProductName(name);
      if (!mounted) return;
      context.showSuccessSnackBar('Product name added');
      await DataSync.afterProductMutation(ref);
      if (mounted) {
        context.pushReplacement('/admin/add-product/model?productNameId=$id');
      }
    } on DioException catch (e) {
      if (mounted) {
        context.showErrorSnackBar(
          e.response?.data?['message']?.toString() ?? 'Failed to add name',
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        title: const Text('Add Product'),
        backgroundColor: const Color(0xFFF7F9FB),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(ResponsiveHelper.responsivePadding(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _name,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Product name',
                hintText: 'e.g. Amaron',
              ),
              onSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _busy ? null : _submit,
              child: _busy
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Next: Add Model'),
            ),
          ],
        ),
      ),
    );
  }
}

class AddProductModelScreen extends ConsumerStatefulWidget {
  const AddProductModelScreen({super.key, this.initialProductNameId});

  final String? initialProductNameId;

  @override
  ConsumerState<AddProductModelScreen> createState() =>
      _AddProductModelScreenState();
}

class _AddProductModelScreenState extends ConsumerState<AddProductModelScreen> {
  final _name = TextEditingController();
  String? _productNameId;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _productNameId = widget.initialProductNameId;
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final name = _name.text.trim();
    if (_productNameId == null) {
      context.showErrorSnackBar('Select a product name');
      return;
    }
    if (name.isEmpty) {
      context.showErrorSnackBar('Enter a model name');
      return;
    }
    if (_busy) return;
    setState(() => _busy = true);
    try {
      final modelId =
          await ref.read(productCatalogRepositoryProvider).createProductModel(
                productNameId: int.parse(_productNameId!),
                name: name,
              );
      if (!mounted) return;
      context.showSuccessSnackBar('Product model added');
      await DataSync.afterProductMutation(ref);
      if (mounted) {
        context.pushReplacement(
          '/admin/add-product/configure?productNameId=$_productNameId&productModelId=$modelId',
        );
      }
    } on DioException catch (e) {
      if (mounted) {
        context.showErrorSnackBar(
          e.response?.data?['message']?.toString() ?? 'Failed to add model',
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final namesAsync = ref.watch(productNamesProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        title: const Text('Add Model'),
        backgroundColor: const Color(0xFFF7F9FB),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(ResponsiveHelper.responsivePadding(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            namesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => TextButton(
                onPressed: () => ref.invalidate(productNamesProvider),
                child: Text('Failed to load names. Retry ($e)'),
              ),
              data: (names) {
                if (names.isEmpty) {
                  return TextButton(
                    onPressed: () => context.push('/admin/add-product/name'),
                    child: const Text('No product names yet — add one first'),
                  );
                }
                return DropdownButtonFormField<String>(
                  isExpanded: true,
                  value: names.any((n) => n.id == _productNameId)
                      ? _productNameId
                      : null,
                  decoration: const InputDecoration(labelText: 'Product name'),
                  items: [
                    for (final n in names)
                      DropdownMenuItem(value: n.id, child: Text(n.name)),
                  ],
                  onChanged: (id) => setState(() => _productNameId = id),
                );
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _name,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Model name',
                hintText: 'e.g. FLO 42B20L',
              ),
              onSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _busy ? null : _submit,
              child: _busy
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Next: Configure'),
            ),
          ],
        ),
      ),
    );
  }
}
