import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meatzy_app/Model/livestock_model.dart';
import 'package:meatzy_app/Service/user_firebase_service.dart';
import 'package:provider/provider.dart';

import '../../Constants/Global_Variables.dart';
import '../../Model/user_model.dart';
import '../../Widget/sliverAppbar.dart';
import 'livestock_cart_view.dart';
import 'meat_cart_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                sliverAppBar(context,
                    title: '',
                    icon1: IconButton(
                      onPressed: () {
                        // showSearch(context: context, delegate: MySearchDelegate());
                      },
                      icon: const Icon(Icons.search,
                          color: Colors.black, size: 25),
                    ),
                    flexibleChild:
                        const TabBar(indicatorColor: Colors.black, tabs: [
                      Tab(
                        icon: Icon(FontAwesomeIcons.cow),
                        text: 'Meat',
                      ),
                      Tab(
                        icon: Icon(FontAwesomeIcons.bullhorn),
                        text: 'LiveStock',
                      ),
                    ]))
              ];
            },
            body: StreamBuilder<List<QueryDocumentSnapshot>>(
                stream: UserFirebaseService(
                        user: Provider.of<User>(context, listen: false))
                    .getallUserCarts(),
                builder: (context, snapshot) {
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
                    List<QueryDocumentSnapshot> allCarts =
                        snapshot.data!.toList();

                    print('//////////////////');
                    print("the all orders length is ${allCarts.length} ");
                    print('//////////////////');
                    print("the data is ${allCarts[2].data()}");

                    if (allCarts.isEmpty) {
                      return const Center(
                        child: Text(
                          "Your Cart is Empty ",
                        ),
                      );
                    } else {
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
                          MeatCartScreen(
                            meatcart: allCarts
                                .where(
                                    (element) => element["cartType"] == "meat")
                                .map((e) => MeatCart.fromdocumentsnap(e))
                                .toList(),
                          ),
                          LiveStockCartScreen(
                            allLiveStocks: allCarts
                                .where((element) =>
                                    element["cartType"] == "livestock")
                                .map((e) => LiveStockDetails.fromMap(e))
                                .toList(),
                          )
                        ],
                      );
                    }
                  } else {
                    return const Center(child: Text("No data"));
                  }
                })),
      ),
    );
  }
}
