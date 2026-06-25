import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import '../../../../shared/providers/auth_provider.dart';
import '../../../../shared/widgets/common_pull_to_refresh.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_client_provider.dart';
import '../../../../core/storage/local_storage.dart';
import '../../../../shared/widgets/snackbar_helper.dart';
import '../../../../shared/widgets/logout_dialog_helper.dart';
import '../providers/dashboard_controller.dart';
import '../widgets/kpi_grid.dart';
import '../widgets/low_stock_alerts.dart';
import '../widgets/quick_actions.dart';
import '../widgets/recent_activity_timeline.dart';
import '../../inventory/screens/add_product_screen.dart';

class AdminDashboardScreen extends ConsumerStatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  ConsumerState<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends ConsumerState<AdminDashboardScreen> {
  String _currentTab = 'dashboard';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // View Stock tab state variables
  int _stockPage = 1;
  final int _stockLimit = 10;
  int _stockTotalPages = 1;
  String _stockSearchQuery = '';
  bool _isLoadingStock = false;
  List<Map<String, dynamic>> _flatStockItems = [];

  // Manage Sellers tab state variables
  bool _isLoadingSellers = false;
  List<dynamic> _sellers = [];

  // Add Product tab state variables
  final _addStockFormKey = GlobalKey<FormState>();
  final _quantityController = TextEditingController();
  final _minPriceController = TextEditingController();
  bool _isLoadingCategories = false;
  bool _isLoadingNames = false;
  bool _isLoadingModels = false;
  bool _isLoadingDetails = false;
  bool _isSubmittingStock = false;

  List<Map<String, String>> _categories = [];
  List<Map<String, String>> _productNames = [];
  List<Map<String, String>> _productModels = [];

  String? _selectedCategoryId;
  String? _selectedProductNameId;
  String? _selectedProductModelId;

  int? _currentDetailsStock;
  num? _currentMinPrice;

  @override
  void initState() {
    super.initState();
    // Pre-load data based on default view
    ref.read(dashboardControllerProvider).refreshAllData();
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _minPriceController.dispose();
    super.dispose();
  }

  void _switchTab(String tabId) {
    setState(() {
      _currentTab = tabId;
    });
    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      context.pop(); // Close drawer
    }

