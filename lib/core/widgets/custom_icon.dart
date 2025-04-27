import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FaceIdCard extends StatelessWidget {
  final String name;
  final VoidCallback onDelete;

  const FaceIdCard({
    Key? key,
    required this.name,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue[100],
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/face_id_icon.svg', // Replace with your icon path
              width: 30,
              height: 30,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            IconButton(
              icon: SvgPicture.asset('assets/icons/delete_icon.svg'), // Replace with your delete icon path
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}