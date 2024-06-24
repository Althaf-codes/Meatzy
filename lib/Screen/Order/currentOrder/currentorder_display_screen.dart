// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meatzy_app/Screen/Order/currentOrder/meat_currentorder_screen.dart';

import '../../../Constants/Global_Variables.dart';
import '../../../Model/user_model.dart';
import '../../../Widget/sliverAppbar.dart';
import 'livestock_currentorder_screen.dart';

class CurrentOrderDisplay extends StatefulWidget {
  List<UserLiveStockOrder> userlivestockorders;
  List<UserMeatOrder> usermeatorders;
  CurrentOrderDisplay({
    Key? key,
    required this.userlivestockorders,
    required this.usermeatorders,
  }) : super(key: key);

  @override
  State<CurrentOrderDisplay> createState() => _CurrentOrderDisplayState();
}

class _CurrentOrderDisplayState extends State<CurrentOrderDisplay>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = new TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 1,
        length: 4,
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                bottom: PreferredSize(
                  preferredSize: Size(double.infinity, 20),
                  child: TabBar(
                      controller: _tabController,
                      labelColor: GlobalVariables.selectedNavBarColor,
                      labelStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1),
                      unselectedLabelStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1),
                      unselectedLabelColor: Colors.grey[350],
                      indicatorWeight: 3,
                      isScrollable: true,
                      indicatorColor: Colors.black,
                      tabs: const [
                        Tab(
                          icon: Icon(FontAwesomeIcons.cow),
                          text: 'Meat',
                        ),
                        Tab(
                          icon: Icon(FontAwesomeIcons.bullhorn),
                          text: 'LiveStock',
                        ),
                        Tab(
                          icon: Icon(FontAwesomeIcons.bullhorn),
                          text: 'Accessories',
                        ),
                        Tab(
                          icon: Icon(FontAwesomeIcons.bullhorn),
                          text: 'Medicine',
                        ),
                      ]),
                )),
            body: widget.usermeatorders.isEmpty &&
                    widget.userlivestockorders.isEmpty
                ? Center(
                    child: Column(
                      children: [
                        Text(
                          'No Orders Yet',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2),
                        ),
                        Text('Hurry!! Grab your Qurban at amazing offers!!!',
                            style: TextStyle(
                                color: GlobalVariables.selectedNavBarColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1)),
                      ],
                    ),
                  )
                : TabBarView(
                    clipBehavior: Clip.none,
                    controller: _tabController,
                    children: [
                      widget.usermeatorders.isEmpty
                          ? const Center(
                              child: Text('No Orders yet..'),
                            )
                          : MeatCurrentOrderScreen(
                              usermeatorders: widget.usermeatorders,
                            ),
                      widget.userlivestockorders.isEmpty
                          ? const Center(
                              child: Text('No Orders yet..'),
                            )
                          : LiveStockCurrentOrderScreen(
                              userlivestockorders: widget.userlivestockorders),
                      const Center(
                        child: Text("TAB 3"),
                      ),
                      const Center(
                        child: Text("TAB 4"),
                      )
                    ],
                  )));
  }
}

// body: StreamBuilder<List<Order>>(
//     stream: UserFirebaseService(
//             user: Provider.of<User>(context, listen: false))
//         .getAllUserOrder(),
//     builder: (context, snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return Center(
//             child: CircularProgressIndicator(
//           color: GlobalVariables.selectedNavBarColor,
//         ));
//       }
//       if (snapshot.hasError) {
//         print("the error is ${snapshot.error}");
//         return const Center(child: Text("Error Occured"));
//       }
//       if (!snapshot.hasData) {
//         return const Center(
//           child: Text(
//             "No Orders Yet",
//           ),
//         );
//       }
//       if (snapshot.hasData) {
//         print("the stream data is ${snapshot.data}");
//         List<Order>? allOrders = snapshot.data!.reversed.toList();

//         print('//////////////////');
//         print("the all orders length is ${allOrders.length} ");
//         print('//////////////////');

