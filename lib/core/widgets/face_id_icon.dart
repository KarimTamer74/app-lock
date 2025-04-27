import 'package:flutter/material.dart';
import 'package:myapp/core/utils/constants.dart';

class FaceIdIcon extends StatelessWidget {
  const FaceIdIcon({
    Key? key,
    this.size = 24,
    this.color = AppColors.greyColor,
  }) : super(key: key);

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