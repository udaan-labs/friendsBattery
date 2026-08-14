import 'package:flutter/material.dart';
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

  /// Shop picker for seller; shop + warehouse picker for create-admin.
  Widget _buildShopSection(bool formLoading) {
    final shopsAsync = widget.isCreateAdmin
        ? ref.watch(allLocationsProvider)
        : ref.watch(locationsByTypeProvider('SHOP'));
    final shopTitle = widget.isCreateAdmin
        ? 'Select shop or warehouse'
        : 'Select shop for this seller';
    final shopHint = widget.isCreateAdmin
        ? 'Required. Admin is linked to this location.'
        : 'Required. Multiple sellers can use the same shop.';

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

              final ids = [
                for (final s in shops)
                  if (s.id != null) s.id!,
              ];
              final valueOk = _selectedShopLocationId != null &&
                  ids.contains(_selectedShopLocationId);

              // Pick only — create shops lives on Dashboard → Shops.
              return DropdownButtonFormField<int>(
                // ignore: deprecated_member_use
                value: valueOk ? _selectedShopLocationId : null,
                isExpanded: true,
                decoration: InputDecoration(
                  labelText: widget.isCreateAdmin ? 'Location *' : 'Shop *',
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(
                    widget.isCreateAdmin ? Icons.place : Icons.store,
                  ),
                ),
                hint: Text(
                  widget.isCreateAdmin
                      ? 'Tap to choose shop or warehouse'
                      : 'Tap to choose shop',
                ),
                items: [
                  for (final s in shops)
                    if (s.id != null)
                      DropdownMenuItem<int>(
                        value: s.id!,
                        child: Text(
                          widget.isCreateAdmin
                              ? '${s.type == LocationItemTypeEnum.WAREHOUSE ? 'Warehouse' : 'Shop'} · ${s.name ?? s.code ?? 'Location'}'
                              : '${s.name ?? 'Shop'}${s.code != null ? ' · ${s.code}' : ''}',
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
                      decoration:
                          const InputDecoration(labelText: 'Mobile Number'),
                      keyboardType: TextInputType.phone,
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
