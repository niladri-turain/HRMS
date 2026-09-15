import 'package:flutter/material.dart';
import 'package:hrms_app/core/constants/app_colors.dart';
import 'package:hrms_app/core/constants/app_images_png.dart';

class AccountProfileHeader extends StatelessWidget {
  const AccountProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade200, width: 2),
                ),
                child: const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(AppImagesPng.persionIcon),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Niladri Roy',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        const Text(
                          'Marketing Executive',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF6B7280),
                          ),
                        ),


                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                          color:AppColors.primary200.withOpacity(0.04),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: AppColors.primary200.withOpacity(0.2))
                      ),
                      child:  Text(
                        'TURAIN023',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary200,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.phone_android_outlined, size: 16, color: Color(0xFF6B7280)),
              const SizedBox(width: 4),
              const Text(
                '+91 9864404365',
                style: TextStyle(fontSize: 10, color: Color(0xFF374151)),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.mail_outline, size: 16, color: Color(0xFF6B7280)),
              const SizedBox(width: 4),
              const Expanded(
                child: Text(
                  'goutam.mazumder@turingrp.com',
                  style: TextStyle(fontSize: 10, color: Color(0xFF374151)),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
