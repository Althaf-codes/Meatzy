// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../Constants/Global_Variables.dart';
import '../../../Model/user_model.dart';
import '../../../Widget/horizontal_text_widget.dart';

class MeatDeliveredOrderScreen extends StatelessWidget {
  List<UserMeatOrder> usermeatorders;

  MeatDeliveredOrderScreen({
    Key? key,
    required this.usermeatorders,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("Total Count : ",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    )),
                const SizedBox(
                  width: 4,
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    '${usermeatorders.length} ',
                    style: const TextStyle(
                      color: Colors.green, //Color.fromARGB(255, 131, 130, 130),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: usermeatorders.length,
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
                                    color:
                                        GlobalVariables.selectedNavBarColor)),
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
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                  Icons.error,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
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
                                          color: GlobalVariables
                                              .selectedNavBarColor,
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
                                          color: GlobalVariables
                                              .selectedNavBarColor,
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
              }),
        ],
      ),
    ));
  }
}
