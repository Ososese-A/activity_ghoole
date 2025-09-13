import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_ghoole/styles/app_colors.dart';

PreferredSizeWidget appBar ({required bool hasOptions, List<String>? options}) {
  return AppBar(
    backgroundColor: AppColors.secWhite,
    leading: Padding(
      padding: const EdgeInsets.all(14.0),
      child: SvgPicture.asset(
        "assets/icons/back.svg",
      ),
    ),
    actionsPadding: EdgeInsets.only(right: 14.0),
    actions: [
      hasOptions 
      ? 
      SvgPicture.asset("assets/icons/more.svg") 
      : 
      SizedBox.shrink()
    ],
  );
}