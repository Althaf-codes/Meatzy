import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/Global_Variables.dart';

Widget MyTextFeild({
  int maxline = 1,
  String validationErrMsg = "This Feild is Missing",
  IconData icon = FontAwesomeIcons.a,
  required TextInputType type,
  required String hint,
  required String label,
  required TextEditingController controller,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
    child: Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            blurRadius: 10,
            spreadRadius: 7,
            offset: Offset(1, 10),
            color: Colors.grey.withOpacity(0.2)),
        // BoxShadow(
        //     blurRadius: 10,
        //     spreadRadius: 7,
        //     offset: Offset(10, 1),
        //     color: Colors.grey.withOpacity(0.2))
      ]),
      child: TextFormField(
        maxLines: maxline,
        keyboardType: type,
        cursorColor: const Color.fromARGB(255, 29, 201, 192),
        decoration: InputDecoration(
            labelStyle:
                const TextStyle(color: const Color.fromARGB(255, 29, 201, 192)),
            hintText: hint,
            labelText: label,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                  color: GlobalVariables.secondaryColor,
                  style: BorderStyle.solid,
                  width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                  color: Colors.red, style: BorderStyle.solid, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              gapPadding: 10,
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                  color: GlobalVariables.selectedNavBarColor,
                  style: BorderStyle.solid,
                  width: 2),
            ),
            focusColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                  color: Colors.transparent,
                  style: BorderStyle.solid,
                  width: 5),
            ),
            prefixIcon: icon == FontAwesomeIcons.a
                ? Container(height: 0.002, width: 0.002)
                : IconButton(
                    icon: Icon(
                      icon,
                      color: Color.fromARGB(255, 29, 201, 192),
                    ),
                    onPressed: () {},
                  ),
            fillColor: Colors.white,
            filled: true),
        controller: controller,
        validator: (name) {
          if (name!.isEmpty || name == null)
            return validationErrMsg;
          else {
            return null;
          }
        },
      ),
    ),
  );
}

Widget MySwitch(
    {required Function(bool) onChanged,
    required bool switchValue,
    required String title}) {
  return Padding(
    padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                color: GlobalVariables.secondaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
          Switch(
            value: switchValue,
            onChanged: onChanged,
            activeTrackColor: GlobalVariables.secondaryColor,
            activeColor: GlobalVariables.selectedNavBarColor,
          ),
        ],
      ),
    ),
  );
}