    if (tabId == 'dashboard') {
      ref.read(dashboardControllerProvider).refreshAllData();
    } else if (tabId == 'manage_sellers') {
      _fetchSellers();
    } else if (tabId == 'add_product') {
      _loadCategories();
    }
  }

  // --- API Methods for View Stock ---
  Future<void> _fetchStock(int page) async {
    setState(() {
      _stockPage = page;
      _isLoadingStock = true;
      _flatStockItems = [];
    });

    try {
      final api = ref.read(apiClientProvider).getInventoryApi();
      final response = await api.apiInventoryDetailsGet(
        page: _stockPage,
        limit: _stockLimit,
        search: _stockSearchQuery.isNotEmpty ? _stockSearchQuery : null,
      );

      final details = response.data?.data;
      if (details != null) {
        final categories = details.categories;
        final pagination = details.pagination;
        
        setState(() {
          _stockTotalPages = pagination?.totalPages ?? 1;
        });

        List<Map<String, dynamic>> items = [];
        if (categories != null) {
          for (var cat in categories) {
            final subcats = cat.subcategories;
            if (subcats != null) {
              for (var sub in subcats) {
                final prods = sub.products;
                if (prods != null) {
                  for (var prod in prods) {
                    items.add({
                      'category': cat.categoryName ?? '',
                      'subcategory': sub.subcategoryName ?? '',
                      'productName': prod.productName ?? '',
                      'total': prod.totalQuantity ?? 0,
                      'sold': prod.soldQuantity ?? 0,
                      'remaining': prod.remainingQuantity ?? 0,
                    });
                  }
                }
              }
            }
          }
        }

        setState(() {
          _flatStockItems = items;
        });
      }
    } catch (e) {
      if (mounted) {
        context.showErrorSnackBar('Failed to retrieve inventory details');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingStock = false;
        });
      }
    }
  }

  // --- API Methods for Manage Sellers ---
  Future<void> _fetchSellers() async {
    setState(() {
      _isLoadingSellers = true;
      _sellers = [];
    });

    try {
      final dio = ApiClient().dio;
      final response = await dio.get('/api/users?role=SELLER');
      final body = response.data;
      if (body != null && body['success'] == true && body['data'] is List) {
        setState(() {
          _sellers = body['data'] as List;
        });
      }
    } catch (e) {
      if (mounted) {
        context.showErrorSnackBar('Failed to retrieve registered sellers');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingSellers = false;
        });
      }
    }
  }

  Future<void> _updateSellerState(String sellerId, bool isActive, bool isVerified) async {
    try {
      final dio = ApiClient().dio;
      final response = await dio.put('/api/auth/activate', data: {
        'user_id': sellerId,
        'is_active': isActive,
        'is_verified': isVerified,
      });

      final body = response.data;
      if (body != null && body['success'] == true) {
        if (mounted) {
          context.showSuccessSnackBar('Seller status updated successfully');
        }
        _fetchSellers();
      } else {
        if (mounted) {
          context.showErrorSnackBar(body['message'] ?? 'Action failed');
        }
      }
    } catch (e) {
      if (mounted) {
        context.showErrorSnackBar('Connection or transaction error');
      }
    }
  }

  // --- API Methods for Add Product Form ---
  Future<void> _loadCategories() async {
    setState(() {
      _isLoadingCategories = true;
      _categories = [];
      _selectedCategoryId = null;
      _productNames = [];
      _selectedProductNameId = null;
      _productModels = [];
      _selectedProductModelId = null;
      _currentDetailsStock = null;
      _currentMinPrice = null;
    });
    try {
      final api = ref.read(apiClientProvider).getProductsApi();
      final response = await api.apiProductsCategoriesGet();
      final data = (response as dynamic).data;
      if (data is Map<String, dynamic> && data['data'] is List) {
        final list = data['data'] as List;
        setState(() {
          _categories = list.map((item) {
            return {
              'id': item['id'].toString(),
              'name': item['name'].toString(),
            };
          }).toList();
        });
      }
    } catch (e) {
      // Ignored
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingCategories = false;
        });
      }
    }
  }

  Future<void> _loadProductNames(String categoryId) async {
    setState(() {
      _isLoadingNames = true;
      _productNames = [];
      _selectedProductNameId = null;
      _productModels = [];
      _selectedProductModelId = null;
      _currentDetailsStock = null;
      _currentMinPrice = null;
    });

    try {
      final api = ref.read(apiClientProvider).getProductsApi();
      final request = ApiProductsProductNamesListPostRequest((b) => b..categoryId = int.parse(categoryId));
      final response = await api.apiProductsProductNamesListPost(
        apiProductsProductNamesListPostRequest: request,
      );
      final data = (response as dynamic).data;
      if (data is Map<String, dynamic> && data['data'] is List) {
        final list = data['data'] as List;
        setState(() {
          _productNames = list.map((item) {
            return {
              'id': item['id'].toString(),
              'name': item['name'].toString(),
            };
          }).toList();
        });
      }
    } catch (e) {
      // Ignored
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingNames = false;
        });
      }
    }
  }

  Future<void> _loadProductModels(String productNameId) async {
    setState(() {
      _isLoadingModels = true;
      _productModels = [];
      _selectedProductModelId = null;
      _currentDetailsStock = null;
      _currentMinPrice = null;
    });

    try {
      final api = ref.read(apiClientProvider).getProductsApi();
      final request = ApiProductsProductModelsListPostRequest((b) => b
        ..categoryId = int.parse(_selectedCategoryId!)
        ..productNameId = int.parse(productNameId));
      final response = await api.apiProductsProductModelsListPost(
        apiProductsProductModelsListPostRequest: request,
      );
      final data = (response as dynamic).data;
      if (data is Map<String, dynamic> && data['data'] is List) {
        final list = data['data'] as List;
        setState(() {
          _productModels = list.map((item) {
            return {
              'id': item['id'].toString(),
              'name': item['name'].toString(),
            };
          }).toList();
        });
      }
    } catch (e) {
      // Ignored
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingModels = false;
        });
      }
    }
  }

  Future<void> _loadProductDetails(String productModelId) async {
    setState(() {
      _isLoadingDetails = true;
      _currentDetailsStock = null;
      _currentMinPrice = null;
    });

    try {
      final api = ref.read(apiClientProvider).getInventoryApi();
      final response = await api.apiInventoryProductDetailsGet(
        categoryId: _selectedCategoryId!,
        productNameId: _selectedProductNameId!,
        productModelId: productModelId,
      );

      final details = response.data?.data;
      if (details != null) {
        setState(() {
          _currentDetailsStock = details.currentStock ?? 0;
          _currentMinPrice = details.minSellPrice ?? 0;
        });
      }
    } catch (e) {
      // Ignored
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingDetails = false;
        });
      }
    }
  }

  Future<void> _submitStockUpdate() async {
    if (!_addStockFormKey.currentState!.validate()) return;
    if (_selectedCategoryId == null || _selectedProductNameId == null || _selectedProductModelId == null) {
      context.showErrorSnackBar('Please select all product fields');
      return;
    }

    setState(() {
      _isSubmittingStock = true;
    });

    try {
      final api = ref.read(apiClientProvider).getInventoryApi();
      final quantity = int.parse(_quantityController.text);
      final minPrice = _minPriceController.text.isNotEmpty ? num.parse(_minPriceController.text) : null;

      final request = ApiInventoryUpdateStockPostRequest((b) => b
        ..productCategoryId = int.parse(_selectedCategoryId!)
        ..productNameId = int.parse(_selectedProductNameId!)
        ..productModelId = int.parse(_selectedProductModelId!)
        ..quantity = quantity
        ..minSellPrice = minPrice);

      await api.apiInventoryUpdateStockPost(
        apiInventoryUpdateStockPostRequest: request,
      );

      if (mounted) {
        context.showSuccessSnackBar('Stock level updated successfully');
        _quantityController.clear();
        _minPriceController.clear();
        _switchTab('view_stock');
      }
    } catch (e) {
      // Ignored
    } finally {
      if (mounted) {
        setState(() {
          _isSubmittingStock = false;
        });
      }
    }
  }


  String _getInitials(String name) {
    if (name.isEmpty) return 'AD';
    final parts = name.trim().split(' ').where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return 'AD';
    if (parts.length == 1) {
      final word = parts[0];
      return word.length >= 2 ? word.substring(0, 2).toUpperCase() : word.toUpperCase();
    }
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }

  String _getUserNameSafe() {
    try {
      final user = LocalStorage.get('user');
      if (user != null) {
        try {
          return (user as dynamic).userName ?? (user as dynamic).username ?? 'Administrator';
        } catch (_) {
          if (user is Map) {
            return (user['userName'] ?? user['username'] ?? 'Administrator').toString();
          }
        }
      }
    } catch (_) {}
    return 'Administrator';
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 1024;
    final username = _getUserNameSafe();

    return PopScope(
      canPop: _currentTab == 'dashboard',
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          _switchTab('dashboard');
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
      backgroundColor: const Color(0xFFF7F9FB), // bg-background
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF), // White to match image
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Color(0xFF191C1E)), // Dark menu icon
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: const Text(
          'BatteryPro',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF006B2C), // text-primary
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF3E4A3D), size: 28),
            onPressed: () {},
          ),
          IconButton(
            icon: const Badge(
              label: Text('3'),
              backgroundColor: Color(0xFFBA1A1A), // red
              child: Icon(Icons.notifications_none_outlined, color: Color(0xFF3E4A3D), size: 28),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Color(0xFF3E4A3D), size: 28),
            onPressed: () {
              showLogoutConfirmationDialog(context, ref);
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFFF7F9FB), // bg-surface
        child: Column(
          children: [
            // Drawer Header
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 24,
                bottom: 24,
                left: 16,
                right: 16,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFFECEEF0), // bg-surface-container
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: const Color(0xFFD5E0F8), // bg-secondary-container
                    foregroundColor: const Color(0xFF111C2D), // text-on-secondary-fixed
                    child: Text(
                      _getInitials(username),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          username,
                          style: const TextStyle(
                            color: Color(0xFF191C1E), // text-on-surface
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'System Administrator',
                          style: TextStyle(color: Color(0xFF3E4A3D), fontSize: 13), // text-on-surface-variant
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0E3E5), // bg-surface-container-highest
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: const Text(
                            'Fleet Manager v1.0.4',
                            style: TextStyle(color: Color(0xFF3E4A3D), fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Navigation List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  _buildDrawerItem(
                    icon: Icons.dashboard_outlined,
                    activeIcon: Icons.dashboard,
                    title: 'Dashboard',
                    tabId: 'dashboard',
                  ),
                  _buildDrawerItem(
                    icon: Icons.add_box_outlined,
                    activeIcon: Icons.add_box,
                    title: 'Add Product',
                    tabId: 'add_product',
                  ),
                  _buildDrawerItem(
                    icon: Icons.inventory_2_outlined,
                    activeIcon: Icons.inventory_2,
                    title: 'View Stock',
                    tabId: 'view_stock',
                    onTap: () {
                      context.pop(); // close drawer
                      context.push('/shared/inventory');
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.people_outline,
                    activeIcon: Icons.people,
                    title: 'Manage Sellers',
                    tabId: 'manage_sellers',
                  ),
                  _buildDrawerItem(
                    icon: Icons.point_of_sale_outlined,
                    activeIcon: Icons.point_of_sale,
                    title: 'Sales',
                    tabId: 'sales',
                  ),
                  _buildDrawerItem(
                    icon: Icons.swap_horiz_outlined,
                    activeIcon: Icons.swap_horiz,
                    title: 'Stock Transfer',
                    tabId: 'stock_transfer',
                  ),
                  _buildDrawerItem(
                    icon: Icons.assessment_outlined,
                    activeIcon: Icons.assessment,
                    title: 'Reports',
                    tabId: 'reports',
                  ),
                  _buildDrawerItem(
                    icon: Icons.settings_outlined,
                    activeIcon: Icons.settings,
                    title: 'Settings',
                    tabId: 'settings',
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // Drawer Footer
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListTile(
                leading: const Icon(Icons.logout, color: Color(0xFFBA1A1A)), // text-error
                title: const Text(
                  'Logout',
                  style: TextStyle(color: Color(0xFFBA1A1A), fontWeight: FontWeight.bold),
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
                onTap: () {
                  context.pop(); // close drawer
                  showLogoutConfirmationDialog(context, ref);
                },
              ),
            ),
          ],
        ),
      ),
      body: _buildCurrentTabView(isDesktop),
      bottomNavigationBar: !isDesktop
          ? BottomNavigationBar(
              currentIndex: _getBottomNavIndex(),
              onTap: _onBottomNavTapped,
              type: BottomNavigationBarType.fixed,
              backgroundColor: const Color(0xFFECEEF0), // bg-surface-container
              selectedItemColor: const Color(0xFF006B2C),
              unselectedItemColor: const Color(0xFF586377),
              showUnselectedLabels: true,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
              unselectedLabelStyle: const TextStyle(fontSize: 10),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.grid_view_outlined),
                  activeIcon: Icon(Icons.grid_view_rounded),
                  label: 'Dashboard',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people_outline_rounded),
                  activeIcon: Icon(Icons.people_alt_rounded),
                  label: 'Sellers',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.inventory_2_outlined),
                  activeIcon: Icon(Icons.inventory_2_rounded),
                  label: 'Stock',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.warning_amber_rounded),
                  activeIcon: Icon(Icons.warning_rounded),
                  label: 'Alerts',
                ),
              ],
            )
          : null,
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required IconData activeIcon,
    required String title,
    required String tabId,
    VoidCallback? onTap,
  }) {
    final isActive = _currentTab == tabId;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: ListTile(
        leading: Icon(
          isActive ? activeIcon : icon,
          color: isActive ? const Color(0xFF111C2D) : const Color(0xFF3E4A3D),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            color: isActive ? const Color(0xFF111C2D) : const Color(0xFF3E4A3D),
            fontSize: 14,
          ),
        ),
        selected: isActive,
        selectedTileColor: const Color(0xFFD5E0F8), // bg-secondary-container
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
        onTap: onTap ?? () => _switchTab(tabId),
      ),
    );
  }

  int _getBottomNavIndex() {
    switch (_currentTab) {
      case 'dashboard':
        return 0;
      case 'manage_sellers':
        return 1;
      case 'view_stock':
        return 2;
      case 'sales':
      case 'stock_transfer':
      case 'reports':
      case 'settings':
      case 'add_product':
      default:
        return 3; // Mapped to Alerts/Placeholder
    }
  }

  void _onBottomNavTapped(int index) {
    switch (index) {
      case 0:
        _switchTab('dashboard');
        break;
      case 1:
        _switchTab('manage_sellers');
        break;
      case 2:
        context.push('/shared/inventory');
        break;
      case 3:
      default:
        _switchTab('sales'); // Placeholder Alert tab
        break;
    }
  }

  Widget _buildCurrentTabView(bool isDesktop) {
    switch (_currentTab) {
      case 'dashboard':
        return _buildDashboardTabView(isDesktop);
      case 'add_product':
        return _buildAddProductTabView();
      case 'view_stock':
        return _buildViewStockTabView();
      case 'manage_sellers':
        return _buildManageSellersTabView();
      case 'sales':
      case 'stock_transfer':
      case 'reports':
      case 'settings':
      default:
        return _buildPlaceholderTabView(_currentTab);
    }
  }

  // --- Sub-View: Bento Grid Dashboard ---
  Widget _buildDashboardTabView(bool isDesktop) {
    return CommonPullToRefresh(
      onRefresh: () => ref.read(dashboardControllerProvider).refreshAllData(),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              color: const Color(0xFFF7F9FB),
              width: double.infinity,
              child: const KpiGrid(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            sliver: SliverMainAxisGroup(
              slivers: [
                if (isDesktop)
                        SliverCrossAxisGroup(
                          slivers: [
                            SliverCrossAxisExpanded(
                              flex: 8,
                              sliver: SliverMainAxisGroup(
                                slivers: const [
                                  LowStockAlerts(),
                                  SliverToBoxAdapter(child: SizedBox(height: 32)),
                                  RecentActivityTimeline(),
                                ],
                              ),
                            ),
                            const SliverCrossAxisExpanded(
                              flex: 1,
                              sliver: SliverToBoxAdapter(child: SizedBox.shrink()),
                            ),
                            SliverCrossAxisExpanded(
                              flex: 4,
                              sliver: SliverMainAxisGroup(
                                slivers: const [
                                  QuickActions(),
                                ],
                              ),
                            ),
                          ],
                        )
                      else
                        SliverMainAxisGroup(
                          slivers: const [
                            LowStockAlerts(),
                            SliverToBoxAdapter(child: SizedBox(height: 24)),
                            QuickActions(),
                            SliverToBoxAdapter(child: SizedBox(height: 24)),
                            RecentActivityTimeline(),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  // --- Sub-View: Add Product Form ---
  Widget _buildAddProductTabView() {
    return const AddProductScreen();
  }
  // --- Sub-View: View Stock (Paginated Table) ---
  Widget _buildViewStockTabView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header filters row
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search, color: Color(0xFF3E4A3D)),
                    hintText: 'Search product model...',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(999)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  onChanged: (val) {
                    setState(() {
                      _stockSearchQuery = val;
                    });
                    _fetchStock(1);
                  },
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.refresh, color: Color(0xFF006B2C)),
                onPressed: () => _fetchStock(1),
              ),
            ],
          ),
        ),
        // Stock Items List/Table
        Expanded(
          child: _isLoadingStock
              ? const Center(child: CircularProgressIndicator())
              : _flatStockItems.isEmpty
                  ? const Center(child: Text('No stock matches found.'))
                  : SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text('Category', style: TextStyle(fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Subcategory', style: TextStyle(fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Product Model', style: TextStyle(fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Total Qty', style: TextStyle(fontWeight: FontWeight.bold)), numeric: true),
                            DataColumn(label: Text('Sold Qty', style: TextStyle(fontWeight: FontWeight.bold)), numeric: true),
                            DataColumn(label: Text('Remaining Qty', style: TextStyle(fontWeight: FontWeight.bold)), numeric: true),
                          ],
                          rows: _flatStockItems.map((item) {
                            return DataRow(cells: [
                              DataCell(Text(item['category'])),
                              DataCell(Text(item['subcategory'])),
                              DataCell(Text(item['productName'], style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF006B2C)))),
                              DataCell(Text(item['total'].toString())),
                              DataCell(Text(item['sold'].toString())),
                              DataCell(Text(item['remaining'].toString(), style: const TextStyle(fontWeight: FontWeight.bold))),
                            ]);
                          }).toList(),
                        ),
                      ),
                    ),
        ),
        // Pagination Toolbar
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Page $_stockPage of $_stockTotalPages', style: const TextStyle(color: Color(0xFF3E4A3D))),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _stockPage <= 1 ? null : () => _fetchStock(_stockPage - 1),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(0, 48),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
                    ),
                    child: const Text('Previous'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _stockPage >= _stockTotalPages ? null : () => _fetchStock(_stockPage + 1),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(0, 48),
                      backgroundColor: const Color(0xFF006B2C),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
                    ),
                    child: const Text('Next'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- Sub-View: Manage Sellers ---
  Widget _buildManageSellersTabView() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Sellers Administration', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF006B2C))),
              IconButton(icon: const Icon(Icons.refresh), onPressed: _fetchSellers),
            ],
          ),
        ),
        Expanded(
          child: _isLoadingSellers
              ? const Center(child: CircularProgressIndicator())
              : _sellers.isEmpty
                  ? const Center(child: Text('No registered sellers.'))
                  : ListView.builder(
                      itemCount: _sellers.length,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemBuilder: (context, index) {
                        final seller = _sellers[index];
                        final sellerId = seller['userId'] ?? '';
                        final name = seller['userName'] ?? '';
                        final shop = seller['shopName'] ?? '-';
                        final phone = seller['userNumber'] ?? '-';
                        final isVerified = seller['isVerified'] ?? false;
                        final isActive = seller['isActive'] ?? false;

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF191C1E))),
                                    Text(sellerId, style: const TextStyle(fontFamily: 'monospace', fontSize: 12, color: Color(0xFF3E4A3D))),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text('Shop: $shop', style: const TextStyle(fontSize: 13, color: Color(0xFF3E4A3D))),
                                Text('Phone: $phone', style: const TextStyle(fontSize: 13, color: Color(0xFF3E4A3D))),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        // Verification status label
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: isVerified ? const Color(0xFFF7FFF2) : const Color(0xFFFFDAD6),
                                            borderRadius: BorderRadius.circular(999),
                                          ),
                                          child: Text(
                                            isVerified ? 'Verified' : 'Pending',
                                            style: TextStyle(
                                              color: isVerified ? const Color(0xFF005320) : const Color(0xFF93000a),
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        // Active status label
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: isActive ? const Color(0xFFF7FFF2) : const Color(0xFFECEEF0),
                                            borderRadius: BorderRadius.circular(999),
                                          ),
                                          child: Text(
                                            isActive ? 'Active' : 'Suspended',
                                            style: TextStyle(
                                              color: isActive ? const Color(0xFF006B2C) : const Color(0xFF3E4A3D),
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        if (!isVerified)
                                          ElevatedButton(
                                            onPressed: () => _updateSellerState(sellerId, true, true),
                                            style: ElevatedButton.styleFrom(
                                              minimumSize: const Size(0, 48),
                                              backgroundColor: const Color(0xFF006B2C),
                                              foregroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
                                            ),
                                            child: const Text('Verify'),
                                          )
                                        else
                                          ElevatedButton(
                                            onPressed: () => _updateSellerState(sellerId, !isActive, true),
                                            style: ElevatedButton.styleFrom(
                                              minimumSize: const Size(0, 48),
                                              backgroundColor: isActive ? const Color(0xFFBA1A1A) : const Color(0xFF006B2C),
                                              foregroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
                                            ),
                                            child: Text(isActive ? 'Suspend' : 'Activate'),
                                          ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
        ),
      ],
    );
  }

  // --- Sub-View: Placeholder View ---
  Widget _buildPlaceholderTabView(String tabId) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.all(32),
        constraints: const BoxConstraints(maxWidth: 400),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: Color(0x0A000000), blurRadius: 12, offset: Offset(0, 4)),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.construction, color: Color(0xFF006B2C), size: 64),
            const SizedBox(height: 16),
            Text(
              '${tabId[0].toUpperCase()}${tabId.substring(1).replaceAll('_', ' ')} Tab',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF191C1E)),
            ),
            const SizedBox(height: 8),
            const Text(
              'This module interface section is being configured. Check back soon for transactional integrations.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF3E4A3D), fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
