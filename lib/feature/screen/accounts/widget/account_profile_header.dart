import 'package:flutter/material.dart';
import 'package:hrms_app/core/constants/app_colors.dart';
import 'package:hrms_app/core/constants/app_images_png.dart';
import 'package:hrms_app/core/service/shared_pref_service.dart';

class AccountProfileHeader extends StatefulWidget {
  const AccountProfileHeader({super.key});

  @override
  State<AccountProfileHeader> createState() => _AccountProfileHeaderState();
}

class _AccountProfileHeaderState extends State<AccountProfileHeader> {
  String _userName = '';
  String _designation = '';
  String _employeeCode = '';
  String _phone = '';
  String _email = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefService = SharedPrefService();
    final name = await prefService.getName();
    final designation = await prefService.getDesignationCode(); // Note: designation code is what we have stored
    final empCode = await prefService.getEmployeeCode();
    final phone = await prefService.getPhone();
    final email = await prefService.getEmail();

    if (mounted) {
      setState(() {
        _userName = name ?? '';
        _designation = designation ?? '';
        _employeeCode = empCode ?? '';
        _phone = phone ?? '';
        _email = email ?? '';
      });
    }
  }

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
                        Text(
                          _userName,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        Text(
                          _designation,
                          style: const TextStyle(
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
                        _employeeCode,
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
              Text(
                _phone,
                style: const TextStyle(fontSize: 10, color: Color(0xFF374151)),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.mail_outline, size: 16, color: Color(0xFF6B7280)),
              const SizedBox(width: 4),
               Expanded(
                child: Text(
                  _email,
                  style: const TextStyle(fontSize: 10, color: Color(0xFF374151)),
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
