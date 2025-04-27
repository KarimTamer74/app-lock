import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/constants.dart';
import 'delete_icon.dart';

class FaceIdCard extends StatelessWidget {
  final String name;
  final VoidCallback onDelete;

  const FaceIdCard({
    super.key,
    required this.name,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.lightBlue,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(
              Icons.face,
              width: 30,
              height: 30,
              color: AppColors.iconColor,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.textColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                onPressed: onDelete, icon: const DeleteIcon(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}