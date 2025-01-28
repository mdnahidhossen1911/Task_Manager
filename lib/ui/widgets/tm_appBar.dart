import 'dart:convert';

import 'package:flutter/material.dart';

import '../controller/auth_controller.dart';
import '../screens/sign_in_screen.dart';
import '../screens/update_profile_screen.dart';
import '../utils/app_colors.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  TMAppBar({
    super.key,
    this.fromUpdateProfile = false,
  });

  final bool fromUpdateProfile;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.themColor,
      title: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundImage: MemoryImage(
              base64Decode(AuthController.userModel?.photo ?? ''),
            ),
            onBackgroundImageError: (_, __) => const Icon(Icons.person_outline),
          ),
          SizedBox(width: 12),
          GestureDetector(
            onTap: () {
              if (!fromUpdateProfile) {
                Navigator.pushNamed(context, UpdateProfileScreen.name);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AuthController.userModel?.fullName ?? '',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  AuthController.userModel?.email ?? '',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontFamily: 'poppins',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        PopupMenuButton(
          iconColor: Colors.white,
          color: Colors.white,
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              child: Row(
                children: [
                  Icon(
                    Icons.logout,
                    size: 20,
                  ),
                  SizedBox(width: 6),
                  Text('Log Out'),
                ],
              ),
              onTap: () async {
                await AuthController.clearUserData();
                Navigator.pushNamedAndRemoveUntil(
                    context, SignInScreen.name, (predicate) => false);
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
