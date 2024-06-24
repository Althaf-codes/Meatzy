import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Constants/Global_Variables.dart';
import '../../Model/user_model.dart';
import '../../Service/user_firebase_service.dart';
import '../../Widget/sliverAppbar.dart';
import 'currentOrder/currentorder_display_screen.dart';
import 'deliveredOrder/delivered_order_display_screen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: GlobalVariables.secondaryColor,
                bottom: PreferredSize(
                  preferredSize: Size(double.infinity, 20),
                  child: TabBar(indicatorColor: Colors.black, tabs: [
                    Tab(
                      icon: Icon(Icons.delivery_dining),
                      text: 'Orders',
                    ),
                    Tab(
                      icon: Icon(Icons.history),
                      text: 'Delivered',
                    ),
                  ]),
                )),
            body: StreamBuilder<List<QueryDocumentSnapshot>>(
                stream: UserFirebaseService(
                        user: Provider.of<User>(context, listen: false))
                    .getAllUserOrder(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: GlobalVariables.selectedNavBarColor,
                    ));
                  }
                  if (snapshot.hasError) {
                    print("the error is ${snapshot.error}");
                    return const Center(child: Text("Error Occured"));
                  }
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text(
                        "No Orders Yet",
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    print("the stream data is ${snapshot.data}");
                    // List<UserMeatOrder>? allOrders =
                    //     snapshot.data!.reversed.toList();
                    List<QueryDocumentSnapshot> allOrders =
                        snapshot.data!.toList();

                    print('//////////////////');
                    print("the all orders length is ${allOrders.length} ");
                    print('//////////////////');
                    // List<UserMeatOrder>? currentOrder = [];
                    // List<UserMeatOrder>? deliveredOrder = [];

                    if (allOrders.isEmpty) {
                      return Center(
                        child: Text(
                          "You Haven't Ordered Yet",
                        ),
                      );
                    } else {
                      List<UserMeatOrder> usermeatorders = allOrders
                          .where((element) =>
                              element["orderedProductType"] == "meat")
                          .map((e) => UserMeatOrder.fromdocumentsnap(e))
                          .toList();
                      print("the length2 is ${usermeatorders.length}");

                      List<UserLiveStockOrder> userlivestockorders = allOrders
                          .where((element) =>
                              element["orderedProductType"] == "livestock")
                          .map((e) => UserLiveStockOrder.fromdocumentsnap(
                                  e) //print(e.data()
                              )
                          .toList();
                      print("the length1 is ${userlivestockorders.length}");

                      // List<UserLiveStockOrder> currentlivestockorder =
                      //     userlivestockorders
                      //         .where((element) =>
                      //             element.orderStatus != "Order Delivered")
                      //         .toList();

                      // List<UserLiveStockOrder> deliveredlivestockorder =
                      //     userlivestockorders
                      //         .where((element) =>
                      //             element.orderStatus == "Order Delivered")
                      //         .toList();

                      // allOrders.where((e) {
                      //   if (e.orderStatus != " Order Delivered") {
                      //     currentOrder.add(e);
                      //     setState(() {});
                      //   } else {
                      //     deliveredOrder.add(e);
                      //     setState(() {});
                      //   }
                      // });
                      // setState(() {

                      // });
                      // List<Order>? currentOrder = allOrders.where((element) {
                      //   print("the yes count is ${1}");
                      //   return element.orderStatus == "Order Delivered";
                      // }).toList();
                      // List<Order>? deliveredOrder = allOrders.where((element) {
                      //   return element.orderStatus != "Order Delivered";
                      // }).toList();

                      // print("currentorder is ${currentOrder.first}");
                      // print("deliveredorder is ${deliveredOrder.first}");

                      return TabBarView(
                        children: [
                          CurrentOrderDisplay(
                            usermeatorders: usermeatorders
                                .where((element) =>
                                    element.orderStatus != "Order Delivered")
                                .toList(),

                            //  allOrders
                            //     .where((element) =>
                            //         element.orderStatus != "Order Delivered")
                            //     .toList(),
                            userlivestockorders: userlivestockorders
                                .where((element) =>
                                    element.orderStatus != "Order Delivered")
                                .toList(),
                            // scrollController: scrollController,
                          ),
                          DeliveredOrderScreenDisplay(
                            deliveredMeatOrders: usermeatorders
                                .where((element) =>
                                    element.orderStatus == "Order Delivered")
                                .toList(),
                            deliveredLiveStockOrders: userlivestockorders
                                .where((element) =>
                                    element.orderStatus == "Order Delivered")
                                .toList(),
                          )
                        ],
                      );
                    }
                  } else {
                    return const Center(child: Text("No data"));
                  }
                })));
  }
}
