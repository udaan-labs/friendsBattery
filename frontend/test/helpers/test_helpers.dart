import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import 'package:frontend/theme/app_theme.dart';
import 'package:frontend/shared/providers/auth_provider.dart';
import 'package:frontend/features/seller/dashboard/providers/seller_dashboard_providers.dart';
import 'package:frontend/features/admin/dashboard/models/dashboard_stats.dart';
import 'package:frontend/features/admin/sellers/providers/sellers_provider.dart';
import 'package:frontend/features/admin/sellers/providers/seller_details_provider.dart';
import 'package:frontend/features/admin/sales/providers/admin_sales_history_provider.dart';
import 'package:frontend/features/admin/shipments/repository/shipment_repository.dart';
import 'package:frontend/features/shared/inventory/repository/shared_inventory_repository.dart';
import 'package:frontend/features/shared/inventory/providers/inventory_provider.dart';
import 'package:frontend/features/seller/sales/providers/seller_sales_provider.dart';

// ═══════════════════════════════════════════════════════════════════════════
// MOCK DATA FACTORIES
// ═══════════════════════════════════════════════════════════════════════════

AuthState mockAuthState({bool authenticated = false, UserRole role = UserRole.guest}) {
  return AuthState(isAuthenticated: authenticated, role: role);
}

SellerProfile mockSellerProfile() {
  return SellerProfile(
    userName: 'Rahul Sharma',
    shopName: 'EcoPower Solutions Hub',
    role: 'Premium Dealer',
  );
}

SellerKpiStats mockSellerKpiStats() {
  return SellerKpiStats(
    currentStock: 156,
    todaySalesAmount: 42500.0,
    todaySalesCount: 14,
    salesGrowthPercentage: 12.0,
    pendingShipments: 3,
  );
}

List<RecentInventoryItem> mockRecentInventoryItems() {
  return [
    RecentInventoryItem(name: 'UltraLife Max S3', serialNumber: 'SN: BATT-0921-XW', status: 'Available'),
    RecentInventoryItem(name: 'PowerVolt Core 5', serialNumber: 'SN: PVOLT-332-LM', status: 'Low Stock'),
  ];
}

List<SellerData> mockSellersList() {
  final user = User((b) => b
    ..id = '1'
    ..userName = 'TestSeller'
    ..shopName = 'Test Shop'
    ..userNumber = '9876543210'
    ..isVerified = true
    ..isActive = true);
  return [SellerData(seller: user, totalStock: 50, todaySales: 5, pendingShipments: 2)];
}

SellerDetailsData mockSellerDetails() {
  return SellerDetailsData({
    'shop_name': 'Test Shop',
    'user_name': 'TestSeller',
    'user_number': '9876543210',
    'is_active': true,
    'is_verified': true,
    'statistics': {'stock': 50, 'products': 10, 'sales': 100, 'returns': 2},
    'inventory': [
      {'product_name': 'Battery Ultra', 'model': 'X100', 'category': 'Automotive', 'quantity': 10, 'min_price': 1500.0},
    ],
  });
}

List<ShipmentSummaryModel> mockShipmentSummaries() {
  return [
    ShipmentSummaryModel(
      shipmentId: 1, shipmentNumber: 'SHP-001', sellerName: 'TestSeller',
      shopName: 'Test Shop', status: 'PENDING', totalProducts: 3, totalQuantity: 15,
      createdAt: DateTime.now(),
    ),
    ShipmentSummaryModel(
      shipmentId: 2, shipmentNumber: 'SHP-002', sellerName: 'AnotherSeller',
      shopName: 'Another Shop', status: 'ACCEPTED', totalProducts: 2, totalQuantity: 8,
      createdAt: DateTime.now(), acceptedAt: DateTime.now(),
    ),
  ];
}

ShipmentDetailModel mockShipmentDetail({int id = 1}) {
  return ShipmentDetailModel(
    shipmentId: id, shipmentNumber: 'SHP-00$id', status: 'PENDING',
    createdAt: DateTime.now(), sellerId: 1, sellerUserName: 'TestSeller',
    sellerShopName: 'Test Shop', sellerPhone: '9876543210',
    totalProducts: 2, totalQuantity: 10,
    items: [
      ShipmentItemDetailModel(id: 1, category: 'Automotive', productGroup: 'Batteries',
        productName: 'UltraLife', productModel: 'X100', quantity: 5, serialNumber: 'SN001'),
      ShipmentItemDetailModel(id: 2, category: 'Automotive', productGroup: 'Batteries',
        productName: 'PowerVolt', productModel: 'P200', quantity: 5),
    ],
  );
}

