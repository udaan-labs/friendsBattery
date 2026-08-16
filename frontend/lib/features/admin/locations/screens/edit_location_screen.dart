import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/utils/app_formatters.dart';
import '../providers/locations_providers.dart';
import '../widgets/edit_location_form.dart';

/// Edit shop or warehouse name and map pin.
class EditLocationScreen extends ConsumerWidget {
  const EditLocationScreen({super.key, required this.locationId});

  final int locationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(allLocationsProvider);
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Edit location',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(friendlyError(e), textAlign: TextAlign.center),
              TextButton(
                onPressed: () => ref.invalidate(allLocationsProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (rows) {
          final loc = rows.where((e) => e.id == locationId).firstOrNull;
          if (loc == null) {
            return const Center(child: Text('Location not found'));
          }
          return Center(
            child: EditLocationForm(locationId: locationId, location: loc),
          );
        },
      ),
    );
  }
}
