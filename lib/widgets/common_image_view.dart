import 'package:flutter/material.dart';
import 'package:machine_test_26_22/utils/theme_palette.dart';
import 'package:octo_image/octo_image.dart';

class CommonImageView extends StatelessWidget {
  final String image;
  final double? height;
  final bool isCircular;
  final BoxFit? boxFit;
  final double? width;

  const CommonImageView(
      {Key? key,
        required this.image,
        this.height,
        this.width,
        this.boxFit,
        this.isCircular = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OctoImage(
      image: NetworkImage(image),
      placeholderBuilder: (context) => Container(
            height: height ?? double.maxFinite,
            width: width ?? double.maxFinite,
            decoration: BoxDecoration(
                color: ThemePalette.shimmerColor, //HexColor('E8E8E8'),
                shape: isCircular ? BoxShape.circle : BoxShape.rectangle),
          ),
      errorBuilder: (context, _, __) => Container(
            decoration: BoxDecoration(
                color: ThemePalette.shimmerColor,
                shape: isCircular ? BoxShape.circle : BoxShape.rectangle),
            height: height ?? double.maxFinite,
            width: width ?? double.maxFinite,
          ),
      imageBuilder: isCircular ? OctoImageTransformer.circleAvatar() : null,
      fit: boxFit ?? BoxFit.contain,
      height: height ?? double.maxFinite,
      width: width ?? double.maxFinite,
    );
  }
}