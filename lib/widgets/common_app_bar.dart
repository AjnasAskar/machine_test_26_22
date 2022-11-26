import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:machine_test_26_22/providers/app_data_provider.dart';
import 'package:machine_test_26_22/utils/theme_palette.dart';
import 'package:provider/provider.dart';

import '../utils/font_palette.dart';

class CommonAppBar extends AppBar {
  final String? pageTitle;
  final bool enableNavBack;
  final BuildContext context;

  CommonAppBar({
    Key? key,
    this.pageTitle,
    this.enableNavBack = true,
    required this.context,
  }) : super(
    key: key,
    iconTheme: const IconThemeData(
      color: Colors.black, //change your color here
    ),
    leadingWidth: 60,
    leading: enableNavBack
        ? IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.arrow_back_ios_new,
                color: ThemePalette.primaryColor,
                size: 20,
              )),
        ))
        : null,
    backgroundColor: HexColor('#f3f3f3'),
    elevation: 0.5,
    shadowColor: HexColor('#D9E3E3'),
    centerTitle: false,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    titleSpacing: 10,
    title: Text(
      pageTitle ?? '',
      style: FontPalette.black16SemiBold,
    ),
    automaticallyImplyLeading: enableNavBack,
    actions: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black
                ),
                padding: const EdgeInsets.fromLTRB(5, 5, 5, 6),
                alignment: Alignment.center,
                child: Selector<AppDataProvider, int>(
                  selector: (context, provider) => provider.cartCount,
                  builder: (context, value, child) {
                    return Text(
                      '$value',
                      style: FontPalette.white9Bold,
                      textAlign: TextAlign.center,
                    );
                  },
                )),
            Transform.translate(
              offset: const Offset(0, -3),
              child: const Icon(
                Icons.shopping_bag_outlined,
                color: Colors.black,
              ),
            ),
          ],
        ),
      )
    ],
  );
}
