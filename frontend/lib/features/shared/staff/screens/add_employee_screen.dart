import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/responsive_helper.dart';
import '../../../../shared/widgets/snackbar_helper.dart';
import '../../../../theme/app_theme.dart';
import '../providers/staff_providers.dart';

/// Create EMPLOYEE account.
/// - Seller: location fixed to own shop (no location picker).
/// - Admin: must pick location (or [initialLocationId] preselected from seller detail).
class AddEmployeeScreen extends ConsumerStatefulWidget {
  const AddEmployeeScreen({
    super.key,
    this.isAdmin = false,
    this.initialLocationId,
    this.sellerIdForRefresh,
  });

  final bool isAdmin;
  final int? initialLocationId;
  final int? sellerIdForRefresh;

  @override
  ConsumerState<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends ConsumerState<AddEmployeeScreen> {
  final _userIdController = TextEditingController();
  final _usernameController = TextEditingController();
  final _userNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _submitting = false;
  int? _selectedLocationId;
  int? _selectedRoleId;

  @override
  void initState() {
    super.initState();
    _selectedLocationId = widget.initialLocationId;
  }

  @override
  void dispose() {
    _userIdController.dispose();
    _usernameController.dispose();
    _userNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final userId = _userIdController.text.trim();
    final username = _usernameController.text.trim();
    final number = _userNumberController.text.trim();
    final password = _passwordController.text;
    final confirm = _confirmPasswordController.text;

    if (userId.isEmpty || username.isEmpty || number.isEmpty || password.isEmpty) {
      context.showErrorSnackBar('Fill all required fields');
      return;
    }
    if (!RegExp(r'^\d{10}$').hasMatch(number)) {
      context.showErrorSnackBar('Mobile number must be exactly 10 digits');
      return;
    }
    if (password.length < 6) {
      context.showErrorSnackBar('Password must be at least 6 characters');
      return;
    }
    if (password != confirm) {
      context.showErrorSnackBar('Passwords do not match');
      return;
    }
    if (widget.isAdmin && _selectedLocationId == null) {
      context.showErrorSnackBar('Select a warehouse or shop');
      return;
    }

    setState(() => _submitting = true);
    try {
      await ref.read(staffRepositoryProvider).createEmployee(
            userId: userId,
            username: username,
            userNumber: number,
            password: password,
            employeeRoleId: _selectedRoleId,
            locationId: widget.isAdmin ? _selectedLocationId : null,
          );

      ref.invalidate(sellerMyStaffProvider);
      if (widget.sellerIdForRefresh != null) {
        ref.invalidate(shopStaffProvider(widget.sellerIdForRefresh!));
      }
      final locId = widget.isAdmin ? _selectedLocationId : null;
      if (locId != null) {
        ref.invalidate(locationStaffProvider(locId));
      }

      if (!mounted) return;
      context.showSuccessSnackBar('Employee created — they can log in now');
      context.pop();
    } catch (e) {
      if (!mounted) return;
      context.showErrorSnackBar(e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final rolesAsync = ref.watch(employeeRolesProvider);
    final locationsAsync =
        widget.isAdmin ? ref.watch(locationsListProvider) : null;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(widget.isAdmin ? '/admin/sellers' : '/seller/staff');
            }
          },
        ),
        title: const Text(
          'Add Employee',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(ResponsiveHelper.responsivePadding(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.badge_outlined, size: 48, color: AppTheme.primary),
              const SizedBox(height: 12),
              Text(
                widget.isAdmin
                    ? 'Create employee for a warehouse or shop'
                    : 'Add employee to your shop',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Color(0xFF545F73)),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(ResponsiveHelper.cardPadding(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (widget.isAdmin && locationsAsync != null) ...[
                      locationsAsync.when(
                        data: (locations) {
                          if (locations.isEmpty) {
                            return const Text(
                              'No active locations. Create a warehouse or shop first.',
                              style: TextStyle(color: AppTheme.error),
                            );
                          }
                          final selectedOk = _selectedLocationId != null &&
                              locations.any((l) => l.id == _selectedLocationId);
                          return DropdownButtonFormField<int>(
                            // ignore: deprecated_member_use — controlled field needs value
                            value: selectedOk ? _selectedLocationId : null,
                            decoration: const InputDecoration(
                              labelText: 'Location (warehouse or shop)',
                            ),
                            items: [
                              for (final l in locations)
                                DropdownMenuItem<int>(
                                  value: l.id!,
                                  child: Text(
                                    _locationLabel(l),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                            ],
                            onChanged: _submitting
                                ? null
                                : (v) => setState(() => _selectedLocationId = v),
                          );
                        },
                        loading: () => const LinearProgressIndicator(),
                        error: (e, _) => Text(
                          e.toString().replaceFirst('Exception: ', ''),
                          style: const TextStyle(color: AppTheme.error),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    TextField(
                      controller: _userIdController,
                      enabled: !_submitting,
                      decoration: const InputDecoration(
                        labelText: 'User ID',
                        hintText: 'e.g. EMP002',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _usernameController,
                      enabled: !_submitting,
                      decoration: const InputDecoration(labelText: 'Full name'),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _userNumberController,
                      enabled: !_submitting,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Mobile number',
                        hintText: '10 digits',
                      ),
                    ),
                    const SizedBox(height: 16),
                    rolesAsync.when(
                      data: (roles) {
                        return DropdownButtonFormField<int?>(
                          // ignore: deprecated_member_use — controlled field needs value
                          value: _selectedRoleId,
                          decoration: const InputDecoration(
                            labelText: 'Job title (optional)',
                          ),
                          items: [
                            const DropdownMenuItem<int?>(
                              value: null,
                              child: Text('None'),
                            ),
                            for (final r in roles)
                              DropdownMenuItem<int?>(
                                value: r.id,
                                child: Text(r.name ?? 'Role'),
                              ),
                          ],
                          onChanged: _submitting
                              ? null
                              : (v) => setState(() => _selectedRoleId = v),
                        );
                      },
                      loading: () => const SizedBox.shrink(),
                      error: (_, __) => const SizedBox.shrink(),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      enabled: !_submitting,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () => setState(
                            () => _obscurePassword = !_obscurePassword,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _confirmPasswordController,
                      enabled: !_submitting,
                      obscureText: _obscureConfirm,
                      decoration: InputDecoration(
                        labelText: 'Confirm password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirm
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () => setState(
                            () => _obscureConfirm = !_obscureConfirm,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    ElevatedButton(
                      onPressed: _submitting ? null : _submit,
                      child: _submitting
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text(
                              'Create employee',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
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

  static String _locationLabel(LocationItem l) {
    final type = l.type?.name ?? '';
    final name = l.name ?? l.code ?? 'Location';
    return type.isEmpty ? name : '$type · $name';
  }
}
