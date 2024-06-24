import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meatzy_app/Model/meat_seller_model.dart';
import 'package:meatzy_app/Model/user_model.dart';

import 'package:provider/provider.dart';

import '../../Constants/Global_Variables.dart';
import '../Order/currentOrder/currentorder_display_screen.dart';

class NotificationScreen extends StatelessWidget {
  List<UserNotification>? notification;
  NotificationScreen({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = Provider.of<User>(context, listen: false);
    ScrollController scrollController = ScrollController();
    return Scaffold(
      appBar: AppBar(
          backgroundColor: GlobalVariables.secondaryColor,
          leading: BackButton(
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              })),
      body: SingleChildScrollView(
        controller: scrollController,
        clipBehavior: Clip.none,
        child: Column(children: [
          notification!.isEmpty
              ? const Center(
                  child: Text('No Notifications'),
                )
              : ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  controller: scrollController,
                  shrinkWrap: true,
                  itemCount: notification!.length,
                  itemBuilder: ((context, index) {
                    UserNotification singleNotification = notification![index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          width: double.infinity,
                          child: Row(
                            children: [
                              Hero(
                                tag: index,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      singleNotification.productImage),
                                  radius: 40,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                                child: VerticalDivider(),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: 15, left: 5, right: 5),
                                  child: Column(
                                    children: [
                                      Text(
                                        singleNotification.message,
                                        maxLines: 4,
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            child: ElevatedButton.icon(
                                                style: ElevatedButton.styleFrom(
                                                    minimumSize: Size(70, 40),
                                                    // fixedSize: Size(200, 40),
                                                    backgroundColor:
                                                        GlobalVariables
                                                            .secondaryColor,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15))),
                                                onPressed: () async {
                                                  // await MeatSellerService(
                                                  //         user: Provider.of<User>(
                                                  //             context,
                                                  //             listen: false))
                                                  //     .acceptOrder(
                                                  //         singleNotification.orderId);
                                                },
                                                icon: Icon(
                                                  Icons.ads_click_outlined,
                                                  size: 14,
                                                ),
                                                label: Text(
                                                  'Accept Order ',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: ElevatedButton.icon(
                                                style: ElevatedButton.styleFrom(
                                                    // minimumSize: Size(20, 40),

                                                    // fixedSize: Size(200, 40),
                                                    backgroundColor:
                                                        GlobalVariables
                                                            .selectedNavBarColor,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15))),
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            CurrentOrderDisplay(
                                                          userlivestockorders: [],
                                                          usermeatorders: [],
                                                        ),
                                                      ));
                                                },
                                                icon: Icon(
                                                  Icons.ads_click_outlined,
                                                  size: 14,
                                                ),
                                                label: Text(
                                                  'View',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )),
                    );
                  }))
        ]),
      ),
    );
  }
}
