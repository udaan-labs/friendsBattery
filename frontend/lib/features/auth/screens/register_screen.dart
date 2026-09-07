import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import 'package:go_router/go_router.dart';

import '../../../core/network/api_client_provider.dart';
import '../../../core/state/data_sync.dart';
import '../../../shared/utils/app_formatters.dart';
import '../../../shared/utils/password.dart';
import '../../../shared/widgets/responsive_helper.dart';
import '../../../shared/widgets/snackbar_helper.dart';
import '../../../theme/app_theme.dart';
import '../../admin/locations/providers/locations_providers.dart';
import '../../shared/staff/providers/staff_providers.dart';
import '../providers/auth_controller.dart';
import '../widgets/admin_location_picker.dart';

/// Add seller (`isAdminFlow`) or add admin (`isCreateAdmin`).
/// Shop → POST /api/auth/register (SELLER). Warehouse → register-admin (ADMIN).
class RegisterScreen extends ConsumerStatefulWidget {
  final bool isAdminFlow;
  /// Super Admin creates shop Admin (mutually exclusive with seller flow).
  final bool isCreateAdmin;
  final int? initialLocationId;

  const RegisterScreen({
    super.key,
    this.isAdminFlow = false,
    this.isCreateAdmin = false,
    this.initialLocationId,
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
  late int? _selectedShopLocationId = widget.initialLocationId;
  LocationItemTypeEnum? _selectedType;
  String? _mobileError;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _prefillUserId());
  }

  Future<void> _prefillUserId() async {
    try {
      final res = await ref.read(apiClientProvider).getShopsApi().apiShopsSellersNextUserIdGet();
      final id = res.data?.data?.userId;
      if (!mounted || _userIdController.text.isNotEmpty || id == null) return;
      _userIdController.text = id;
    } catch (_) {
      // POST still auto-gens if left empty
    }
  }

  bool get _asSeller =>
      widget.isAdminFlow || _selectedType == LocationItemTypeEnum.SHOP;

  static String _titleName(String value) {
    return value
        .trim()
        .split(RegExp(r'\s+'))
        .where((w) => w.isNotEmpty)
        .map((w) => '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}')
        .join(' ');
  }

  static String? _mobileLengthError(String value) {
    if (value.length < 10) {
      return 'Mobile number cannot be less than 10 digits';
    }
    if (value.length > 10) {
      return 'Mobile number cannot be more than 10 digits';
    }
    return null;
  }

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
    final mobileError = _mobileLengthError(number);
    if (mobileError != null) {
      setState(() => _mobileError = mobileError);
      context.showErrorSnackBar(mobileError);
      return;
    }

    final passwordError = validateStrongPassword(_passwordController.text);
    if (passwordError != null) {
      context.showErrorSnackBar(passwordError);
      return;
    }
    if (_passwordController.text != _confirmPasswordController.text) {
      context.showErrorSnackBar('Passwords do not match');
      return;
    }

    final needsShop = widget.isAdminFlow || widget.isCreateAdmin;
    if (needsShop && _selectedShopLocationId == null) {
      context.showErrorSnackBar(
        widget.isCreateAdmin && !_asSeller
            ? 'Select a shop or warehouse'
            : 'Select a shop for this seller',
      );
      return;
    }

    final shopName = _shopNameController.text.trim();

