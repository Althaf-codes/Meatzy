// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meatzy_app/Model/livestock_model.dart';

import '../../Constants/Global_Variables.dart';
import '../../Widget/horizontal_text_widget.dart';

class LiveStockCartScreen extends StatefulWidget {
  List<LiveStockDetails> allLiveStocks;
  LiveStockCartScreen({
    Key? key,
    required this.allLiveStocks,
  }) : super(key: key);

  @override
  State<LiveStockCartScreen> createState() => _LiveStockCartScreenState();
}

class _LiveStockCartScreenState extends State<LiveStockCartScreen> {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: GlobalVariables.secondaryColor,
        //   title: Text(
        //     'My Cart',
        //     style: TextStyle(color: Colors.white),
        //   ),
        // ),
        body:
            // StreamBuilder<List>(
            //     stream: UserFirebaseService(
            //             user: Provider.of<User>(context, listen: false))
            //         .getallUserCarts(),
            //     builder: (context, snapshot) {
            //       print("it crossed builder");
            //       print("the builder nap is ${snapshot.data}");
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return Center(
            //             child: CircularProgressIndicator(
            //           color: GlobalVariables.selectedNavBarColor,
            //         ));
            //       }
            //       if (snapshot.hasError) {
            //         return const Center(child: Text("Error Occured"));
            //       }
            //       if (!snapshot.hasData) {
            //         return const Center(
            //           child: Text(
            //             "No products",
            //           ),
            //         );
            //       }
            //       if (snapshot.hasData) {
            //         print("the stream data is ${snapshot.data}");
            //         List<MeatCart>? cartlist = snapshot.data!.reversed.toList();
            //  print("the user model is ${userModel}");

            // // List<Cart> cartlist = userModel!.cart;
            // print('//////////////////');
            // print("the cart list is ${cartlist[0].description}");
            // print('//////////////////');

            // return
            SingleChildScrollView(
      controller: _scrollController,
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
                    '${widget.allLiveStocks.length} ',
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
              itemCount: widget.allLiveStocks.length,
              itemBuilder: (context, index) {
                LiveStockDetails cartdata = widget.allLiveStocks[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      // UserFirebaseService(
                      //         user: Provider.of<User>(context,
                      //             listen: false))
                      //     .addTestSubcollection(
                      //         cartdata.productId, cartdata.toMap());

                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: ((context) =>
                      //             DetailedCartViewScreen(
                      //                 sellerId: cartdata.,
                      //                 productId: cartdata.productId)
                      //                 )));
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
                                imageUrl: cartdata.images![0],
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
                                  children: [
                                    Text(
                                      cartdata.liveStockType.toString(),
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: GlobalVariables
                                              .selectedNavBarColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      cartdata.description.toString(),
                                      maxLines: 2,
                                      style: const TextStyle(
                                          color: GlobalVariables.secondaryColor,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    // RatingBarIndicator(
                                    //   textDirection: TextDirection.ltr,
                                    //   rating: cartdata.ratings.toDouble(),
                                    //   itemBuilder: (context, index) =>
                                    //       const Icon(
                                    //     Icons.star,
                                    //     color: Colors.amber,
                                    //   ),
                                    //   itemCount: 5,
                                    //   itemSize: 15.0,
                                    //   direction: Axis.horizontal,
                                    // ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    HorizontalTitleText(
                                        title: "Price",
                                        text:
                                            '₹ ${cartdata.priceQuoted.toString()}',
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
    //   } else {
    //     return const Center(child: Text("No data"));
    //   }
    // }));
  }
}
