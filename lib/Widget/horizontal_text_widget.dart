import 'package:flutter/material.dart';
import 'package:meatzy_app/Constants/Global_Variables.dart';

class HorizontalTitleText extends StatelessWidget {
  String title;
  String text;
  int maxline;
  HorizontalTitleText(
      {Key? key,
      required this.title,
      required this.text,
      required this.maxline})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("$title   :   ",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            )),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.green, //Color.fromARGB(255, 131, 130, 130),
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
            maxLines: maxline,
          ),
        ),
      ],
    );
  }
}
