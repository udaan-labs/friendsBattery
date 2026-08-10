import 'package:flutter/material.dart';

/// Shared root navigator key — keep this file free of feature imports
/// so Dio interceptors can show snackbars without circular imports.
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
