import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/constants.dart';

class DocsIcon extends StatelessWidget {
  const DocsIcon({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      Constants.docsIcon,
      colorFilter: ColorFilter.mode(
        color ?? Theme.of(context).primaryColor,
        BlendMode.srcIn,
      ),
    );
  }
}