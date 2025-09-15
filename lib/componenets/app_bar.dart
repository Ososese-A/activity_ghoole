import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_ghoole/styles/app_colors.dart';

PreferredSizeWidget appBar ({required bool hasOptions, List<Widget>? options, required BuildContext context, ValueChanged<String?>? onChange, bool isOptionOpen = false, VoidCallback? openOptionAction}) {
  return AppBar(
    backgroundColor: AppColors.secWhite,
    leading: Padding(
      padding: const EdgeInsets.all(14.0),
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: SvgPicture.asset(
          "assets/icons/back.svg",
        ),
      ),
    ),
    actionsPadding: EdgeInsets.only(right: 14.0),
    actions: [
      if (isOptionOpen)
      GestureDetector(
        onTap: openOptionAction ?? () {},
        child: SvgPicture.asset("assets/icons/cancel.svg"),
      )
      else
      hasOptions 
      ? 
      GestureDetector(
        child: SvgPicture.asset("assets/icons/more.svg"),
        onTapDown: (TapDownDetails details) {
          showMenu(
            elevation: 0.0,
            color: AppColors.priWhite,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1.0,
                color: AppColors.priBrown
              ),
              borderRadius: BorderRadius.circular(8.0)
            ),
            context: context, 
            position: RelativeRect.fromLTRB(
              details.globalPosition.dx, 
              details.globalPosition.dy, 
              details.globalPosition.dx, 
              details.globalPosition.dy
            ),
            items: List.generate(options!.length, (i) => PopupMenuItem(
              value: '$i',
              child: options[i]
            )).toList()
          ).then((selected) {
            if (selected != null && onChange != null) {
              onChange(selected);
            }
          });
        },
      ) 
      : 
      SizedBox.shrink()
    ],
  );
}