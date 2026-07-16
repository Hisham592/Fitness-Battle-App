import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voz_app/core/theme/app_colors.dart';
import 'package:voz_app/features/onboarding_auth/data/models/user_model.dart';
import 'package:voz_app/features/onboarding_auth/presentation/screens/sign_in_screen.dart';

class TempDashboardScreen extends StatelessWidget {
  const TempDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('TEMP DASHBOARD'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const SignInScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(user?.uid)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryNeon,
                  ),
                );
              }

              if (snapshot.hasError ||
                  !snapshot.hasData ||
                  !snapshot.data!.exists) {
                return const Center(
                  child: Text(
                    'Error fetching user data',
                    style: TextStyle(color: Colors.red),
                  ),
                );
              }

              final userData = UserModel.fromMap(
                snapshot.data!.data() as Map<String, dynamic>,
              );

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 80.w,
                      height: 80.h,
                      decoration: const BoxDecoration(
                        color: Color(0XFF1E1E1E),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person,
                        size: 40.sp,
                        color: AppColors.primaryNeon,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'USER PROFILE',
                    style: TextStyle(
                      color: const Color(0XFFDF00FF),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _buildDataRow('UID', userData.uid),
                  _buildDataRow('Name', userData.name),
                  _buildDataRow('Email', userData.email),
                  _buildDataRow('Level', userData.level),
                  _buildDataRow('XP', '${userData.xp} XP'),
                  _buildDataRow('Points', '${userData.points} pts'),
                  _buildDataRow(
                    'Created At',
                    userData.createdAt.substring(0, 10),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
