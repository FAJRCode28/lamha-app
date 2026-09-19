import 'package:flutter/material.dart';
import 'app_colors.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? action;

  const SectionHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBrown,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.softBrown,
                ),
              ),
            ],
          ),
        ),

        if (action != null) action!,
      ],
    );
  }
}