import 'package:flutter/material.dart';
import 'package:weather/core/appcolors.dart';

class TextStyles {
  static TextStyle heading1 = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 65, color: AppColors.text);

  static TextStyle heading2 = TextStyle(
      fontWeight: FontWeight.w500, fontSize: 22, color: AppColors.text);

  static TextStyle heading3 = TextStyle(
      fontWeight: FontWeight.w500, fontSize: 15, color: AppColors.text);

  static TextStyle error =
      TextStyle(fontWeight: FontWeight.w500, color: AppColors.text);
}
