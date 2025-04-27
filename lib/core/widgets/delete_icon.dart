import 'package:flutter/material.dart';
import 'package:myapp/core/utils/constants.dart';

class DeleteIcon extends StatelessWidget {
  const DeleteIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.delete_forever,
      color: AppColors.redColor,
    );
  }
}