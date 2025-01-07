import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.themColor,
      title: Row(
        children: [
          CircleAvatar(),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nahid Hossen',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'nahid@gmail.com',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  fontFamily: 'poppins',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
