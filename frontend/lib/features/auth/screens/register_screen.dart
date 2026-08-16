import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_theme.dart';
import '../../../shared/utils/app_formatters.dart';
import '../../../shared/widgets/responsive_helper.dart';
import '../providers/auth_controller.dart';
import '../../../core/state/data_sync.dart';
import '../../../shared/widgets/snackbar_helper.dart';
import '../../admin/locations/providers/locations_providers.dart';

/// Admin Add Seller (`isAdminFlow: true`) or Super Admin Add Admin (`isCreateAdmin: true`).
/// Shop list: GET /api/shops/locations?type=SHOP
/// Seller: POST /api/auth/register · Admin: POST /api/auth/register-admin
class RegisterScreen extends ConsumerStatefulWidget {
  final bool isAdminFlow;
  /// Super Admin creates shop Admin (mutually exclusive with seller flow).
  final bool isCreateAdmin;

  const RegisterScreen({
    super.key,
    this.isAdminFlow = false,
    this.isCreateAdmin = false,
  });

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _userIdController = TextEditingController();
  final _usernameController = TextEditingController();
  final _userNumberController = TextEditingController();
  final _shopNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  int? _selectedShopLocationId;
  String? _mobileError;

  @override
  void dispose() {
    _userIdController.dispose();
    _usernameController.dispose();
    _userNumberController.dispose();
    _shopNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    final number = _userNumberController.text.trim();
    if (!RegExp(r'^\d{10}$').hasMatch(number)) {
      setState(() {
        _mobileError = 'Mobile number must be exactly 10 digits';
      });
      context.showErrorSnackBar('Mobile number must be exactly 10 digits');
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      context.showErrorSnackBar('Passwords do not match');
      return;
    }

    final needsShop = widget.isAdminFlow || widget.isCreateAdmin;
    if (needsShop && _selectedShopLocationId == null) {
      context.showErrorSnackBar(
        widget.isCreateAdmin
            ? 'Select a shop or warehouse for this admin'
            : 'Select a shop for this seller',
      );
      return;
    }

    if (needsShop && _shopNameController.text.trim().isEmpty) {
      context.showErrorSnackBar('Shop name is required');
      return;
    }

    try {
      final notifier = ref.read(authControllerProvider.notifier);
      if (widget.isCreateAdmin) {
        await notifier.registerAdmin(
          userId: _userIdController.text.trim(),
          username: _usernameController.text.trim(),
          userNumber: number,
          shopName: _shopNameController.text.trim(),
          password: _passwordController.text,
          locationId: _selectedShopLocationId,
        );
      } else {
        await notifier.register(
          userId: _userIdController.text.trim(),
          username: _usernameController.text.trim(),
          userNumber: number,
          shopName: _shopNameController.text.trim(),
          password: _passwordController.text,
          locationId: widget.isAdminFlow ? _selectedShopLocationId : null,
        );
      }

      if (mounted) {
        context.showSuccessSnackBar(
          widget.isCreateAdmin
              ? 'Admin created for that location and can log in immediately.'
              : widget.isAdminFlow
                  ? 'Seller created at selected shop (inactive until activated).'
                  : 'Registration successful.',
        );
        if (widget.isAdminFlow) {
          DataSync.afterSellerMutation(ref);
        }
        context.pop();
      }
    } catch (_) {
      // Errors are handled automatically by ApiInterceptor
    }
  }

  void _selectShop(int? id, List<LocationItem> shops) {
    if (id == null) {
      setState(() => _selectedShopLocationId = null);
      return;
    }
    LocationItem? shop;
    for (final s in shops) {
      if (s.id == id) {
        shop = s;
        break;
      }
    }
    setState(() {
      _selectedShopLocationId = id;
      if (shop != null) {
        _shopNameController.text = shop.name ?? shop.code ?? '';
      }
    });
  }

  Future<void> _goCreateLocation() async {
    await context.push(
      widget.isCreateAdmin
          ? '/admin/locations/add'
          : '/admin/locations/add?type=SHOP',
    );
    ref.invalidate(locationsByTypeProvider('SHOP'));
    ref.invalidate(allLocationsProvider);
  }

  String _locationLabel(LocationItem s) {
    final name = s.name ?? s.code ?? 'Location';
    if (s.code != null && s.code!.isNotEmpty && s.name != null) {
      return '$name · ${s.code}';
    }
    return name;
  }

