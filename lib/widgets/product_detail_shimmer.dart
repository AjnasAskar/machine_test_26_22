import 'package:flutter/material.dart';
import 'package:machine_test_26_22/common/extensions.dart';

import '../utils/font_palette.dart';

class ProductDetailShimmer extends StatelessWidget {
  const ProductDetailShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        children: [
          Container(
            height: context.sh(size: 0.35),
            decoration: BoxDecoration(
              color: Colors.white,
                border:
                Border.all(color: Colors.grey.shade300, width: 0.5)),
          ),
          Container(
            margin: const EdgeInsets.only(top: 25, bottom: 10),
            height: 16,
            width: context.sw(size: 0.2),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: Row(
              children: [
                Container(
                  height: 45,
                  width: 45,
                  color: Colors.white,
                ),
                Expanded(child: Container(
                  height: 45,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  color: Colors.white,
                )),
                Container(
                  height: 45,
                  width: 45,
                  color: Colors.white,
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: 24,
            color: Colors.white,
            width: context.sw(size: 0.2),
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                Container(
                  height: 18,
                  width: context.sw(size: 0.4),
                  color: Colors.white,
                ),
                Container(
                  height: 2,
                  width: double.maxFinite,
                  margin: const EdgeInsets.only(top: 5, bottom: 15),
                ),
                Container(
                  height: 16,
                  margin: const EdgeInsets.only(bottom: 10),
                  width: double.maxFinite,
                  color: Colors.white,
                ),
                Container(
                  height: 16,
                  margin: const EdgeInsets.only(bottom: 10),
                  width: double.maxFinite,
                  color: Colors.white,
                ),
                Container(
                  height: 16,
                  margin: const EdgeInsets.only(bottom: 10),
                  width: double.maxFinite,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ).addShimmer,
    );
  }
}
