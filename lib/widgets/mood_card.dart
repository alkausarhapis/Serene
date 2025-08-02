import 'package:flutter/material.dart';
import 'package:serene/global/colors.dart';

class MoodCard extends StatelessWidget {
  final String label;
  final String emoji;
  final int scoreValue;
  final bool selected;
  final VoidCallback onTap;

  const MoodCard({
    super.key,
    required this.label,
    required this.emoji,
    required this.scoreValue,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.orangeSub,
            borderRadius: BorderRadius.circular(12),
            border: selected
                ? Border.all(color: AppColors.primary, width: 3)
                : Border.all(color: Colors.transparent),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                emoji,
                style: const TextStyle(fontSize: 50),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
