import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_ghoole/styles/app_colors.dart';

Widget nameFieldComponent ({required TextEditingController controller}) {
  return SizedBox(
    width: double.infinity,
    child: TextFormField(
      controller: controller,
      cursorColor: AppColors.priWhite,
      style: TextStyle(
        color: AppColors.priWhite
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        hintText: "Activity Name",
        hintStyle: TextStyle(
          color: AppColors.secWhite
        ),
        filled: true,
        fillColor: AppColors.secBrown,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0)
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0)
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0)
        )
      ),
    ),
  );
}

Widget durationFieldComponent ({required TextEditingController controller, required String unit, required List<String> units, required ValueChanged<String?>? onChanged}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: AppColors.secBrown,
      borderRadius: BorderRadius.circular(8.0)
    ),
    // width: MediaQuery.of(context).size.width - 28,
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: TextFormField(
            controller: controller,
            cursorColor: AppColors.priWhite,
            style: TextStyle(
              color: AppColors.priWhite
            ),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: "Activity Duration",
              hintStyle: TextStyle(
                color: AppColors.secWhite
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
    
        const SizedBox(width: 8.0,),
    
        Expanded(
          flex: 1,
          child: DropdownButtonFormField<String>(
            dropdownColor: AppColors.secBrown,
            icon: SvgPicture.asset("assets/icons/down_w.svg"),
            value: unit,
            items: units.map((u) {
              return DropdownMenuItem(
                value: u,
                child: Text(
                  u,
                  style:  TextStyle(
                    color: AppColors.priWhite,
                    fontWeight: FontWeight.w400
                  ),
                )
              );
            }).toList(), 
            onChanged: onChanged,
            decoration: const InputDecoration(
              hintText: "Units",
              hintStyle: TextStyle(
                color: AppColors.secWhite
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget timeFieldComponent ({required TextEditingController controller, required List<String> options, required ValueChanged<String> onSelected}) {
  return Autocomplete<String>(
    optionsBuilder: (TextEditingValue textEditingValue) {
      return options.where((option) => 
        option.contains(textEditingValue.text));
    },
    optionsViewBuilder: (context, onSelected, options) {
      return Align(
        alignment: Alignment.topLeft,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(2),
            color: AppColors.secBrown,
            child: ListView.builder(
              itemCount: options.length,
              itemBuilder: (context, index) {
                final option = options.elementAt(index);
                return InkWell(
                  onTap: () => onSelected(option),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.priWhite,
                        ),
                      ),
                    ),
                    child: Text(
                      option,
                      style: const TextStyle(
                        color: AppColors.priWhite,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                );
              }
            ),
          ),
        ),
      );
    },
    fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
      controller.text = controller.text;
      return TextFormField(
        controller: controller,
        focusNode: focusNode,
        style: TextStyle(
            color: AppColors.secWhite
          ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          filled: true,
          fillColor: AppColors.secBrown,
          hintText: "Activity Time",
          hintStyle: TextStyle(
            color: AppColors.secWhite
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0)
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0)
          ),
        ),
        keyboardType: TextInputType.datetime,
      );
    },
    onSelected: (String selection) {
      controller.text = selection;
      //external callback for the selection
      onSelected(selection);
    },
  );
}

Widget detailsFieldComponent ({required TextEditingController controller}) {
  return SizedBox(
    height: 132,
    child: TextFormField(
      controller: controller,
      cursorColor: AppColors.priWhite,
      style: TextStyle(
        color: AppColors.priWhite
      ),
      maxLines: null,
      expands: true,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        hintText: "Activity Details",
        hintStyle: TextStyle(
          color: AppColors.secWhite
        ),
        filled: true,
        fillColor: AppColors.secBrown,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0)
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0)
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0)
        )
      ),
    ),
  );
}