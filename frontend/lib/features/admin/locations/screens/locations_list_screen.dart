import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/providers/auth_provider.dart';
import '../../../../shared/utils/app_formatters.dart';
import '../../../../theme/app_theme.dart';
import '../providers/locations_providers.dart';

/// Locations list. SA: shops + warehouses. Shop Admin: own shop only (API-scoped).
class LocationsListScreen extends ConsumerStatefulWidget {
  const LocationsListScreen({super.key});

  @override
  ConsumerState<LocationsListScreen> createState() =>
      _LocationsListScreenState();
}

class _LocationsListScreenState extends ConsumerState<LocationsListScreen> {
  final _searchController = TextEditingController();
  String _query = '';
  /// `null` = all, else `SHOP` / `WAREHOUSE`
  String? _typeFilter;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<LocationItem> _filter(List<LocationItem> rows) {
    var list = rows;
    if (_typeFilter != null) {
      list = list
          .where((e) => e.type?.name == _typeFilter)
          .toList(growable: false);
    }
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return list;
    return list.where((e) {
      final hay = [
        e.name,
        e.code,
        e.address,
        e.phone,
        e.type?.name,
      ].whereType<String>().join(' ').toLowerCase();
      return hay.contains(q);
    }).toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    final isSuperAdmin = ref.watch(authProvider).role == UserRole.superAdmin;
    final async = ref.watch(allLocationsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/admin/dashboard');
            }
          },
        ),
        title: Text(
          isSuperAdmin ? 'Locations' : 'My shop',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final created = await context.push<bool>('/admin/locations/add');
          if (created == true) {
            ref.invalidate(allLocationsProvider);
            ref.invalidate(locationsByTypeProvider);
          }
        },
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Add location'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: TextField(
              controller: _searchController,
              onChanged: (v) => setState(() => _query = v),
              decoration: InputDecoration(
                hintText: 'Search shop or warehouse…',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _query.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _query = '');
                        },
                      ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          if (isSuperAdmin) ...[
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _TypeChip(
                    label: 'All',
                    selected: _typeFilter == null,
                    onTap: () => setState(() => _typeFilter = null),
                  ),
                  const SizedBox(width: 8),
                  _TypeChip(
                    label: 'Shops',
                    selected: _typeFilter == 'SHOP',
                    onTap: () => setState(() => _typeFilter = 'SHOP'),
                  ),
                  const SizedBox(width: 8),
                  _TypeChip(
                    label: 'Warehouses',
                    selected: _typeFilter == 'WAREHOUSE',
                    onTap: () => setState(() => _typeFilter = 'WAREHOUSE'),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 8),
          Expanded(
            child: async.when(
              data: (rows) {
                final filtered = _filter(rows);
                if (rows.isEmpty) {
                  return _EmptyState(
                    title: isSuperAdmin ? 'No locations yet' : 'No shop yet',
                    subtitle: isSuperAdmin
                        ? 'Add a shop or warehouse. Same form — pick the type.'
                        : 'Add your shop to get started.',
                  );
                }
                if (filtered.isEmpty) {
                  return const _EmptyState(
                    title: 'No matches',
                    subtitle: 'Try another search or filter.',
                  );
                }
                return RefreshIndicator(
                  onRefresh: () =>
                      ref.refresh(allLocationsProvider.future),
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, i) =>
                        _LocationCard(item: filtered[i]),
                  ),
                );
              },
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        friendlyError(e),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: () =>
                            ref.invalidate(allLocationsProvider),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TypeChip extends StatelessWidget {
  const _TypeChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      selectedColor: AppTheme.primary.withValues(alpha: 0.15),
      checkmarkColor: AppTheme.primary,
      labelStyle: TextStyle(
        fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
        color: selected ? AppTheme.primary : const Color(0xFF64748B),
        fontSize: 13,
      ),
      side: BorderSide(
        color: selected ? AppTheme.primary : const Color(0xFFE2E8F0),
      ),
      backgroundColor: Colors.white,
      showCheckmark: false,
      visualDensity: VisualDensity.compact,
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_city_outlined,
              size: 56,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color(0xFF64748B)),
            ),
          ],
        ),
      ),
    );
  }
}

class _LocationCard extends StatelessWidget {
  const _LocationCard({required this.item});

  final LocationItem item;

  void _openDetail(BuildContext context) {
    final id = item.id;
    if (id == null) return;
    final name = item.name;
    context.push(
      Uri(
        path: '/admin/locations/$id',
        queryParameters: {
          if (name != null && name.isNotEmpty) 'name': name,
        },
      ).toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isShop = item.type == LocationItemTypeEnum.SHOP;
    final accent =
        isShop ? const Color(0xFF006B2C) : const Color(0xFF2563EB);
    final typeLabel = isShop ? 'Shop' : 'Warehouse';
    final hasGps = item.latitude != null && item.longitude != null;
    final meta = [
      if (item.code != null) item.code!,
      if (item.address != null && item.address!.isNotEmpty) item.address!,
      if (item.phone != null && item.phone!.isNotEmpty) item.phone!,
    ].join(' · ');

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () => _openDetail(context),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: accent.withValues(alpha: 0.12),
                child: Icon(
                  isShop ? Icons.storefront_rounded : Icons.warehouse_rounded,
                  color: accent,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            item.name ?? 'Unnamed',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: accent.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            typeLabel,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: accent,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (meta.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        meta,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF64748B),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      hasGps
                          ? 'GPS set · ${item.allowedRadius ?? 100}m radius'
                          : 'GPS not set',
                      style: TextStyle(
                        fontSize: 11,
                        color: hasGps
                            ? const Color(0xFF006B2C)
                            : const Color(0xFFB45309),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey.shade400),
            ],
          ),
        ),
      ),
    );
  }
}
