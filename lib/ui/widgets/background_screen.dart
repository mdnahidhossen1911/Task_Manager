import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/assetsPath.dart';

class BackgroundScreen extends StatelessWidget {
  const BackgroundScreen({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          AssetsPath.backgroundSvg,
          fit: BoxFit.cover,
          width: double.maxFinite,
          height: double.maxFinite,
        ),
        SafeArea(child: child)
      ],
    );
  }
}
