import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

/// Card vs compact list. Default caller should pass [cardView] true.
class SalesViewToggle extends StatelessWidget {
  final bool cardView;
  final ValueChanged<bool> onChanged;

  const SalesViewToggle({
    super.key,
    required this.cardView,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          tooltip: 'Cards',
          isSelected: cardView,
          onPressed: () => onChanged(true),
          icon: const Icon(Icons.view_agenda_outlined),
          selectedIcon: const Icon(Icons.view_agenda, color: AppTheme.primary),
        ),
        IconButton(
          tooltip: 'List',
          isSelected: !cardView,
          onPressed: () => onChanged(false),
          icon: const Icon(Icons.view_list_outlined),
          selectedIcon: const Icon(Icons.view_list, color: AppTheme.primary),
        ),
      ],
    );
  }
}
