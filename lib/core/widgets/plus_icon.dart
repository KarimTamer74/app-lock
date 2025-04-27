import 'package:flutter/material.dart';
import 'package:myapp/core/utils/constants.dart';

class PlusIcon extends StatelessWidget {
  const PlusIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.add_circle,
      color: AppColors.whiteColor,
    );
  }
}