import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CenteredCircularProgressIndicator extends StatelessWidget {
  const CenteredCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: const Center(
        child: CircularProgressIndicator(
          color: AppColors.themColor,
        ),
      ),
    );
  }
}
