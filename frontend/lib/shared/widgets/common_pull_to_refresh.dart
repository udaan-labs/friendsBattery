import 'package:flutter/material.dart';

class CommonPullToRefresh extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;

  const CommonPullToRefresh({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: const Color(0xFF006B2C), // Primary color matching dashboard
      backgroundColor: Colors.white,
      child: child,
    );
  }
}
