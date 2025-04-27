import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/constants.dart';

class AppIcon extends StatelessWidget {
  final String iconPath;
  final double? size;
  final Color? color;
  const AppIcon(
      {super.key, required this.iconPath, this.size, this.color = AppColors.darkGray});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconPath,
      height: size ?? 24,
      width: size ?? 24,
      colorFilter: ColorFilter.mode(color!, BlendMode.srcIn),
    );
  }
}