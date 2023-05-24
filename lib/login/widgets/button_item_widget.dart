import 'package:flutter/material.dart';

import '../../core/resources/color_manager.dart';
import '../../core/resources/string_manager.dart';

class ButtonItemWidget extends StatelessWidget {
  ButtonItemWidget({Key? key, required this.onPressed}) : super(key: key);
  Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          25,
        ),
        color: ColorManager.mainColor,
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          StringManager.login,
          style: const TextStyle(
            color: ColorManager.backGroundColor,
          ),
        ),
      ),
    );
  }
}