DashboardStats mockDashboardStats() {
  return DashboardStats(totalStock: 500, todaySales: 8, pendingRequests: 2, totalSellers: 5, pendingShipments: 3);
}

List<Map<String, dynamic>> mockRecentActivity() {
  return [{'title': 'New sale recorded', 'subtitle': 'Battery X100 sold', 'time': '2m ago', 'icon': 'payments'}];
}

PaginatedInventoryResponse mockInventoryResponse() {
  return PaginatedInventoryResponse(
    items: [
      SharedInventoryItemModel(productGroup: 'Automotive', category: 'Batteries',
        productModel: 'X100', productName: 'UltraLife', quantity: 50, minPrice: 1500.0, minStock: 5),
      SharedInventoryItemModel(productGroup: 'Industrial', category: 'Power Cells',
        productModel: 'P200', productName: 'PowerVolt', quantity: 30, minPrice: 2500.0, minStock: 10),
    ],
    total: 2,
  );
}

ApiSellerShipmentsGet200ResponseDataInner mockApiShipment() {
  return ApiSellerShipmentsGet200ResponseDataInner((b) => b
    ..shipmentId = 1
    ..shipmentNumber = 'SHP-001'
    ..status = 'PENDING'
    ..items.replace([]));
}

AdminSalesHistoryState mockAdminSalesState({bool loading = false, bool error = false, bool empty = true}) {
  if (loading) return const AdminSalesHistoryState(isLoading: true);
  if (error) return const AdminSalesHistoryState(isLoading: false, error: 'Test error');
  return AdminSalesHistoryState(sales: [], isLoading: false, total: 0);
}

// ═══════════════════════════════════════════════════════════════════════════
// TEST GO ROUTER
// ═══════════════════════════════════════════════════════════════════════════

final testRootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createTestRouter(Widget child) {
  return GoRouter(
    navigatorKey: testRootNavigatorKey,
    initialLocation: '/test',
    routes: [
      GoRoute(path: '/test', builder: (context, state) => child),
      GoRoute(path: '/login', builder: (context, state) => const SizedBox()),
      GoRoute(path: '/register', builder: (context, state) => const SizedBox()),
      GoRoute(path: '/admin/dashboard', builder: (context, state) => const SizedBox()),
      GoRoute(path: '/seller/dashboard', builder: (context, state) => const SizedBox()),
      GoRoute(path: '/admin/sellers', builder: (context, state) => const SizedBox()),
      GoRoute(path: '/admin/shipments', builder: (context, state) => const SizedBox()),
      GoRoute(path: '/admin/shipments/create', builder: (context, state) => const SizedBox()),
      GoRoute(path: '/admin/shipments/:id', builder: (context, state) => const SizedBox()),
      GoRoute(path: '/admin/sellers/:id', builder: (context, state) => const SizedBox()),
      GoRoute(path: '/admin/inventory', builder: (context, state) => const SizedBox()),
      GoRoute(path: '/admin/sales', builder: (context, state) => const SizedBox()),
      GoRoute(path: '/admin/add-stock', builder: (context, state) => const SizedBox()),
      GoRoute(path: '/seller/inventory', builder: (context, state) => const SizedBox()),
      GoRoute(path: '/seller/create-bill', builder: (context, state) => const SizedBox()),
      GoRoute(path: '/seller/received-shipments', builder: (context, state) => const SizedBox()),
      GoRoute(path: '/seller/sales-history', builder: (context, state) => const SizedBox()),
      GoRoute(path: '/seller/return-product', builder: (context, state) => const SizedBox()),
      GoRoute(path: '/seller/shipments/:shipmentId', builder: (context, state) => const SizedBox()),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// APP WRAPPERS
// ═══════════════════════════════════════════════════════════════════════════

Widget createTestApp(
  Widget widget, {
  List<Override> overrides = const [],
}) {
  return ProviderScope(
    overrides: overrides,
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: MediaQuery(
        data: const MediaQueryData(size: Size(400, 800)),
        child: MaterialApp.router(
          title: 'Test',
          theme: AppTheme.themeData,
          routerConfig: createTestRouter(widget),
        ),
      ),
    ),
  );
}

Widget createStandaloneTestApp(
  Widget widget, {
  List<Override> overrides = const [],
}) {
  return ProviderScope(
    overrides: overrides,
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: MediaQuery(
        data: const MediaQueryData(size: Size(400, 800)),
        child: MaterialApp(
          theme: AppTheme.themeData,
          home: widget,
        ),
      ),
    ),
  );
}
