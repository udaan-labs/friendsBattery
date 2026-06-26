import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_client_provider.dart';
import '../repository/shipment_repository.dart';

// ─── Repository provider ─────────────────────────────────────────────────────

final shipmentRepositoryProvider = Provider<ShipmentRepository>((ref) {
  final api = ref.watch(apiClientProvider);
  return ShipmentRepository(dio: api.dio);
});

// ─── Admin: list all shipments ────────────────────────────────────────────────

final shipmentsListProvider =
    FutureProvider<List<ShipmentSummaryModel>>((ref) async {
  final repo = ref.watch(shipmentRepositoryProvider);
  return repo.getShipments();
});

// ─── Admin/Seller: shipment detail by ID ─────────────────────────────────────

final shipmentDetailByIdProvider =
    FutureProvider.family<ShipmentDetailModel, int>((ref, id) async {
  final repo = ref.watch(shipmentRepositoryProvider);
  return repo.getShipmentById(id);
});

// ─── Sellers list (for create shipment screen) ────────────────────────────────

final sellersProvider = FutureProvider<List<SellerModel>>((ref) async {
  final repo = ref.watch(shipmentRepositoryProvider);
  return repo.getSellers();
});
