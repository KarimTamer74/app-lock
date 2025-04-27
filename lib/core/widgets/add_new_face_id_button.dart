import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'face_id_icon.dart';

class AddNewFaceIdButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddNewFaceIdButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.lightGray,
          foregroundColor: AppColors.textColor,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaceIdIcon(
              color: AppColors.textColor,
              size: 24,
            ),
            SizedBox(width: 10),
            Text(
              'Add new FaceID',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.textColor
              ),
            ),
            SizedBox(width: 10),
            Icon(Icons.add, size: 24, color: AppColors.textColor),
          ],
        ),
      ),
    );
  }
}