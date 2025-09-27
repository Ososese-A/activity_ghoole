import 'package:flutter/material.dart';
import 'package:project_ghoole/componenets/app_bar.dart';
import 'package:project_ghoole/componenets/btn_component.dart';
import 'package:project_ghoole/componenets/field_component.dart';
import 'package:project_ghoole/componenets/snack_component.dart';
import 'package:project_ghoole/models/activity.dart';
import 'package:project_ghoole/providers/activity_provider.dart';
import 'package:project_ghoole/styles/app_colors.dart';
import 'package:provider/provider.dart';

class NewActivitiesScreen extends StatefulWidget {
  const NewActivitiesScreen({super.key});

  @override
  State<NewActivitiesScreen> createState() => _NewActivitiesScreenState();
}

class _NewActivitiesScreenState extends State<NewActivitiesScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _hourController = TextEditingController();

  String _durationUnit = 'minutes';
  final List<String> _durationUnits = ['minutes', 'hours'];

  final List<String> _hourOptions = [
    '00:00', 
    '01:00', 
    '02:00', 
    '03:00', 
    '04:00', 
    '05:00', 
    '06:00', 
    '07:00', 
    '08:00', 
    '09:00', 
    '10:00', 
    '11:00', 
    '12:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00',
    '18:00',
    '19:00',
    '20:00',
    '21:00',
    '22:00',
    '23:00',
  ];

  String tagValue = "";

  String validate () {
    final duration_v = int.tryParse(_durationController.text);
    final timeInterim = _hourController.text.split(":");

    if (_nameController.text.isEmpty && _durationController.text.isEmpty && _hourController.text.isEmpty && _detailController.text.isEmpty && tagValue.isEmpty) {
      return "all";
    } else if (_nameController.text.isEmpty) {
      return "name";
    } else if (_durationController.text.isEmpty) {
      return "duration";
    } else if (_hourController.text.isEmpty) {
      return "time";
    } else if (_detailController.text.isEmpty) {
      return "details";
    } else if (tagValue.trim().isEmpty) {
      return "tag";
    } else if (duration_v == null || duration_v <= 0) {
      return "duration_v";
    } else if (timeInterim.length != 2) {
      return "time_v";
    } else if (timeInterim.length == 2) {
      final hour = int.tryParse(timeInterim[0]);
      final minute = int.tryParse(timeInterim[1]);

      if (hour == null || hour < 0 || hour > 23 || minute == null || minute < 0 || minute > 59) {
        return "time_v";
      } else {
        return "";
      }
    } else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secWhite,
      appBar: appBar(hasOptions: false, context: context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 24.0),
                      child: Text(
                        "New Activities",
                        style: TextStyle(
                          color: AppColors.secBrown,
                          fontSize: 24.0,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
              
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          nameFieldComponent(
                            controller: _nameController
                          ),
              
                          const SizedBox(height: 16,),
              
                          durationFieldComponent(
                            controller: _durationController, 
                            unit: _durationUnit, 
                            units: _durationUnits, 
                            onChanged: (value) {
                              setState(() {
                                _durationUnit = value!;
                              });
                            }
                          ),
                          
                          const SizedBox(height: 16,),
              
                          //editable dropdown 
                          timeFieldComponent(
                            controller: _hourController, 
                            options: _hourOptions, 
                            onSelected: (value) {
                              setState(() {
                                _hourController.text = value;
                              });
                            }
                          ),
                        
                          SizedBox(height: 16,),
              
                          detailsFieldComponent(
                            controller: _detailController
                          ),
              
                          const SizedBox(height: 16,),
              
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Activity Tags",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: AppColors.secBrown
                                ),
                              ),
              
                              SizedBox(height: 8.0,),
              
                              Wrap(
                                spacing: 8.0,
                                runSpacing: 8.0,
                                direction: Axis.horizontal,
                                children: [
                                  tagBtnComponent(
                                    title: "Design", 
                                    icon: tagValue == "design" ? "assets/icons/design_w.svg" : "assets/icons/design.svg",
                                    isSelected: tagValue == "design" ? true : false,
                                    onPressed: () {
                                      if (tagValue != "design") {
                                        setState(() {
                                        tagValue = "design";
                                      });
                                      }
                                    }
                                  ),

                                  tagBtnComponent(
                                    title: "Coding", 
                                    icon: tagValue == "code" ? "assets/icons/code_w.svg" : "assets/icons/code.svg",
                                    isSelected: tagValue == "code" ? true : false,
                                    onPressed: () {
                                      if (tagValue != "code") {
                                        setState(() {
                                          tagValue = "code";
                                        });
                                      }
                                    }
                                  ),

                                  tagBtnComponent(
                                    title: "School", 
                                    icon: tagValue == "school" ? "assets/icons/school_w.svg" : "assets/icons/school.svg",
                                    isSelected: tagValue == "school" ? true : false,
                                    onPressed: () {
                                      if (tagValue != "school") {
                                        setState(() {
                                          tagValue = "school";
                                        });
                                      }
                                    }
                                  ),

                                  tagBtnComponent(
                                    title: "House", 
                                    icon: tagValue == "home" ? "assets/icons/home_w.svg" : "assets/icons/home.svg",
                                    isSelected: tagValue == "home" ? true : false,
                                    onPressed: () {
                                      if (tagValue != "home") {
                                        setState(() {
                                          tagValue = "home";
                                        });
                                      }
                                    }
                                  ),

                                  tagBtnComponent(
                                    title: "Personal", 
                                    icon: tagValue == "person" ? "assets/icons/person_w.svg" : "assets/icons/person.svg",
                                    isSelected: tagValue == "person" ? true : false,
                                    onPressed: () {
                                      if (tagValue != "person") {
                                        setState(() {
                                          tagValue = "person";
                                        });
                                      }
                                    }
                                  ),

                                  tagBtnComponent(
                                    title: "Finance", 
                                    icon: tagValue == "finance" ? "assets/icons/finance_w.svg" : "assets/icons/finance.svg",
                                    isSelected: tagValue == "finance" ? true : false,
                                    onPressed: () {
                                      if (tagValue != "finance") {
                                        setState(() {
                                          tagValue = "finance";
                                        });
                                      }
                                    }
                                  ),

                                  tagBtnComponent(
                                    title: "Religious", 
                                    icon: tagValue == "church" ? "assets/icons/church_w.svg" : "assets/icons/church.svg",
                                    isSelected: tagValue == "church" ? true : false,
                                    onPressed: () {
                                      if (tagValue != "church") {
                                        setState(() {
                                          tagValue = "church";
                                        });
                                      }
                                    }
                                  ),

                                  tagBtnComponent(
                                    title: "Miscellneous", 
                                    icon: tagValue == "misc" ? "assets/icons/misc_w.svg" : "assets/icons/misc.svg",
                                    isSelected: tagValue == "misc" ? true : false,
                                    onPressed: () {
                                      setState(() {
                                        tagValue = "misc";
                                      });
                                    }
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      )
                    ),

                    SizedBox(
                      height: 64.0,
                    ),

                    Container(
                      color: AppColors.secWhite,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            btnComponent(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  final validationValue = validate();
                      
                                  if (validationValue.isNotEmpty) {
                                    switch (validationValue) {
                                      case "all":
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          snackComponent(title: "Fields cannot be empty")
                                        );
                                        break;
                                      case "name":
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          snackComponent(title: "Activity name field cannot be empty")
                                        );
                                        break;
                                      case "duration":
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          snackComponent(title: "Activity duration field cannot be empty")
                                        );
                                      case "time":
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          snackComponent(title: "Activity time field cannot be empty")
                                        );
                                      case "details":
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          snackComponent(title: "Activity details field cannot be empty")
                                        );
                                      case "tag":
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          snackComponent(title: "An activity tag must be selected")
                                        );
                                      case "duration_v":
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          snackComponent(title: "Invalid Duration!")
                                        );
                                      case "time_v":
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          snackComponent(title: "Inavlid Time!")
                                        );
                                    }
                                  } else {
                                    final id = DateTime.now().millisecondsSinceEpoch.toString();
                      
                                    final activity = Activity(
                                      id: id, 
                                      name: _nameController.text.trim(), 
                                      duration: "${_durationController.text.trim()} $_durationUnit", 
                                      time: _hourController.text.trim(), 
                                      details: _detailController.text.trim(),
                                      tag: tagValue,
                                      added: DateTime.now().toIso8601String().split("T").first,
                                      updated: DateTime.now().toIso8601String().split("T").first,
                                    );
                      
                                    final provider = Provider.of<ActivityProvider>(context, listen: false);
                                    await provider.addActivity(activity: activity);
                      
                                    if (provider.wasSuccessful == true) {
                                      Navigator.pop(context);
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        snackComponent(title: "Failed to add activity")
                                      );
                                    }
                                  }
                                }
                              }, 
                              title: "Add Activity"
                            )
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),            
          ],
        ),
      ),
    );
  }
}