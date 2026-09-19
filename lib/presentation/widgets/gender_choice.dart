import 'package:flutter/material.dart';
import 'app_colors.dart';

class GenderChoice extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const GenderChoice({
    super.key,
    required this.title,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(
            vertical: 13,
          ),
          decoration: BoxDecoration(
            color: selected
                ? AppColors.burgundy.withOpacity(0.08)
                : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected
                  ? AppColors.burgundy
                  : const Color(0xFFE7DDD6),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 19,
                color: selected
                    ? AppColors.burgundy
                    : AppColors.softBrown,
              ),

              const SizedBox(width: 6),

              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: selected
                      ? FontWeight.bold
                      : FontWeight.w500,
                  color: selected
                      ? AppColors.burgundy
                      : AppColors.darkBrown,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}