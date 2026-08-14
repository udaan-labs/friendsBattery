import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/products/providers/product_catalog_providers.dart';
import '../../../../shared/utils/app_formatters.dart';
import '../../../../theme/app_theme.dart';

typedef _Combo = ({CatalogItem name, CatalogItem? model});

enum _Filter { all, sale, notConfig }

enum _Look { onSale, notConfigured, ready }

_Look _lookOf(WidgetRef ref, _Combo row) {
  final nameId = int.tryParse(row.name.id);
  final modelId = int.tryParse(row.model?.id ?? '');
  if (nameId == null || modelId == null) return _Look.notConfigured;
  final p = ref.watch(productConfigProvider((nameId: nameId, modelId: modelId))).valueOrNull;
  if (p == null) return _Look.notConfigured;
  return p.onSale == true ? _Look.onSale : _Look.ready;
}

/// Super Admin catalog: one row per product name + model.
class ProductCatalogListScreen extends ConsumerStatefulWidget {
  const ProductCatalogListScreen({super.key});

  @override
  ConsumerState<ProductCatalogListScreen> createState() =>
      _ProductCatalogListScreenState();
}

class _ProductCatalogListScreenState
    extends ConsumerState<ProductCatalogListScreen> {
  final _search = TextEditingController();
  _Filter _filter = _Filter.all;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(productCatalogCombosProvider);

    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Products',
          style: TextStyle(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/admin/add-product'),
        backgroundColor: AppTheme.primary,
        foregroundColor: AppTheme.onPrimary,
        icon: const Icon(Icons.add),
        label: const Text('Add product'),
      ),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(friendlyError(e), textAlign: TextAlign.center),
              TextButton(
                onPressed: () => ref.invalidate(productCatalogCombosProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (rows) {
          final q = _search.text.trim().toLowerCase();
          final visible = rows.where((r) {
            final name = r.name.name.toLowerCase();
            final model = (r.model?.name ?? '').toLowerCase();
            if (q.isNotEmpty && !name.contains(q) && !model.contains(q)) {
              return false;
            }
            if (_filter == _Filter.all) return true;
            final look = _lookOf(ref, r);
            return _filter == _Filter.sale
                ? look == _Look.onSale
                : look == _Look.notConfigured;
          }).toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: TextField(
                  controller: _search,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Search name or model…',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _search.text.isEmpty
                        ? null
                        : IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _search.clear();
                              setState(() {});
                            },
                          ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                child: Wrap(
                  spacing: 8,
                  children: [
                    for (final f in _Filter.values)
                      ChoiceChip(
                        label: Text(switch (f) {
                          _Filter.all => 'All',
                          _Filter.sale => 'Sale',
                          _Filter.notConfig => 'Not configured',
                        }),
                        selected: _filter == f,
                        onSelected: (_) => setState(() => _filter = f),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: rows.isEmpty
                    ? const Center(child: Text('No products yet'))
                    : visible.isEmpty
                        ? const Center(child: Text('No match'))
                        : RefreshIndicator(
                            onRefresh: () =>
                                ref.refresh(productCatalogCombosProvider.future),
                            child: ListView.separated(
                              padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
                              itemCount: visible.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 12),
                              itemBuilder: (_, i) =>
                                  _CatalogRow(row: visible[i]),
                            ),
                          ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CatalogRow extends ConsumerWidget {
  const _CatalogRow({required this.row});

  final _Combo row;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = row.model?.name ?? row.name.name;
    final letter = title.isEmpty ? '?' : title[0].toUpperCase();
    final look = _lookOf(ref, row);
    final nameId = int.tryParse(row.name.id);
    final modelId = int.tryParse(row.model?.id ?? '');
    final offer = nameId == null || modelId == null
        ? null
        : ref
            .watch(productConfigProvider((nameId: nameId, modelId: modelId)))
            .valueOrNull
            ?.offerPrice;

    final onSale = look == _Look.onSale;
    final missing = look == _Look.notConfigured;

    return Card(
      color: onSale
          ? const Color(0xFFFDF2F8)
          : missing
              ? const Color(0xFFFFFBEB)
              : Colors.white,
      child: ListTile(
        isThreeLine: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: (onSale
                  ? const Color(0xFFBE185D)
                  : missing
                      ? const Color(0xFFB45309)
                      : AppTheme.primary)
              .withValues(alpha: 0.12),
          foregroundColor: onSale
              ? const Color(0xFFBE185D)
              : missing
                  ? const Color(0xFFB45309)
                  : AppTheme.primary,
          child: Text(letter, style: const TextStyle(fontWeight: FontWeight.w700)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(row.model == null ? 'No model yet' : row.name.name),
            const SizedBox(height: 6),
            Chip(
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: EdgeInsets.zero,
              labelPadding: const EdgeInsets.symmetric(horizontal: 8),
              side: BorderSide.none,
              backgroundColor: onSale
                  ? const Color(0xFFFCE7F3)
                  : missing
                      ? const Color(0xFFFDE68A)
                      : const Color(0xFFDCFCE7),
              label: Text(
                onSale
                    ? (offer == null ? 'On sale' : 'On sale · ₹$offer')
                    : missing
                        ? 'Not configured'
                        : 'Not on sale',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: onSale
                      ? const Color(0xFFBE185D)
                      : missing
                          ? const Color(0xFF92400E)
                          : AppTheme.primary,
                ),
              ),
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          if (row.model == null) {
            context.push(
              '/admin/add-product/model?productNameId=${row.name.id}',
            );
            return;
          }
          context.push(
            '/admin/add-product/configure'
            '?productNameId=${row.name.id}'
            '&productModelId=${row.model!.id}',
          );
        },
      ),
    );
  }
}
