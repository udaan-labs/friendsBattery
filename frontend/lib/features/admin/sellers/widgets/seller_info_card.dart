import 'package:flutter/material.dart';
import '../../../../shared/widgets/responsive_helper.dart';

class SellerInfoCard extends StatelessWidget {
  final String shopName;
  final String userName;
  final String userNumber;
  final bool isActive;
  final bool isVerified;
  final String? locationLabel;

  const SellerInfoCard({
    super.key,
    required this.shopName,
    required this.userName,
    required this.userNumber,
    required this.isActive,
    required this.isVerified,
    this.locationLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.cardPadding(context)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  shopName,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                ),
              ),
              Icon(Icons.storefront, size: ResponsiveHelper.iconSize(context, 36), color: Colors.blueAccent),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.person_outline, size: 20, color: Colors.black54),
              const SizedBox(width: 8),
              Text(
                userName,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.phone_outlined, size: 20, color: Colors.black54),
              const SizedBox(width: 8),
              Text(
                userNumber,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ],
          ),
          if (locationLabel != null && locationLabel!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 20, color: Colors.black54),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    locationLabel!,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 20),
          Row(
            children: [
              _buildBadge(
                label: isActive ? 'Active' : 'Inactive',
                color: isActive ? Colors.green : Colors.grey,
                icon: isActive ? Icons.circle : Icons.do_not_disturb_on,
              ),
              const SizedBox(width: 12),
              _buildBadge(
                label: isVerified ? 'Verified' : 'Unverified',
                color: isVerified ? Colors.blue : Colors.grey,
                icon: isVerified ? Icons.check_circle : Icons.help_outline,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadge({required String label, required Color color, required IconData icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
