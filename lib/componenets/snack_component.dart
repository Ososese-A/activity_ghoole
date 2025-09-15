import 'package:flutter/material.dart';
import 'package:project_ghoole/styles/app_colors.dart';

SnackBar snackComponent ({required String title}) {
  return SnackBar(
    backgroundColor: AppColors.priWhite,
    content: Text(
      title,
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: AppColors.priBrown
      ),
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
      side: BorderSide(
        width: 2.0,
        color: AppColors.priBrown
      )
    ),
    duration: Duration(seconds: 3),
    margin: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
  );
}






// What You Need to Add

// Focus Node for the Time Field
// final FocusNode _hourFieldFocusNode = FocusNode();

// Pass it to your time field:

// TextFormField(
//   controller: _hourController,
//   focusNode: _hourFieldFocusNode,
//   ...
// )



// ScaffoldMessenger.of(context).showSnackBar(
//   SnackBar(
//     content: Row(
//       children: [
//         Icon(Icons.warning_amber_rounded, color: Colors.white),
//         SizedBox(width: 8),
//         Expanded(
//           child: Text(
//             "Invalid hour or minute. Use 00:00 to 23:59",
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ],
//     ),
//     backgroundColor: AppColors.priBrown,
//     behavior: SnackBarBehavior.floating,
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//     margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//     duration: Duration(seconds: 4),
//     action: SnackBarAction(
//       label: "Fix",
//       textColor: Colors.yellowAccent,
//       onPressed: () {
//         // Focus the time field
//         FocusScope.of(context).requestFocus(_hourFieldFocusNode);

//         // Optionally show a helper dialog
//         showDialog(
//           context: context,
//           builder: (_) => AlertDialog(
//             title: Text("Time Format Help"),
//             content: Text("Please select a time between 00:00 and 23:59. You can use the dropdown or type manually."),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text("Got it"),
//               )
//             ],
//           ),
//         );
//       },
//     ),
//   ),
// );