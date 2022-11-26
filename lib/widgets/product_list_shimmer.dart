import 'package:flutter/material.dart';
import 'package:machine_test_26_22/common/extensions.dart';

class ProductListShimmer extends StatelessWidget {
  const ProductListShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: constraints.maxWidth / (constraints.maxHeight)),
        itemBuilder: (cxt, index) {
          return Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200, width: 0.5)),
            child: Column(
              children: [
                Expanded(child: Container(
                  color: Colors.white,
                )),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 30, right: 30, bottom: 5),
                        height: 16,
                        color: Colors.white,
                        width: double.maxFinite,
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 5),
                            height: 25,
                            color: Colors.white,
                            width: 20,
                          ),
                          Expanded(child:  Container(
                            margin: const EdgeInsets.only(right: 5),
                            height: 25,
                            color: Colors.white,
                            width: double.maxFinite,
                          ),  ),
                          Container(
                            margin: const EdgeInsets.only(right: 5),
                            height: 25,
                            color: Colors.white,
                            width: 20,
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 40, right: 40, bottom: 5, top: 10),
                        height: 16,
                        color: Colors.white,
                        width: double.maxFinite,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        height: 40,
                        color: Colors.white,
                        width: double.maxFinite,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
        itemCount: 10,
      ).addShimmer;
    });
  }
}
