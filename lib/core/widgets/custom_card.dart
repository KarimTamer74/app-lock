import 'package:flutter/material.dart';
import 'package:myapp/core/utils/constants.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;
  const CustomCard({
    super.key,
    required this.title,
    this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: AppColors.cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          leading: const Icon(
            Icons.face,
            size: 35,
            color: AppColors.iconColor,
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: onDelete,
          ),
        ),
      ),
    );
  }
}