import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../theme/app_theme.dart';
import '../../../shared/staff/widgets/people_search_field.dart';
import '../providers/accounts_providers.dart';
import '../widgets/account_tile.dart';
import '../widgets/accounts_role_chips.dart';

class AccountsScreen extends ConsumerWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(accountsListProvider);
    final query = ref.watch(accountsSearchProvider).trim().toLowerCase();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/admin/dashboard');
            }
          },
        ),
        title: const Text(
          'Accounts',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const AccountsRoleChips(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: PeopleSearchField(
              hint: 'Search name or user ID…',
              onChanged: (v) =>
                  ref.read(accountsSearchProvider.notifier).state = v,
            ),
          ),
          Expanded(
            child: async.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('$e')),
              data: (items) {
                final visible = query.isEmpty
                    ? items
                    : items.where((u) {
                        return (u.userName ?? '').toLowerCase().contains(query) ||
                            (u.userId ?? '').toLowerCase().contains(query) ||
                            (u.location?.name ?? '')
                                .toLowerCase()
                                .contains(query);
                      }).toList();
                if (visible.isEmpty) {
                  return Center(
                    child: Text(
                      query.isEmpty
                          ? 'No accounts in this role.'
                          : 'No match for this search.',
                    ),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () => ref.refresh(accountsListProvider.future),
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    itemCount: visible.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final user = visible[index];
                      return AccountTile(
                        user: user,
                        onSetActive: (isActive) async {
                          try {
                            await ref.read(accountsRepositoryProvider).setActive(
                                  id: user.id!,
                                  isActive: isActive,
                                );
                            ref.invalidate(accountsListProvider);
                          } catch (e) {
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('$e'),
                                backgroundColor: AppTheme.error,
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
