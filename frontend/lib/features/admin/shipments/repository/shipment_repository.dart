import 'package:friends_battery_api/friends_battery_api.dart';

// ─── Domain models (UI-facing; not generated DTOs) ───────────────────────────

class SellerModel {
  final int id;
  final String userName;
  final String shopName;
  final String userNumber;

  SellerModel({
    required this.id,
    required this.userName,
    required this.shopName,
    required this.userNumber,
  });
}

class ShipmentSummaryModel {
  final int shipmentId;
  final String shipmentNumber;
  final String sellerName;
  final String shopName;
  final String status;
  final int totalProducts;
  final int totalQuantity;
  final DateTime createdAt;
  final DateTime? acceptedAt;

  ShipmentSummaryModel({
    required this.shipmentId,
    required this.shipmentNumber,
    required this.sellerName,
    required this.shopName,
    required this.status,
    required this.totalProducts,
    required this.totalQuantity,
    required this.createdAt,
    this.acceptedAt,
  });
}

class ShipmentItemDetailModel {
  final int id;
  final String category;
  final String productGroup;
  final String productName;
  final String productModel;
  final int quantity;
  final String? serialNumber;

  ShipmentItemDetailModel({
    required this.id,
    required this.category,
    required this.productGroup,
    required this.productName,
    required this.productModel,
    required this.quantity,
    this.serialNumber,
  });
}

class ShipmentDetailModel {
  final int shipmentId;
  final String shipmentNumber;
  final String status;
  final DateTime createdAt;
  final DateTime? acceptedAt;
  final int sellerId;
  final String sellerUserName;
  final String sellerShopName;
  final String? sellerPhone;
  final int totalProducts;
  final int totalQuantity;
  final List<ShipmentItemDetailModel> items;

  ShipmentDetailModel({
    required this.shipmentId,
    required this.shipmentNumber,
    required this.status,
    required this.createdAt,
    this.acceptedAt,
    required this.sellerId,
    required this.sellerUserName,
    required this.sellerShopName,
    this.sellerPhone,
    required this.totalProducts,
    required this.totalQuantity,
    required this.items,
  });
}

/// Result of admin → seller serial transfer (OpenAPI inventory rows).
class TransferResult {
  final int shipmentId;
  final String shipmentNumber;
  final int transferredUnits;
  final int sellerId;
  final List<TransferInventoryCount> inventory;

  TransferResult({
    required this.shipmentId,
    required this.shipmentNumber,
    required this.transferredUnits,
    required this.sellerId,
    required this.inventory,
  });
}

// ─── Repository (generated client only — no raw Dio) ─────────────────────────

class ShipmentRepository {
  final FriendsBatteryApi _api;

  ShipmentRepository({required FriendsBatteryApi api}) : _api = api;

  ShipmentsApi get _shipments => _api.getShipmentsApi();
  InventoryApi get _inventory => _api.getInventoryApi();
  ShopsApi get _shops => _api.getShopsApi();
  ProductsApi get _products => _api.getProductsApi();

  Future<List<ShipmentSummaryModel>> getShipments() async {
    final response = await _shipments.apiShipmentsGet();
    final data = response.data?.data;
    if (data == null) return [];

    return data.map((row) {
      final seller = row.seller;
      return ShipmentSummaryModel(
        shipmentId: row.shipmentId ?? 0,
        shipmentNumber: row.shipmentNumber ?? '',
        sellerName: seller?.userName ?? '',
        shopName: seller?.shopName ?? '',
        status: row.status ?? '',
        totalProducts: row.totalProducts ?? 0,
        totalQuantity: row.totalQuantity ?? 0,
        createdAt: DateTime.tryParse(row.createdAt ?? '') ?? DateTime.now(),
        acceptedAt: row.acceptedAt != null ? DateTime.tryParse(row.acceptedAt!) : null,
      );
    }).toList();
  }

  Future<ShipmentDetailModel> getShipmentById(int id) async {
    final response = await _shipments.apiShipmentsIdGet(id: id);
    final d = response.data?.data;
    if (d == null) {
      throw Exception('Shipment not found');
    }
    final seller = d.seller;
    final rawItems = d.items?.toList() ?? [];
    return ShipmentDetailModel(
      shipmentId: d.shipmentId ?? id,
      shipmentNumber: d.shipmentNumber ?? '',
      status: d.status ?? '',
      createdAt: DateTime.tryParse(d.createdAt ?? '') ?? DateTime.now(),
      acceptedAt: d.acceptedAt != null ? DateTime.tryParse(d.acceptedAt!) : null,
      sellerId: seller?.id ?? 0,
      sellerUserName: seller?.userName ?? '',
      sellerShopName: seller?.shopName ?? '',
      sellerPhone: seller?.userNumber,
      totalProducts: d.totalProducts ?? 0,
      totalQuantity: d.totalQuantity ?? 0,
      items: rawItems
          .map(
            (item) => ShipmentItemDetailModel(
              id: item.id ?? 0,
              category: item.category ?? '',
              productGroup: item.productGroup ?? '',
              productName: item.productName ?? '',
              productModel: item.productModel ?? '',
              quantity: item.quantity ?? 0,
              serialNumber: item.serialNumber,
            ),
          )
          .toList(),
    );
  }

  Future<List<SellerModel>> getSellers() async {
    final response = await _shops.apiShopsSellersGet();
    final list = response.data?.data;
    if (list == null) return [];
    return list
        .map(
          (s) => SellerModel(
            id: s.id ?? 0,
            userName: s.userName ?? '',
            shopName: s.shopName ?? '',
            userNumber: s.userNumber ?? '',
          ),
        )
        .toList();
  }

  /// Admin → seller serial transfer via generated client.
  Future<TransferResult> createShipment({
    required int sellerId,
    required List<CreateShipmentItem> items,
  }) async {
    final request = CreateShipmentRequest((b) {
      b.sellerId = sellerId;
      b.items.replace(items);
    });

    final response = await _shipments.apiShipmentsPost(
      createShipmentRequest: request,
    );
    final data = response.data?.data;
    if (data == null) {
      return TransferResult(
        shipmentId: 0,
        shipmentNumber: '',
        transferredUnits: 0,
        sellerId: sellerId,
        inventory: const [],
      );
    }

    return TransferResult(
      shipmentId: data.shipmentId ?? 0,
      shipmentNumber: data.shipmentNumber ?? '',
      transferredUnits: data.transferredUnits ?? 0,
      sellerId: data.sellerId ?? sellerId,
      inventory: data.inventory?.toList() ?? [],
    );
  }

  Future<List<String>> getAvailableSerials({
    required int productNameId,
    required int productModelId,
  }) async {
    final response = await _inventory.apiInventoryAvailableSerialsGet(
      productNameId: productNameId,
      productModelId: productModelId,
    );
    final data = response.data?.data;
    if (data == null) return [];
    return data.toList();
  }

  /// Seller accept legacy PENDING shipment.
  Future<void> acceptShipment(int shipmentId) async {
    await _shipments.apiShipmentsShipmentIdAcceptPost(shipmentId: shipmentId);
  }

  /// Products grouped by name for transfer form dropdowns.
  Future<List<InventoryProductNameGroup>> getInventoryProducts() async {
    final response = await _products.apiProductsInventoryProductsGet();
    return response.data?.data?.toList() ?? [];
  }
}
