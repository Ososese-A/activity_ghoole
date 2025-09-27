import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_ghoole/componenets/btn_component.dart';
import 'package:project_ghoole/styles/app_colors.dart';

Widget emptyState ({required BuildContext context}) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.transparent
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/icons/nill.svg"),
  
            SizedBox(height: 32.0,),
  
            Text(
              "No Activity Found",
              style: TextStyle(
                fontSize: 24.0,
                color: AppColors.secBrown,
                fontWeight: FontWeight.w600
              ),
            ),
  
            SizedBox(height: 16.0,),
  
            Text(
              "Add in a new activity and let Ghoole do it’s work",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.secBrown
              ),
            ),
  
            SizedBox(height: 32.0,),
  
            btnComponent(
              onPressed: () {
                Navigator.pushNamed(context, '/new');
              },
              title: "Add Activity"
            )
          ],
        ),
    );
  }