    if (widget.isCreateAdmin && !_asSeller) {
      final ok = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Add this admin?'),
          content: Text(
            'Create admin ${_userIdController.text.trim()} at ${shopName.isEmpty ? 'this location' : shopName}?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Add Admin'),
            ),
          ],
        ),
      );
      if (ok != true || !mounted) return;
    }

    try {
      final username = _titleName(_usernameController.text);
      _usernameController.text = username;
      final notifier = ref.read(authControllerProvider.notifier);
      if (_asSeller) {
        await notifier.register(
          userId: _userIdController.text.trim(),
          username: username,
          userNumber: number,
          shopName: shopName,
          password: _passwordController.text,
          locationId: _selectedShopLocationId,
        );
      } else {
        await notifier.registerAdmin(
          userId: _userIdController.text.trim(),
          username: username,
          userNumber: number,
          shopName: shopName,
          password: _passwordController.text,
          locationId: _selectedShopLocationId,
        );
      }

      if (mounted) {
        context.showSuccessSnackBar(
          _asSeller
              ? 'Seller created at selected shop (inactive until activated).'
              : widget.isCreateAdmin
                  ? 'Admin created for that location and can log in immediately.'
                  : 'Registration successful.',
        );
        if (_asSeller) {
          DataSync.afterStaffMutation(ref);
        }
        if (_selectedShopLocationId != null) {
          ref.invalidate(locationStaffProvider(_selectedShopLocationId!));
        }
        context.pop();
      }
    } catch (_) {
      // Errors are handled automatically by ApiInterceptor
    }
  }

  void _selectShop(int? id, List<LocationItem> shops) {
    if (id == null) {
      setState(() {
        _selectedShopLocationId = null;
        _selectedType = null;
      });
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
      _selectedType = shop?.type;
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
  Widget _buildShopSection(bool formLoading, {required bool lockShop}) {
    final shopsAsync = widget.isCreateAdmin
        ? ref.watch(allLocationsProvider)
        : ref.watch(locationsByTypeProvider('SHOP'));
    final shopTitle = widget.isCreateAdmin
        ? 'Select shop or warehouse'
        : lockShop
            ? 'Shop'
            : 'Select shop for this seller';

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
          if (_asSeller && !lockShop) ...[
            const SizedBox(height: 4),
            const Text(
              'Assign this seller to a shop.',
              style: TextStyle(fontSize: 12, color: Color(0xFF545F73)),
            ),
          ],
          const SizedBox(height: 12),
          shopsAsync.when(
            data: (shops) {
              if (widget.initialLocationId != null &&
                  _shopNameController.text.isEmpty) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (!mounted || _shopNameController.text.isNotEmpty) return;
                  _selectShop(widget.initialLocationId, shops);
                });
              }
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
                return AdminLocationField(
                  formLoading: formLoading,
                  locations: shops,
                  selectedId: _selectedShopLocationId,
                  onOpen: () => showAdminLocationPicker(
                    context: context,
                    locations: shops,
                    selectedId: _selectedShopLocationId,
                    onSelected: (s) {
                      final id = s.id;
                      if (id != null) _selectShop(id, [s]);
                    },
                  ),
                );
              }

              if (lockShop) {
                return TextField(
                  enabled: false,
                  controller: _shopNameController,
                  decoration: const InputDecoration(
                    labelText: 'Shop *',
                    helperText: 'Fixed to this shop',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.store),
                  ),
                );
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
    final lockShop = widget.initialLocationId != null;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          _asSeller
              ? 'Add Seller'
              : widget.isCreateAdmin
                  ? 'Add Admin'
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
                _asSeller
                    ? 'Create Seller Account'
                    : widget.isCreateAdmin
                        ? 'Create Admin'
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
                _buildShopSection(isLoading, lockShop: lockShop),
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
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'\s')),
                      ],
                      decoration: const InputDecoration(
                        labelText: 'User ID',
                        hintText: 'SELL001',
                        helperText: 'Auto-filled single word ID. No spaces.',
                      ),
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
                        setState(() => _mobileError = _mobileLengthError(v));
                      },
                    ),
                    if (!lockShop) ...[
                      const SizedBox(height: 16),
                      TextField(
                        controller: _shopNameController,
                        enabled:
                            !isLoading && (!widget.isCreateAdmin || _asSeller),
                        decoration: InputDecoration(
                          labelText: _asSeller ? 'Shop Name' : 'Location name',
                          helperText: _asSeller
                              ? 'Filled when you pick a shop; editable'
                              : 'Change location with the picker above',
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      enabled: !isLoading,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        helperText:
                            '8+ chars, 1 uppercase, 1 special character',
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
                              _asSeller
                                  ? 'Add Seller'
                                  : widget.isCreateAdmin
                                      ? 'Add Admin'
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
