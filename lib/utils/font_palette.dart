import 'dart:ui';

import 'package:flutter/material.dart';

class FontPalette {
  static const themeFont = "PlusJakarta";

  ///9
  static TextStyle get white9Bold =>
      const TextStyle(
          fontSize: 9, fontWeight: FontWeight.w700, color: Colors.white);

  ///10
  static TextStyle get black10Bold =>
      const TextStyle(
          fontSize: 10, fontWeight: FontWeight.w700, color: Colors.black);

  ///14
  static TextStyle get white14Bold => const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white);

  static TextStyle get black14Medium => const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87);


  ///16
  static TextStyle get white16Bold => const TextStyle(
      fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white);

  static TextStyle get black16SemiBold => const TextStyle(
      fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87);

  static TextStyle get black16Medium => const TextStyle(
      fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87);

  ///18
  static TextStyle get black18Medium => const TextStyle(
      fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black);

  ///22
  static TextStyle get black22SemiBold => const TextStyle(
      fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black87);

  ///30
  static TextStyle get white30Bold =>
      const TextStyle(
          fontSize: 30, fontWeight: FontWeight.w700, color: Colors.white);

}