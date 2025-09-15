import 'package:flutter/material.dart';
import 'package:project_ghoole/componenets/app_bar.dart';
import 'package:project_ghoole/componenets/btn_component.dart';
import 'package:project_ghoole/componenets/field_component.dart';
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
                        "My Activities",
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
              
                              SizedBox(height: 16.0,),
              
                              Row(
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
                                  SizedBox(width: 16.0,),
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
                                ],
                              ),
              
                              SizedBox(height: 16.0,),
              
                              Row(
                                children: [
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
                                  SizedBox(width: 16.0,),
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
                                ],
                              ),
              
                              SizedBox(height: 16.0,),
              
                              Row(
                                children: [
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
                                  SizedBox(width: 16.0,),
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
                                ],
                              ),
              
                              SizedBox(height: 16.0,),
              
                              Row(
                                children: [
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
                                  SizedBox(width: 16.0,),
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
                    )
                ],
              ),
            ),
        
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    btnComponent(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
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
                              SnackBar(content: Text("Failed to add activity"))
                            );
                          }
                        }
                      }, 
                      title: "Add Activity"
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}