  Widget _adminLocationField(bool formLoading, List<LocationItem> locations) {
    LocationItem? selected;
    for (final s in locations) {
      if (s.id == _selectedShopLocationId) {
        selected = s;
        break;
      }
    }
    final isWh = selected?.type == LocationItemTypeEnum.WAREHOUSE;
    final label = selected == null
        ? 'Tap to choose shop or warehouse'
        : '${isWh ? 'Warehouse' : 'Shop'} · ${_locationLabel(selected)}';

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: formLoading ? null : () => _openAdminLocationPicker(locations),
        borderRadius: BorderRadius.circular(8),
        child: InputDecorator(
          decoration: const InputDecoration(
            labelText: 'Location *',
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Icon(Icons.place),
            suffixIcon: Icon(Icons.unfold_more),
          ),
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: selected == null
                  ? AppTheme.textSecondary
                  : AppTheme.textPrimary,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openAdminLocationPicker(List<LocationItem> locations) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (ctx) {
        var query = '';
        return StatefulBuilder(
          builder: (ctx, setSheet) {
            final q = query.trim().toLowerCase();
            bool matches(LocationItem s) {
              if (q.isEmpty) return true;
              final name = (s.name ?? '').toLowerCase();
              final code = (s.code ?? '').toLowerCase();
              return name.contains(q) || code.contains(q);
            }

            final shops = [
              for (final s in locations)
                if (s.type != LocationItemTypeEnum.WAREHOUSE && matches(s)) s,
            ];
            final warehouses = [
              for (final s in locations)
                if (s.type == LocationItemTypeEnum.WAREHOUSE && matches(s)) s,
            ];

            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: MediaQuery.viewInsetsOf(ctx).bottom + 16,
              ),
              child: SizedBox(
                height: MediaQuery.sizeOf(ctx).height * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Choose location',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Shops and warehouses are listed separately.',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      autofocus: false,
                      decoration: const InputDecoration(
                        hintText: 'Search name or code',
                        prefixIcon: Icon(Icons.search),
                        filled: true,
                      ),
                      onChanged: (v) => setSheet(() => query = v),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView(
                        children: [
                          _locationSectionHeader(
                            Icons.storefront,
                            'Shops',
                            shops.length,
                          ),
                          if (shops.isEmpty)
                            const _EmptyLocationHint('No shops')
                          else
                            for (final s in shops) _locationTile(s, ctx),
                          const SizedBox(height: 8),
                          _locationSectionHeader(
                            Icons.warehouse_outlined,
                            'Warehouses',
                            warehouses.length,
                          ),
                          if (warehouses.isEmpty)
                            const _EmptyLocationHint('No warehouses')
                          else
                            for (final s in warehouses) _locationTile(s, ctx),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _locationSectionHeader(IconData icon, String title, int count) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppTheme.primary),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: AppTheme.primary,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$count',
            style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _locationTile(LocationItem s, BuildContext sheetContext) {
    final id = s.id;
    if (id == null) return const SizedBox.shrink();
    final selected = id == _selectedShopLocationId;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      leading: Icon(
        s.type == LocationItemTypeEnum.WAREHOUSE
            ? Icons.warehouse_outlined
            : Icons.storefront,
        color: selected ? AppTheme.primary : AppTheme.textSecondary,
      ),
      title: Text(
        s.name ?? s.code ?? 'Location',
        style: TextStyle(
          fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          color: AppTheme.textPrimary,
        ),
      ),
      subtitle: s.code != null && s.code!.isNotEmpty
          ? Text(s.code!, style: const TextStyle(color: AppTheme.textSecondary))
          : null,
      trailing: selected
          ? const Icon(Icons.check_circle, color: AppTheme.primary)
          : null,
      selected: selected,
      selectedTileColor: const Color(0xFFE8F5E9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onTap: () {
        _selectShop(id, [s]);
        Navigator.pop(sheetContext);
      },
    );
  }

  /// Shop picker for seller; shop + warehouse picker for create-admin.
  Widget _buildShopSection(bool formLoading) {
    final shopsAsync = widget.isCreateAdmin
        ? ref.watch(allLocationsProvider)
        : ref.watch(locationsByTypeProvider('SHOP'));
    final shopTitle = widget.isCreateAdmin
        ? 'Select shop or warehouse'
        : 'Select shop for this seller';
    final shopHint = widget.isCreateAdmin
        ? 'Required. One admin per location.'
        : 'Required. One seller per shop.';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.primary, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(Icons.storefront, color: AppTheme.primary, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  shopTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: AppTheme.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            shopHint,
            style: const TextStyle(fontSize: 12, color: Color(0xFF545F73)),
          ),
          const SizedBox(height: 12),
          shopsAsync.when(
            data: (shops) {
              if (shops.isEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.isCreateAdmin
                          ? 'No shops or warehouses yet.'
                          : 'No shops in the system yet.',
                      style: const TextStyle(
                        color: AppTheme.error,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: formLoading ? null : _goCreateLocation,
                      icon: const Icon(Icons.add_business),
                      label: Text(
                        widget.isCreateAdmin
                            ? 'Create a location first'
                            : 'Go to Shops to create one',
                      ),
                    ),
                  ],
                );
              }

              if (widget.isCreateAdmin) {
                return _adminLocationField(formLoading, shops);
              }

              final ids = [
                for (final s in shops)
                  if (s.id != null) s.id!,
              ];
              final valueOk = _selectedShopLocationId != null &&
                  ids.contains(_selectedShopLocationId);

              return DropdownButtonFormField<int>(
                // ignore: deprecated_member_use
                value: valueOk ? _selectedShopLocationId : null,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Shop *',
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.store),
                ),
                hint: const Text('Tap to choose shop'),
                items: [
                  for (final s in shops)
                    if (s.id != null)
                      DropdownMenuItem<int>(
                        value: s.id!,
                        child: Text(
                          '${s.name ?? 'Shop'}${s.code != null ? ' · ${s.code}' : ''}',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                ],
                onChanged:
                    formLoading ? null : (id) => _selectShop(id, shops),
              );
            },
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Column(
                children: [
                  Text('Loading shops…'),
                  SizedBox(height: 8),
                  LinearProgressIndicator(),
                ],
              ),
            ),
            error: (e, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Could not load ${widget.isCreateAdmin ? 'locations' : 'shops'}: ${friendlyError(e)}',
                  style: const TextStyle(color: AppTheme.error),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () {
                    if (widget.isCreateAdmin) {
                      ref.invalidate(allLocationsProvider);
                    } else {
                      ref.invalidate(locationsByTypeProvider('SHOP'));
                    }
                  },
                  child: const Text('Retry'),
                ),
                TextButton(
                  onPressed: () => context.push('/admin/locations'),
                  child: const Text('Open Locations'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.isLoading;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.isCreateAdmin
              ? 'Add Admin'
              : widget.isAdminFlow
                  ? 'Add Seller'
                  : 'Sign Up',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(
                (widget.isAdminFlow || widget.isCreateAdmin)
                    ? '/admin/dashboard'
                    : '/login',
              );
            }
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(ResponsiveHelper.responsivePadding(context)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.person_add_alt_1,
                size: ResponsiveHelper.isSmallPhone(context) ? 48 : 64,
                color: AppTheme.primary,
              ),
              const SizedBox(height: 16),
              Text(
                widget.isCreateAdmin
                    ? 'Create Shop or Warehouse Admin'
                    : widget.isAdminFlow
                        ? 'Create Seller Account'
                        : 'Create Account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: ResponsiveHelper.isSmallPhone(context) ? 24 : 32,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF191C1E),
                ),
              ),
              SizedBox(height: ResponsiveHelper.isSmallPhone(context) ? 20 : 28),

              // Shop first — cannot miss this block
              if (widget.isAdminFlow || widget.isCreateAdmin) ...[
                _buildShopSection(isLoading),
                const SizedBox(height: 16),
              ],

              Container(
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0A000000),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(ResponsiveHelper.cardPadding(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: _userIdController,
                      enabled: !isLoading,
                      decoration: const InputDecoration(labelText: 'User ID'),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _usernameController,
                      enabled: !isLoading,
                      decoration: const InputDecoration(labelText: 'Username'),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _userNumberController,
                      enabled: !isLoading,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        labelText: 'Mobile Number',
                        hintText: '10 digits',
                        errorText: _mobileError,
                      ),
                      onChanged: (v) {
                        setState(() {
                          _mobileError = v.length > 10
                              ? 'Mobile number must be exactly 10 digits'
                              : null;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _shopNameController,
                      enabled: !isLoading,
                      decoration: InputDecoration(
                        labelText: widget.isCreateAdmin
                            ? 'Location name'
                            : 'Shop Name',
                        helperText: widget.isCreateAdmin
                            ? 'Filled when you pick a location; editable'
                            : 'Filled when you pick a shop; editable',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      enabled: !isLoading,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      obscureText: _obscurePassword,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _confirmPasswordController,
                      enabled: !isLoading,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword =
                                  !_obscureConfirmPassword;
                            });
                          },
                        ),
                      ),
                      obscureText: _obscureConfirmPassword,
                    ),
                    SizedBox(
                      height:
                          ResponsiveHelper.isSmallPhone(context) ? 20 : 32,
                    ),
                    ElevatedButton(
                      onPressed: isLoading ? null : _register,
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(
                              widget.isCreateAdmin
                                  ? 'Add Admin'
                                  : widget.isAdminFlow
                                      ? 'Add Seller'
                                      : 'Sign Up',
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
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

class _EmptyLocationHint extends StatelessWidget {
  const _EmptyLocationHint(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Text(
        text,
        style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary),
      ),
    );
  }
}
