import 'package:flutter/material.dart';
import 'package:machine_test_26_22/common/constants.dart';
import 'package:machine_test_26_22/common/extensions.dart';
import 'package:machine_test_26_22/utils/font_palette.dart';

import '../utils/theme_palette.dart';

class ErrorScreen extends StatelessWidget {
  final String? title;
  final VoidCallback? onPressed;
  const ErrorScreen({Key? key, this.title, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title ?? Constants.serverError,
            style: FontPalette.black18Medium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 50,
            width: context.sw(size: 0.5),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: ThemePalette.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
              onPressed: onPressed,
              child: Text(
                Constants.tryAgain,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: FontPalette.white16Bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
