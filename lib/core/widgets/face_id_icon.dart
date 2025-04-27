import 'package:flutter/material.dart';
import 'package:myapp/core/utils/constants.dart';

class FaceIdIcon extends StatelessWidget {
  const FaceIdIcon({
    super.key,
    this.size = 24,
    this.color = AppColors.greyColor,
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.face,
      size: size,
      color: color,
    );
  }
}