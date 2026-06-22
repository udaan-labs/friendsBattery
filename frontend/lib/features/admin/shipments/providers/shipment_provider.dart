import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_client_provider.dart';
import '../repository/shipment_repository.dart';

final shipmentRepositoryProvider = Provider<ShipmentRepository>((ref) {
  final api = ref.watch(apiClientProvider);
  return ShipmentRepository(
    shopsApi: api.getShopsApi(),
    transfersApi: api.getTransfersApi(),
  );
});

final sellersProvider = FutureProvider<List<SellerModel>>((ref) async {
  final repo = ref.watch(shipmentRepositoryProvider);
  return repo.getSellers();
});

final shipmentsListProvider = FutureProvider<List<ShipmentSummaryModel>>((ref) async {
  final repo = ref.watch(shipmentRepositoryProvider);
  return repo.getShipments();
});
