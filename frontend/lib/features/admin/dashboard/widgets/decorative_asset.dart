import 'package:flutter/material.dart';
import '../../../../shared/widgets/responsive_helper.dart';

class DecorativeAsset extends StatelessWidget {
  const DecorativeAsset({super.key});

  @override
  Widget build(BuildContext context) {
    final isSmall = ResponsiveHelper.isSmallPhone(context);
    return SliverToBoxAdapter(
      child: Container(
        height: isSmall ? 180 : 256,
        margin: EdgeInsets.only(top: isSmall ? 16 : 32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
          image: const DecorationImage(
            image: NetworkImage(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuDNtNHufOqRR1c_y7gMGI0DSBXsvE8qABUhOo6dSq-ZcLChc9Qa83cBKgqJf8Hpg_BxeAH43oo3mXGiNu4D2DRmxf6ERmMStSG-uXsAtsK2sYsURpPcCOykM9_ItMvXw9JESRoGz4Wo9PCCwVN_UIC5T58V-bahWiBoHNZ0iAyDYbM_LQiTf8-2FLnY4n0sucexEYseTx490LeMjoQu_mKQ32-tU9G5x_mV9LJGRrMGBZqSv2cyOvPEUg4q0LV38sAuxP5vJal9eBQ'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                const Color(0xFF006B2C).withValues(alpha: 0.8),
                Colors.transparent,
              ],
            ),
          ),
          padding: EdgeInsets.all(isSmall ? 16 : 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Optimization Active',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ResponsiveHelper.fontSize(context, 22),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: isSmall ? 2 : 4),
              Text(
                'Battery health across fleet is at 98.4% capacity.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: ResponsiveHelper.fontSize(context, 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
