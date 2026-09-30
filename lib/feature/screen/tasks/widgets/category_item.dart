import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String label;
  final String iconPath;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryItem({
    super.key,
    required this.label,
    required this.iconPath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(

        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFAF5FF) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? const Color(0xFF901AEA) : const Color(0xFFE5E7EB),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              width: 18,
              height: 18,
              color: isSelected ? const Color(0xFF901AEA) : const Color(0xFF6B7280),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? const Color(0xFF901AEA) : const Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
