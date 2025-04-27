import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddNewFaceIdButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddNewFaceIdButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/face_id.svg',
              height: 24,
              width: 24,
            ),
            const SizedBox(width: 10),
            const Text(
              'Add new FaceID',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 10),
            const Icon(Icons.add, size: 24),
          ],
        ),
      ),
    );
  }
}