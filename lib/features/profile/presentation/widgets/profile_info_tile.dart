import 'package:electro/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileInfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;
  final Color? color;

  const ProfileInfoTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        color: AppColors.secondBackground,
        child: ListTile(
          leading: Icon(icon, color: color),
          title: Text(label),
          subtitle: Text(value),
          onTap: onTap,
          trailing: onTap != null ? const Icon(Icons.chevron_right) : null,
        ),
      ),
    );
  }
}