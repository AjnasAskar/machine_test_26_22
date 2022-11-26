import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;
import 'package:machine_test_26_22/utils/theme_palette.dart';
import 'package:shimmer/shimmer.dart';

import '../providers/app_data_provider.dart';

extension Context on BuildContext {
  double sh({double size = 1.0}) {
    return MediaQuery.of(this).size.height * size;
  }

  double sw({double size = 1.0}) {
    return MediaQuery.of(this).size.width * size;
  }
}

extension DoubleExtension on double? {
  String get roundTo2 {
    double val = this ?? 0.0;
    return val.toStringAsFixed(2);
  }

}

extension WidgetExtension on Widget {
  Widget animatedSwitch(
      {Curve? curvesIn, Curve? curvesOut, int duration = 500}) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: duration),
      switchInCurve: curvesIn ?? Curves.linear,
      switchOutCurve: curvesOut ?? Curves.linear,
      child: this,
    );
  }

  Flexible get flexWrap {
    if (this is Text) {
      return Flexible(child: (this as Text).avoidOverFlow());
    } else {
      return Flexible(child: this);
    }
  }

  Widget get addShimmer => Shimmer.fromColors(
        baseColor: ThemePalette.shimmerColor,
        highlightColor: Colors.white54,
        child: this,
      );
}

extension InkWellExtension on InkWell {
  InkWell removeSplash({Color color = Colors.white}) {
    return InkWell(
      onTap: onTap,
      splashColor: color,
      highlightColor: color,
      child: child,
    );
  }
}

extension TextExtension on Text {
  Text avoidOverFlow({int maxLine = 1}) {
    return Text(
      (data ?? '').trim().replaceAll('', '\u200B'),
      style: style,
      strutStyle: strutStyle,
      textAlign: textAlign,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
    );
  }

  Text addEllipsis({int maxLine = 1}) {
    return Text(
      (data ?? '').trim(),
      style: style,
      strutStyle: strutStyle,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
    );
  }
}

extension Log on Object {
  void log(String s, {String name = ''}) =>
      devtools.log(toString(), name: name);
}
