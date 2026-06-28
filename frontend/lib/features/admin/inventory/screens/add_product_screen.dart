import 'package:flutter/material.dart';
import '../../../../shared/widgets/responsive_helper.dart';

import 'forms/create_complete_hierarchy_form.dart';
import 'forms/add_category_form.dart';
import 'forms/add_product_model_form.dart';
import 'forms/add_product_name_form.dart';
import 'forms/create_product_form.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(ResponsiveHelper.responsivePadding(context)),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Selection Method',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF191C1E),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Choose how you want to expand the battery inventory system.',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF3E4A3D),
                ),
              ),
              const SizedBox(height: 24),

              _ActionCard(
                icon: Icons.account_tree_outlined,
                title: 'Create Complete Hierarchy',
                description: 'Add a new Group, Category, Product Name, and Model from scratch.',
                iconBgColor: const Color(0xFF00873A),
                iconColor: const Color(0xFFF7FFF2),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CreateCompleteHierarchyForm(),
                  ));
                },
              ),
              const SizedBox(height: 16),

              _ActionCard(
                icon: Icons.category_outlined,
                title: 'Add New Category',
                description: 'Add a category to an existing Group.',
                iconBgColor: const Color(0xFFD5E0F8),
                iconColor: const Color(0xFF586377),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddCategoryForm(),
                  ));
                },
              ),
              const SizedBox(height: 16),

              _ActionCard(
                icon: Icons.battery_charging_full,
                title: 'Add Product Name',
                description: 'Add a new product name to an existing Category.',
                iconBgColor: const Color(0xFF006B2C),
                iconColor: const Color(0xFFFFFFFF),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddProductNameForm(),
                  ));
                },
              ),
              const SizedBox(height: 16),

              _ActionCard(
                icon: Icons.layers_outlined,
                title: 'Add Product Model',
                description: 'Add a specific product model to an existing Product Name.',
                iconBgColor: const Color(0xFFDBE1FF),
                iconColor: const Color(0xFF00174B),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddProductModelForm(),
                  ));
                },
              ),
              const SizedBox(height: 16),

              _ActionCard(
                icon: Icons.price_change_outlined,
                title: 'Configure Product',
                description: 'Set pricing and minimum threshold limits for an existing product configuration.',
                iconBgColor: const Color(0xFFFFDAB9),
                iconColor: const Color(0xFFD2691E),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CreateProductForm(),
                  ));
                },
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color iconBgColor;
  final Color iconColor;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.iconBgColor,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.transparent),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF191C1E),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF3E4A3D),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFF6E7B6C)),
          ],
        ),
      ),
    );
  }
}
