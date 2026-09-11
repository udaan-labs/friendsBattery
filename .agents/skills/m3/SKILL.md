---
name: m3
description: >
  Material Design 3 (M3) UI skill for Flutter frontend. Use whenever creating or
  modifying Flutter screens, widgets, cards, dialogs, buttons, forms, and layouts.
  Enforces Google M3 components (FilledButton, Card, NavigationBar, SearchBar,
  ThemeData.useMaterial3, ColorScheme tokens) and AppTheme alignment. Triggers:
  /m3, material 3, m3 design, flutter ui, ui design, theme, widget redesign.
---

# Material 3 (M3) Flutter UI Guidelines

This skill enforces Google Material Design 3 (M3) design standards across all Flutter UI code in `frontend/lib/`.

## Core Principles

1. **Native M3 First:** Always use Flutter's built-in M3 components rather than custom-styled legacy widgets or outdated M2 components.
2. **Token-Driven Colors & Theme:** Consume `Theme.of(context).colorScheme` and `AppTheme` tokens. Never hardcode random hex colors in widgets.
3. **Consistent Elevation & Surfaces:** Use M3 tonal surfaces (`surfaceContainer`, `surfaceContainerHighest`, etc.) and border strokes (`outlineVariant`) rather than heavy drop shadows.
4. **Touch Targets & Accessibility:** Minimum tap target 48x48 dp. High contrast text against background/surface tokens.
5. **Small Feature Widgets:** Keep screens as shells; split cards, forms, pickers, and lists into focused widgets under `widgets/`.

---

## M3 Component Mapping (What to use vs what to avoid)

| Purpose | ✅ Use in M3 | ❌ Avoid / Outdated |
|---|---|---|
| Primary Action | `FilledButton` / `FilledButton.icon` | `ElevatedButton` with custom heavy shadows |
| Secondary Action | `FilledButton.tonal` / `OutlinedButton` | Random colored container buttons |
| Tertiary / Quiet Action | `TextButton` | Flat clickable text without ripple |
| Floating Action | `FloatingActionButton.extended` or `FloatingActionButton` (small/large) | Custom round Container buttons |
| Cards / Containers | `Card(elevation: 0, shape: ...)` or `Card.outlined` | `Container` with manual BoxShadow hacks |
| Search Bar | `SearchBar` / `SearchAnchor` | Custom TextField inside Container with icon |
| Bottom Navigation | `NavigationBar` | `BottomNavigationBar` (legacy M2) |
| Dialogs / Modals | `AlertDialog` with M3 shape & `showModalBottomSheet(showDragHandle: true)` | Full custom bottom sheet shells without drag handle |
| Badges & Status | `Badge` / `FilterChip` / `AssistChip` | Hand-made border/pill containers |
| Progress Indicator | `LinearProgressIndicator` (rounded corners) / `CircularProgressIndicator` | Legacy progress bars |

---

## Theming & Color Tokens

In Flutter with `useMaterial3: true`:
- Primary: `theme.colorScheme.primary`
- Background / Scaffold: `theme.scaffoldBackgroundColor` or `theme.colorScheme.surface`
- Card Surface: `theme.colorScheme.surfaceContainerLow` or `AppTheme.surface`
- Subtle Borders: `theme.colorScheme.outlineVariant`
- Secondary text: `theme.colorScheme.onSurfaceVariant` or `AppTheme.textSecondary`

### Standard Card Example (M3):
```dart
Card(
  elevation: 0,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
    side: BorderSide(
      color: Theme.of(context).colorScheme.outlineVariant,
      width: 1,
    ),
  ),
  color: Theme.of(context).colorScheme.surface,
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: ...,
  ),
)
```

### Standard Primary Button Example (M3):
```dart
FilledButton.icon(
  onPressed: () {},
  icon: const Icon(Icons.add, size: 20),
  label: const Text('Add Battery'),
  style: FilledButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    minimumSize: const Size(64, 48),
  ),
)
```

### Standard Bottom Sheet Example (M3):
```dart
showModalBottomSheet(
  context: context,
  showDragHandle: true,
  isScrollControlled: true,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
  ),
  builder: (context) => ...,
);
```

---

## Agent Enforcement Checklist

When writing or reviewing any Flutter UI:
- [ ] Are buttons using `FilledButton` / `OutlinedButton` instead of old styles?
- [ ] Are bottom sheets using `showDragHandle: true` with rounded corners (24dp)?
- [ ] Are list items using `ListTile` with proper M3 text styles (`bodyMedium`, `titleMedium`)?
- [ ] Are colors referenced via `Theme.of(context).colorScheme` or `AppTheme`?
- [ ] Is the screen modularized into small widget files under `features/<area>/<feature>/widgets/`?