//         if (allOrders.isEmpty) {
//           return Center(
//             child: Text(
//               "You Haven't Ordered Yet",
//             ),
//           );
//         } else {
// return

/*ListView.builder(
            itemCount: usermeatorders!.length,
            itemBuilder: (context, index) {
              UserMeatOrder orderdata = usermeatorders[index];

              return
                  //  orderdata.orderStatus != "Order Delivered"
                  // ?
                  Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    print(
                        "the orderID in orderdiplaycreen is ${orderdata.orderId}");
                    // UserFirebaseService(

                    //         user: Provider.of<User>(context,
                    //             listen: false))
                    //     .addTestSubcollection(orderdata.orderId,
                    //         orderdata.toMap());

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: ((context) =>

                    //             DetailedProductViewScreen(product: product)
                    //             )));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: GlobalVariables.selectedNavBarColor,
                            width: 2),
                        // color: Color.fromARGB(255, 0, 42, 22),
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        // CachedNetworkImage(
                        //   imageUrl:
                        //       "https://media.istockphoto.com/photos/variety-of-raw-black-angus-prime-meat-steaks-picture-id923692030?k=20&m=923692030&s=612x612&w=0&h=k-b2wtmHwBbpmSM74dN0gZzRD9oEwBUYiXdlWYD6mHY=",
                        //   imageBuilder: (context, imageProvider) => Container(
                        //     height: MediaQuery.of(context).size.height * 0.3,
                        //     width: MediaQuery.of(context).size.width * 0.42,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.only(
                        //           topLeft: Radius.circular(12),
                        //           bottomLeft: Radius.circular(12)),
                        //       image: DecorationImage(
                        //         image: imageProvider,
                        //         fit: BoxFit.cover,
                        //       ),
                        //     ),
                        //   ),
                        //   placeholder: (context, url) =>
                        //       CircularProgressIndicator(),
                        //   errorWidget: (context, url, error) =>
                        //       Icon(Icons.error),
                        // ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.43,
                          // padding: EdgeInsets.only(left: 1),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomLeft: Radius.circular(12)),
                              border: Border.all(
                                  color: GlobalVariables.selectedNavBarColor)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                bottomLeft: Radius.circular(12)),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: orderdata.ordershopimage,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(
                                  color: GlobalVariables.secondaryColor,
                                ),
                              ),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.error,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: MediaQuery.of(context).size.width * 0.5,
                              padding: EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                  // color: Colors.blue,

                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(12),
                                      bottomRight: Radius.circular(12))),
                              child: Column(
                                // crossAxisAlignment:
                                //     CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Ordered Quantity :",
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color:
                                            GlobalVariables.selectedNavBarColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${orderdata.quantityInKg.toString()} KG',
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: GlobalVariables.secondaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),

                                  Text(
                                    "Order Status :",
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color:
                                            GlobalVariables.selectedNavBarColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),

                                  Text(
                                    orderdata.orderStatus,
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: orderdata.orderStatus ==
                                                "Order Placed"
                                            ? GlobalVariables.secondaryColor
                                            : orderdata.orderStatus ==
                                                    "Order Request"
                                                ? Colors.orange
                                                : orderdata.orderStatus ==
                                                        "Order Shipped"
                                                    ? GlobalVariables
                                                        .selectedNavBarColor
                                                    : orderdata.orderStatus ==
                                                            "Order Declined"
                                                        ? Colors.red
                                                        : Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  // RatingBarIndicator(
                                  //   textDirection: TextDirection.ltr,
                                  //   rating:
                                  //       orderdata.discountPercentage.t,
                                  //   itemBuilder: (context, index) =>
                                  //       const Icon(
                                  //     Icons.star,
                                  //     color: Colors.amber,
                                  //   ),
                                  //   itemCount: 5,
                                  //   itemSize: 10.0,
                                  //   direction: Axis.horizontal,
                                  // ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  HorizontalTitleText(
                                      title: "Price",
                                      text:
                                          '₹ ${orderdata.orderprice.toString()}',
                                      maxline: 1)
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              );
            })
    */
