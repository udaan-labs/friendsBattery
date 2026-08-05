import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_theme.dart';
import '../../../shared/widgets/responsive_helper.dart';
import '../providers/auth_controller.dart';
import '../../../core/state/data_sync.dart';
import '../../../shared/widgets/snackbar_helper.dart';
import '../../admin/locations/providers/locations_providers.dart';

/// Admin Add Seller (`isAdminFlow: true`) or closed public sign-up.
/// Admin: shop dropdown from GET /api/shops/locations?type=SHOP;
/// register sends location_id so multiple sellers can share one shop.
class RegisterScreen extends ConsumerStatefulWidget {
  final bool isAdminFlow;

  const RegisterScreen({super.key, this.isAdminFlow = false});

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
  final _shopDropdownController = TextEditingController();
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
    _shopDropdownController.dispose();
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

    if (widget.isAdminFlow && _selectedShopLocationId == null) {
      context.showErrorSnackBar('Select a shop for this seller');
      return;
    }

    if (widget.isAdminFlow && _shopNameController.text.trim().isEmpty) {
      context.showErrorSnackBar('Shop name is required');
      return;
    }

    try {
      await ref.read(authControllerProvider.notifier).register(
            userId: _userIdController.text.trim(),
            username: _usernameController.text.trim(),
            userNumber: number,
            shopName: _shopNameController.text.trim(),
            password: _passwordController.text,
            // Wire: POST /api/auth/register { location_id } — many sellers → one shop
            locationId: widget.isAdminFlow ? _selectedShopLocationId : null,
          );

      if (mounted) {
        context.showSuccessSnackBar(
          widget.isAdminFlow
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

  void _onShopSelected(int? id, List<LocationItem> shops) {
    if (id == null) return;
    LocationItem? shop;
    for (final s in shops) {
      if (s.id == id) {
        shop = s;
        break;
      }
    }
    if (shop == null) return;
    setState(() {
      _selectedShopLocationId = id;
      _shopNameController.text = shop!.name ?? shop.code ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.isLoading;
    final shopsAsync =
        widget.isAdminFlow ? ref.watch(locationsByTypeProvider('SHOP')) : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isAdminFlow ? 'Add Seller' : 'Sign Up'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(widget.isAdminFlow ? '/admin/dashboard' : '/login');
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
                widget.isAdminFlow ? 'Create Seller Account' : 'Create Account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: ResponsiveHelper.isSmallPhone(context) ? 24 : 32,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF191C1E),
                ),
              ),
              if (widget.isAdminFlow) ...[
                const SizedBox(height: 8),
                const Text(
                  'Pick a shop. Several sellers can belong to the same shop.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
                ),
              ],
              SizedBox(height: ResponsiveHelper.isSmallPhone(context) ? 24 : 48),
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
                    // ── Shop dropdown (admin) ─────────────────────────────
                    if (widget.isAdminFlow && shopsAsync != null) ...[
                      shopsAsync.when(
                        data: (shops) {
                          if (shops.isEmpty) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text(
                                  'No shops yet. Create a shop first, then add a seller.',
                                  style: TextStyle(color: AppTheme.error),
                                ),
                                const SizedBox(height: 8),
                                OutlinedButton.icon(
                                  onPressed: () async {
                                    await context.push('/admin/shops/add');
                                    ref.invalidate(
                                      locationsByTypeProvider('SHOP'),
                                    );
                                  },
                                  icon: const Icon(Icons.add_business_outlined),
                                  label: const Text('Create shop'),
                                ),
                              ],
                            );
                          }

                          // Searchable dropdown — GET /api/shops/locations?type=SHOP
                          return LayoutBuilder(
                            builder: (context, constraints) {
                              return DropdownMenu<int>(
                                controller: _shopDropdownController,
                                width: constraints.maxWidth,
                                enabled: !isLoading,
                                enableFilter: true,
                                requestFocusOnTap: true,
                                leadingIcon: const Icon(Icons.storefront_outlined),
                                label: const Text('Shop *'),
                                hintText: 'Search or select shop',
                                helperText:
                                    'Same shop can have multiple sellers',
                                initialSelection: _selectedShopLocationId,
                                onSelected: (id) =>
                                    _onShopSelected(id, shops),
                                dropdownMenuEntries: [
                                  for (final s in shops)
                                    if (s.id != null)
                                      DropdownMenuEntry<int>(
                                        value: s.id!,
                                        label:
                                            '${s.name ?? 'Shop'}${s.code != null ? ' · ${s.code}' : ''}',
                                      ),
                                ],
                              );
                            },
                          );
                        },
                        loading: () => const Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text('Loading shops…'),
                            SizedBox(height: 8),
                            LinearProgressIndicator(),
                          ],
                        ),
                        error: (e, _) => Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              e.toString().replaceFirst('Exception: ', ''),
                              style: const TextStyle(color: AppTheme.error),
                            ),
                            TextButton(
                              onPressed: () => ref.invalidate(
                                locationsByTypeProvider('SHOP'),
                              ),
                              child: const Text('Retry load shops'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
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
                      decoration: const InputDecoration(
                        labelText: 'Shop Name',
                        helperText: 'Defaults from shop; you can edit',
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
                              widget.isAdminFlow ? 'Add Seller' : 'Sign Up',
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
