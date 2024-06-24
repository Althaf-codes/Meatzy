// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TestFcmPage extends StatefulWidget {
  String orderId;
  String title;
  String body;
  TestFcmPage({
    Key? key,
    required this.orderId,
    required this.title,
    required this.body,
  }) : super(key: key);

  @override
  State<TestFcmPage> createState() => _TestFcmPageState();
}

class _TestFcmPageState extends State<TestFcmPage> {
  // String msg = "";

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();

  //   final arguments = ModalRoute.of(context)!.settings.arguments;
  //   if (arguments != null) {
  //     Map? pushArguments = arguments as Map;

  //     setState(() {
  //       msg = pushArguments["message"];
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: Text("OrderId :${widget.orderId} // title :${widget.title}"),
    ));
  }
}
