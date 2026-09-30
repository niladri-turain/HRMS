import 'package:flutter/material.dart';

class TaskTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final String? prefixIcon;
  final IconData? suffixIcon;
  final bool isRequired;
  final int? maxLines;
  final int? maxLength;
  final bool isReadOnly;
  final VoidCallback? onTap;
  final TextEditingController? controller;

  const TaskTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.isRequired = false,
    this.maxLines = 1,
    this.maxLength,
    this.isReadOnly = false,
    this.onTap,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6B7280),
            ),
            children: [
              if (isRequired)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            constraints: BoxConstraints(
              minHeight: maxLines != null && maxLines! > 1 ? 60 : 40,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: TextField(
              controller: controller,
              readOnly: isReadOnly || onTap != null,
              onTap: onTap,
              maxLines: maxLines,
              maxLength: maxLength,
              textAlignVertical: maxLines != null && maxLines! > 1 ? TextAlignVertical.top : TextAlignVertical.center,
              style: const TextStyle(fontSize: 14, color: Color(0xFF1F2937)),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
                prefixIcon: prefixIcon != null
                    ? Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 8.0),
                        child: Image.asset(
                          prefixIcon!,
                          width: 16,
                          height: 16,
                          color: const Color(0xFF9CA3AF),
                          fit: BoxFit.contain,
                        ),
                      )
                    : null,
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 40,
                  minHeight: 16,
                ),
                suffixIcon: suffixIcon != null
                    ? Icon(suffixIcon, color: const Color(0xFF9CA3AF), size: 20)
                    : null,
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: maxLines != null && maxLines! > 1 ? 12 : 8,
                ),
                counterText: '',
              ),
            ),
          ),
        ),
        if (maxLength != null)
           Align(
             alignment: Alignment.centerRight,
             child: Padding(
               padding: const EdgeInsets.only(top: 4),
               child: Text(
                 '0 / $maxLength',
                 style: const TextStyle(fontSize: 10, color: Color(0xFF9CA3AF)),
               ),
             ),
           ),
      ],
    );
  }
}
