import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DocsIcon extends StatelessWidget {
  const DocsIcon({super.key, this.color, required this.iconPath});
  final Color? color;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconPath,
      colorFilter: ColorFilter.mode(
        color ?? Theme.of(context).primaryColor,
        BlendMode.srcIn,
      ),
    );
  }
}