import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:meatzy_app/Model/livestock_model.dart';
import 'package:meatzy_app/Model/meat_seller_model.dart';
import 'package:meatzy_app/Model/user_model.dart';
import 'package:meatzy_app/Provider/user_provider.dart';
import 'package:meatzy_app/Screen/Home/screen/shop_view_screen.dart';
import 'package:meatzy_app/Service/user_firebase_service.dart';
import 'package:meatzy_app/Widget/category_list.dart';
import 'package:meatzy_app/Widget/home_carousel.dart';

import 'package:provider/provider.dart';

import '../../../Constants/Global_Variables.dart';
import '../../../Constants/Utils.dart';
import '../../../Widget/horizontal_text_widget.dart';
import '../../../Widget/notificationWidget.dart';
import '../../../Widget/searchbar_homescreen.dart';
import '../../../Widget/sliverAppbar.dart';
import '../../Notification/notification_screen.dart';
import '../detailed_livestock_product_screen.dart';

// import '../../../Widgets/EssentialWidgets.dart';
// import '../../../Widgets/carousel_widget.dart';
// import '../../../Widgets/categoryList.dart';
// import '../../../Widgets/similarProduct_widget.dart';
// import '../../../Widgets/sliverAppbar.dart';
// import '../../../Widgets/specialOfferWidget.dart';
// import '../../../Widgets/sponsored_imageList.dart';
// import '../../../Widgets/topDeals.dart';

class HomeScreen extends StatelessWidget {
  ScrollController controller;
  HomeScreen({Key? key, required this.controller}) : super(key: key);

  static const String _route = '/Home';

  static get route => _route;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      //controller: controller,
      floatHeaderSlivers: true,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          sliverAppBar(
            context,
            isSecondIcon: true,
            icon1: StreamBuilder<UserModel>(
              stream: UserFirebaseService(
                      user: Provider.of<User>(context, listen: false))
                  .getuserdata(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: GlobalVariables.selectedNavBarColor,
                  ));
                }
                if (snapshot.hasError) {
                  return notificationWidget(
                      text: '0',
                      ontap: () {
                        showSnackBar(context, 'Error occurred');
                      });
                  ;
                }
                if (!snapshot.hasData) {
                  return notificationWidget(
                      text: '0',
                      ontap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    NotificationScreen(notification: []))));
                      });
                }
                if (snapshot.hasData) {
                  UserModel? usermodel = snapshot.data;
                  List<UserNotification>? notification =
                      usermodel!.notifications;
                  //  List<Product>? sellerproducts = usermodel.;

                  return notificationWidget(
                      text: usermodel.notifications.length.toString(),
                      ontap: () async {
                        await UserFirebaseService(
                                user: Provider.of<User>(context, listen: false))
                            .testgetAllUserOrder();

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: ((context) => NotificationScreen(
                        //             notification: notification))));
                      });
                } else {
                  return Container();
                }
              },
            ),
            flexibleChild: searchBar(context, () {}),
          )
        ];
      },
      body: SingleChildScrollView(

          ///controller: controller,
          //  clipBehavior: Clip.none,
          child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12, top: 10),
                child: CategoryList(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Sponsored ",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        wordSpacing: 1,
                        letterSpacing: 1,
                        color: GlobalVariables.selectedNavBarColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: HomeCarousel()),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8.0),
                child: Text(
                  "Qurbani Specials",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      wordSpacing: 1,
                      letterSpacing: 1,
                      color: GlobalVariables.selectedNavBarColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          StreamBuilder<List<LiveStockDetails>>(
            initialData: null,
            stream: UserFirebaseService(
                    user: Provider.of<User>(context, listen: false))
                .getallLiveStockDetails(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  color: GlobalVariables.selectedNavBarColor,
                ));
              }
              if (snapshot.hasError) {
                return const Center(child: Text("Error Occured"));
              }
              if (!snapshot.hasData) {
                return const Center(
                  child: Text(
                    "No products",
                  ),
                );
              }
              if (snapshot.hasData) {
                List<LiveStockDetails> allLiveStockDetails = snapshot.data;

                // print("allprodcts in f builder is ${allDocumentSnap.length}");

                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    controller: controller,
                    shrinkWrap: true,
                    itemCount: allLiveStockDetails.length,
                    itemBuilder: (context, index) {
                      LiveStockDetails liveStockDetails =
                          allLiveStockDetails[index];

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        DetailedLiveStockProductViewScreen(
                                            liveStockDetails:
                                                liveStockDetails))));
                          },
                          child: liveStockDetails.isSold!
                              ? Banner(
                                  message: 'Sold Out',
                                  color: Colors.red,
                                  location: BannerLocation.topEnd,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: GlobalVariables
                                              .selectedNavBarColor,
                                          width: 1.5,
                                        ),
                                        // color: Color.fromARGB(255, 0, 42, 22),
                                        borderRadius:
                                            BorderRadius.circular(12)),
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
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.43,
                                          // padding: EdgeInsets.only(left: 1),
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(12),
                                                    bottomLeft:
                                                        Radius.circular(12)),
                                            // border: Border.all(
                                            //   color:
                                            //       GlobalVariables.selectedNavBarColor,
                                            // ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(12),
                                                bottomLeft:
                                                    Radius.circular(12)),
                                            child: CachedNetworkImage(
                                              height: 40,
                                              width: 40,
                                              fit: BoxFit.cover,
                                              imageUrl:
                                                  liveStockDetails.images![0],
                                              placeholder: (context, url) =>
                                                  const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: GlobalVariables
                                                      .secondaryColor,
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(
                                                Icons.error,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.3,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              padding: EdgeInsets.all(8),
                                              decoration: const BoxDecoration(
                                                  // color: Colors.blue,

                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  12),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  12))),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    liveStockDetails
                                                        .liveStockType
                                                        .toString()
                                                        .toUpperCase(),
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        color: GlobalVariables
                                                            .selectedNavBarColor,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  ),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    liveStockDetails
                                                            .description ??
                                                        '',
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        color: GlobalVariables
                                                            .selectedNavBarColor
                                                            .withOpacity(0.4),
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  ),
                                                  // RatingBarIndicator(
                                                  //   textDirection: TextDirection.ltr,
                                                  //   rating:
                                                  //       liveStockDetails.ratings.toDouble(),
                                                  //   itemBuilder: (context, index) =>
                                                  //       const Icon(
                                                  //     Icons.star,
                                                  //     color: Colors.amber,
                                                  //   ),
                                                  //   itemCount: 5,
                                                  //   itemSize: 10.0,
                                                  //   direction: Axis.horizontal,
                                                  // ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      const Text(
                                                          "Approx Weight  : ",
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          )),
                                                      const SizedBox(
                                                        width: 4,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2.0),
                                                        child: Text(
                                                          '${liveStockDetails.approxLiveStockKg.toString()} KG',
                                                          style:
                                                              const TextStyle(
                                                            color: Colors
                                                                .green, //Color.fromARGB(255, 131, 130, 130),
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      const Text("Age  : ",
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          )),
                                                      const SizedBox(
                                                        width: 4,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2.0),
                                                        child: Text(
                                                          ' ${liveStockDetails.age.toString()}',
                                                          style:
                                                              const TextStyle(
                                                            color: Colors
                                                                .green, //Color.fromARGB(255, 131, 130, 130),
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  const Spacer(),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      const Text("Price  : ",
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          )),
                                                      const SizedBox(
                                                        width: 4,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2.0),
                                                        child: Text(
                                                          '₹ ${liveStockDetails.priceQuoted.toString()}',
                                                          style:
                                                              const TextStyle(
                                                            color: Colors
                                                                .green, //Color.fromARGB(255, 131, 130, 130),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  // Align(
                                                  //   alignment: Alignment.bottomRight,
                                                  //   child: HorizontalTitleText(
                                                  //       title: "Price",
                                                  //       text:
                                                  //           '₹ ${liveStockDetails.priceQuoted.toString()}',
                                                  //       maxline: 1),
                                                  // )
                                                ],
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color:
                                            GlobalVariables.selectedNavBarColor,
                                        width: 1.5,
                                      ),
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
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.43,
                                        // padding: EdgeInsets.only(left: 1),
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(12),
                                              bottomLeft: Radius.circular(12)),
                                          // border: Border.all(
                                          //   color:
                                          //       GlobalVariables.selectedNavBarColor,
                                          // ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(12),
                                              bottomLeft: Radius.circular(12)),
                                          child: CachedNetworkImage(
                                            height: 40,
                                            width: 40,
                                            fit: BoxFit.cover,
                                            imageUrl:
                                                liveStockDetails.images![0],
                                            placeholder: (context, url) =>
                                                const Center(
                                              child: CircularProgressIndicator(
                                                color: GlobalVariables
                                                    .secondaryColor,
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(
                                              Icons.error,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.3,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            padding: EdgeInsets.all(8),
                                            decoration: const BoxDecoration(
                                                // color: Colors.blue,

                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(12),
                                                    bottomRight:
                                                        Radius.circular(12))),
                                            child: Column(
                                              children: [
                                                Text(
                                                  liveStockDetails.liveStockType
                                                      .toString()
                                                      .toUpperCase(),
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color: GlobalVariables
                                                          .selectedNavBarColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  liveStockDetails
                                                          .description ??
                                                      '',
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      color: GlobalVariables
                                                          .selectedNavBarColor
                                                          .withOpacity(0.4),
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ),
                                                // RatingBarIndicator(
                                                //   textDirection: TextDirection.ltr,
                                                //   rating:
                                                //       liveStockDetails.ratings.toDouble(),
                                                //   itemBuilder: (context, index) =>
                                                //       const Icon(
                                                //     Icons.star,
                                                //     color: Colors.amber,
                                                //   ),
                                                //   itemCount: 5,
                                                //   itemSize: 10.0,
                                                //   direction: Axis.horizontal,
                                                // ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                        "Approx Weight  : ",
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        )),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      child: Text(
                                                        '${liveStockDetails.approxLiveStockKg.toString()} KG',
                                                        style: const TextStyle(
                                                          color: Colors
                                                              .green, //Color.fromARGB(255, 131, 130, 130),
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    const Text("Age  : ",
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        )),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      child: Text(
                                                        ' ${liveStockDetails.age.toString()}',
                                                        style: const TextStyle(
                                                          color: Colors
                                                              .green, //Color.fromARGB(255, 131, 130, 130),
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                const Spacer(),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    const Text("Price  : ",
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        )),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      child: Text(
                                                        '₹ ${liveStockDetails.priceQuoted.toString()}',
                                                        style: const TextStyle(
                                                          color: Colors
                                                              .green, //Color.fromARGB(255, 131, 130, 130),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                // Align(
                                                //   alignment: Alignment.bottomRight,
                                                //   child: HorizontalTitleText(
                                                //       title: "Price",
                                                //       text:
                                                //           '₹ ${liveStockDetails.priceQuoted.toString()}',
                                                //       maxline: 1),
                                                // )
                                              ],
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                        ),
                      );
                    });
              }
              return const Center(child: Text("Please wait"));
            },
          ),
          const SizedBox(
            height: 15,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, left: 8.0),
              child: Text(
                "All Meat Shops",
                textAlign: TextAlign.left,
                style: TextStyle(
                    wordSpacing: 1,
                    letterSpacing: 1,
                    color: GlobalVariables.selectedNavBarColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 15),
          // StreamBuilder<List<DocumentSnapshot>>(
          //   initialData: null,
          //   stream: UserFirebaseService(
          //           user: Provider.of<User>(context, listen: false))
          //       .getAllMeatSeller(),
          //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return Center(
          //           child: CircularProgressIndicator(
          //         color: GlobalVariables.selectedNavBarColor,
          //       ));
          //     }
          //     if (snapshot.hasError) {
          //       return const Center(child: Text("Error Occured"));
          //     }
          //     if (!snapshot.hasData) {
          //       return const Center(
          //         child: Text(
          //           "No products",
          //         ),
          //       );
          //     }
          //     if (snapshot.hasData) {
          //       List<DocumentSnapshot> allDocumentSnap = snapshot.data;

          //       print("allprodcts in f builder is ${allDocumentSnap.length}");

          //       return ListView.builder(
          //           scrollDirection: Axis.vertical,
          //           controller: controller,
          //           shrinkWrap: true,
          //           itemCount: allDocumentSnap.length,
          //           itemBuilder: (context, index) {
          //             print("the alldocumentsnap is ${allDocumentSnap.length}");
          //             DocumentSnapshot documentSnapshot =
          //                 allDocumentSnap[index];
          //             var docId = documentSnapshot.id;
          //             MeatSellerModel singleShop =
          //                 MeatSellerModel.fromMap(documentSnapshot);
          //             print('///////////');
          //             print("the length is ${allDocumentSnap.length}");
          //             print("the index is ${index}");

          //             print("singleshop is ${singleShop.sellerName}");
          //             print('///////////');

          //             return Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: GestureDetector(
          //                 onTap: () {
          //                   //  print('the singleShop is ${singleShop}');

          //                   Navigator.push(
          //                       context,
          //                       MaterialPageRoute(
          //                           builder: ((context) => ShopViewScreen(
          //                                 shopAddress:
          //                                     singleShop.location!.address,
          //                                 docId: docId,
          //                               ))));
          //                 },
          //                 child: Container(
          //                   height: MediaQuery.of(context).size.height * 0.3,
          //                   width: MediaQuery.of(context).size.width * 0.9,
          //                   decoration: BoxDecoration(
          //                       border: Border.all(
          //                           color: GlobalVariables.selectedNavBarColor,
          //                           width: 2),
          //                       // color: Color.fromARGB(255, 0, 42, 22),
          //                       borderRadius: BorderRadius.circular(12)),
          //                   child: Row(
          //                     children: [
          //                       // CachedNetworkImage(
          //                       //   imageUrl:
          //                       //       "https://media.istockphoto.com/photos/variety-of-raw-black-angus-prime-meat-steaks-picture-id923692030?k=20&m=923692030&s=612x612&w=0&h=k-b2wtmHwBbpmSM74dN0gZzRD9oEwBUYiXdlWYD6mHY=",
          //                       //   imageBuilder: (context, imageProvider) => Container(
          //                       //     height: MediaQuery.of(context).size.height * 0.3,
          //                       //     width: MediaQuery.of(context).size.width * 0.42,
          //                       //     decoration: BoxDecoration(
          //                       //       borderRadius: BorderRadius.only(
          //                       //           topLeft: Radius.circular(12),
          //                       //           bottomLeft: Radius.circular(12)),
          //                       //       image: DecorationImage(
          //                       //         image: imageProvider,
          //                       //         fit: BoxFit.cover,
          //                       //       ),
          //                       //     ),
          //                       //   ),
          //                       //   placeholder: (context, url) =>
          //                       //       CircularProgressIndicator(),
          //                       //   errorWidget: (context, url, error) =>
          //                       //       Icon(Icons.error),
          //                       // ),
          //                       Container(
          //                         height:
          //                             MediaQuery.of(context).size.height * 0.3,
          //                         width:
          //                             MediaQuery.of(context).size.width * 0.43,
          //                         // padding: EdgeInsets.only(left: 1),
          //                         decoration: BoxDecoration(
          //                             color: Colors.grey,
          //                             borderRadius: const BorderRadius.only(
          //                                 topLeft: Radius.circular(12),
          //                                 bottomLeft: Radius.circular(12)),
          //                             border: Border.all(
          //                                 color: GlobalVariables
          //                                     .selectedNavBarColor)),
          //                         child: ClipRRect(
          //                           borderRadius: BorderRadius.only(
          //                               topLeft: Radius.circular(12),
          //                               bottomLeft: Radius.circular(12)),
          //                           child: CachedNetworkImage(
          //                             fit: BoxFit.cover,
          //                             imageUrl: singleShop.shopImage ?? '',
          //                             //singleShop['shopimage'], //product.images[0]??'',
          //                             placeholder: (context, url) =>
          //                                 const Center(
          //                               child: CircularProgressIndicator(
          //                                 color: GlobalVariables.secondaryColor,
          //                               ),
          //                             ),
          //                             errorWidget: (context, url, error) =>
          //                                 const Icon(
          //                               Icons.error,
          //                               color: Colors.grey,
          //                             ),
          //                           ),
          //                         ),
          //                       ),
          //                       Expanded(
          //                         child: Container(
          //                             height:
          //                                 MediaQuery.of(context).size.height *
          //                                     0.3,
          //                             width: MediaQuery.of(context).size.width *
          //                                 0.5,
          //                             padding: EdgeInsets.all(8),
          //                             decoration: const BoxDecoration(
          //                                 // color: Colors.blue,

          //                                 borderRadius: BorderRadius.only(
          //                                     topRight: Radius.circular(12),
          //                                     bottomRight:
          //                                         Radius.circular(12))),
          //                             child: Column(
          //                               children: [
          //                                 Text(
          //                                   singleShop.meatShopName ?? '',
          //                                   // singleShop['meatShopName'] ?? '',
          //                                   // product.productName,
          //                                   maxLines: 1,
          //                                   style: TextStyle(
          //                                       color: GlobalVariables
          //                                           .selectedNavBarColor,
          //                                       fontSize: 16,
          //                                       fontWeight: FontWeight.w600,
          //                                       overflow:
          //                                           TextOverflow.ellipsis),
          //                                 ),
          //                                 Padding(
          //                                   padding: const EdgeInsets.only(
          //                                       top: 3.0, bottom: 3),
          //                                   child: Row(
          //                                     mainAxisAlignment:
          //                                         MainAxisAlignment.start,
          //                                     children: [
          //                                       Text('Address : '),
          //                                       Expanded(
          //                                         child: Text(
          //                                           singleShop.location!.address
          //                                                   .toString() ??
          //                                               '',
          //                                           //product.description,
          //                                           maxLines: 3,
          //                                           style: const TextStyle(
          //                                               color: GlobalVariables
          //                                                   .secondaryColor,
          //                                               fontSize: 13,
          //                                               fontWeight:
          //                                                   FontWeight.w300,
          //                                               overflow: TextOverflow
          //                                                   .ellipsis),
          //                                         ),
          //                                       ),
          //                                     ],
          //                                   ),
          //                                 ),
          //                                 RatingBarIndicator(
          //                                   textDirection: TextDirection.ltr,
          //                                   rating: double.parse(
          //                                       singleShop.ratings.toString()),
          //                                   //product.ratings.toDouble(),
          //                                   itemBuilder: (context, index) =>
          //                                       const Icon(
          //                                     Icons.star,
          //                                     color: Colors.amber,
          //                                   ),
          //                                   itemCount: 5,
          //                                   itemSize: 15.0,
          //                                   direction: Axis.horizontal,
          //                                 ),
          //                                 SizedBox(
          //                                   height: 5,
          //                                 ),
          //                                 HorizontalTitleText(
          //                                     title: "Prices from",
          //                                     text: index == 0
          //                                         ? '399'
          //                                         : index == 1
          //                                             ? '400'
          //                                             : '499',
          //                                     //     '0',
          //                                     // '${singleShop["products"][0]["pricePerKg"] ?? 0}',
          //                                     // '₹ ${product.pricePerKg.toString()}',
          //                                     maxline: 1),
          //                                 SizedBox(
          //                                   height: 10,
          //                                 ),
          //                                 Align(
          //                                   alignment: Alignment.center,
          //                                   child: ElevatedButton.icon(
          //                                       style: ElevatedButton.styleFrom(
          //                                           backgroundColor:
          //                                               GlobalVariables
          //                                                   .selectedNavBarColor),
          //                                       onPressed: () {
          //                                         Navigator.push(
          //                                             context,
          //                                             MaterialPageRoute(
          //                                                 builder: ((context) =>
          //                                                     ShopViewScreen(
          //                                                       shopAddress:
          //                                                           singleShop
          //                                                               .location!
          //                                                               .address,
          //                                                       docId: docId,
          //                                                     ))));
          //                                       },
          //                                       icon: Icon(Icons.ads_click),
          //                                       label: Text(
          //                                         "View Shop",
          //                                         style: TextStyle(
          //                                             color: Colors.white),
          //                                       )),
          //                                 )
          //                               ],
          //                             )),
          //                       )
          //                     ],
          //                   ),
          //                 ),
          //               ),
          //             );
          //           });
          //     }
          //     return const Center(child: Text("Please wait"));
          //   },
          // ),
        ],
      )),
    ));
  }
}

//  NestedScrollView(
//       //controller: controller,
//       floatHeaderSlivers: true,
//       headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//         return [
//           sliverAppBar(context,
//               isSecondIcon: true,
//               icon1: notificationWidget('1', () {}),
//               flexibleChild: IconButton(
//                 icon: Icon(Icons.logout),
//                 onPressed: (() async {
//                   await context.read<FirebaseAuthMethods>().signOut(context);
//                 }),
//               )),
//         ];
//       },
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             //Padding(
//             //   padding: const EdgeInsets.only(left: 12.0, right: 12, top: 10),
//             //   child: CategoryList(),
//             // ),
//             // Container(
//             //     height: 200,
//             //     width: MediaQuery.of(context).size.width,
//             //     child: CarouselWidget()),
//             // Padding(
//             //   padding: const EdgeInsets.all(8.0),
//             //   child: SponsoredImageList(),
//             // ),
//             // Padding(
//             //   padding: const EdgeInsets.all(8.0),
//             //   child: TopDealWidget(),
//             // ),
//             // Padding(
//             //   padding: const EdgeInsets.all(8.0),
//             //   child: SimilarProductWidget(),
//             // ),
//             // Padding(
//             //   padding: const EdgeInsets.all(8.0),
//             //   child: SpecialOfferWidget(),
//             // ),
//             // SizedBox(
//             //   height: 500,
//             // )
//           ],
//         ),
//       ),
//    ));










    //  for (int i = 0; i < allDocumentSnap.length; i++) {
    //                     DocumentSnapshot documentSnapshot =
    //                         allDocumentSnap[index];
    //                     var docId = documentSnapshot.id;
    //                     MeatSellerModel singleShop =
    //                         MeatSellerModel.fromMap(documentSnapshot);
    //                     print('///////////');
    //                     print("singleshop is ${singleShop.sellerName}");
    //                     print('///////////');

    //                     return Padding(
    //                       padding: const EdgeInsets.all(8.0),
    //                       child: GestureDetector(
    //                         onTap: () {
    //                           //  print('the singleShop is ${singleShop}');

    //                           Navigator.push(
    //                               context,
    //                               MaterialPageRoute(
    //                                   builder: ((context) => ShopViewScreen(
    //                                         docId: docId,
    //                                       ))));
    //                         },
    //                         child: Container(
    //                           height: MediaQuery.of(context).size.height * 0.3,
    //                           width: MediaQuery.of(context).size.width * 0.9,
    //                           decoration: BoxDecoration(
    //                               border: Border.all(
    //                                   color:
    //                                       GlobalVariables.selectedNavBarColor,
    //                                   width: 2),
    //                               // color: Color.fromARGB(255, 0, 42, 22),
    //                               borderRadius: BorderRadius.circular(12)),
    //                           child: Row(
    //                             children: [
    //                               // CachedNetworkImage(
    //                               //   imageUrl:
    //                               //       "https://media.istockphoto.com/photos/variety-of-raw-black-angus-prime-meat-steaks-picture-id923692030?k=20&m=923692030&s=612x612&w=0&h=k-b2wtmHwBbpmSM74dN0gZzRD9oEwBUYiXdlWYD6mHY=",
    //                               //   imageBuilder: (context, imageProvider) => Container(
    //                               //     height: MediaQuery.of(context).size.height * 0.3,
    //                               //     width: MediaQuery.of(context).size.width * 0.42,
    //                               //     decoration: BoxDecoration(
    //                               //       borderRadius: BorderRadius.only(
    //                               //           topLeft: Radius.circular(12),
    //                               //           bottomLeft: Radius.circular(12)),
    //                               //       image: DecorationImage(
    //                               //         image: imageProvider,
    //                               //         fit: BoxFit.cover,
    //                               //       ),
    //                               //     ),
    //                               //   ),
    //                               //   placeholder: (context, url) =>
    //                               //       CircularProgressIndicator(),
    //                               //   errorWidget: (context, url, error) =>
    //                               //       Icon(Icons.error),
    //                               // ),
    //                               Container(
    //                                 height: MediaQuery.of(context).size.height *
    //                                     0.3,
    //                                 width: MediaQuery.of(context).size.width *
    //                                     0.43,
    //                                 // padding: EdgeInsets.only(left: 1),
    //                                 decoration: BoxDecoration(
    //                                     color: Colors.grey,
    //                                     borderRadius: const BorderRadius.only(
    //                                         topLeft: Radius.circular(12),
    //                                         bottomLeft: Radius.circular(12)),
    //                                     border: Border.all(
    //                                         color: GlobalVariables
    //                                             .selectedNavBarColor)),
    //                                 child: ClipRRect(
    //                                   borderRadius: BorderRadius.only(
    //                                       topLeft: Radius.circular(12),
    //                                       bottomLeft: Radius.circular(12)),
    //                                   child: CachedNetworkImage(
    //                                     fit: BoxFit.cover,
    //                                     imageUrl: singleShop.shopImage ??
    //                                         '', //singleShop['shopimage'], //product.images[0]??'',
    //                                     placeholder: (context, url) =>
    //                                         const Center(
    //                                       child: CircularProgressIndicator(
    //                                         color:
    //                                             GlobalVariables.secondaryColor,
    //                                       ),
    //                                     ),
    //                                     errorWidget: (context, url, error) =>
    //                                         const Icon(
    //                                       Icons.error,
    //                                       color: Colors.grey,
    //                                     ),
    //                                   ),
    //                                 ),
    //                               ),
    //                               Expanded(
    //                                 child: Container(
    //                                     height:
    //                                         MediaQuery.of(context).size.height *
    //                                             0.3,
    //                                     width:
    //                                         MediaQuery.of(context).size.width *
    //                                             0.5,
    //                                     padding: EdgeInsets.all(8),
    //                                     decoration: const BoxDecoration(
    //                                         // color: Colors.blue,

    //                                         borderRadius: BorderRadius.only(
    //                                             topRight: Radius.circular(12),
    //                                             bottomRight:
    //                                                 Radius.circular(12))),
    //                                     child: Column(
    //                                       children: [
    //                                         Text(
    //                                           singleShop.meatShopName ?? '',
    //                                           // singleShop['meatShopName'] ?? '',
    //                                           // product.productName,
    //                                           maxLines: 1,
    //                                           style: TextStyle(
    //                                               color: GlobalVariables
    //                                                   .selectedNavBarColor,
    //                                               fontSize: 16,
    //                                               fontWeight: FontWeight.w600,
    //                                               overflow:
    //                                                   TextOverflow.ellipsis),
    //                                         ),
    //                                         Text(
    //                                           '',
    //                                           //product.description,
    //                                           maxLines: 2,
    //                                           style: const TextStyle(
    //                                               color: GlobalVariables
    //                                                   .secondaryColor,
    //                                               fontSize: 13,
    //                                               fontWeight: FontWeight.w300,
    //                                               overflow:
    //                                                   TextOverflow.ellipsis),
    //                                         ),
    //                                         RatingBarIndicator(
    //                                           textDirection: TextDirection.ltr,
    //                                           rating: double.parse(singleShop
    //                                               .ratings
    //                                               .toString()),
    //                                           //product.ratings.toDouble(),
    //                                           itemBuilder: (context, index) =>
    //                                               const Icon(
    //                                             Icons.star,
    //                                             color: Colors.amber,
    //                                           ),
    //                                           itemCount: 5,
    //                                           itemSize: 15.0,
    //                                           direction: Axis.horizontal,
    //                                         ),
    //                                         SizedBox(
    //                                           height: 10,
    //                                         ),
    //                                         HorizontalTitleText(
    //                                             title: "Prices from",
    //                                             text: singleShop
    //                                                     .products?[0].pricePerKg
    //                                                     .toString() ??
    //                                                 '0',
    //                                             // '${singleShop["products"][0]["pricePerKg"] ?? 0}',
    //                                             // '₹ ${product.pricePerKg.toString()}',
    //                                             maxline: 1),
    //                                         SizedBox(
    //                                           height: 20,
    //                                         ),
    //                                         Align(
    //                                           alignment: Alignment.center,
    //                                           child: ElevatedButton.icon(
    //                                               style: ElevatedButton.styleFrom(
    //                                                   backgroundColor:
    //                                                       GlobalVariables
    //                                                           .selectedNavBarColor),
    //                                               onPressed: () {
    //                                                 Navigator.push(
    //                                                     context,
    //                                                     MaterialPageRoute(
    //                                                         builder: ((context) =>
    //                                                             ShopViewScreen(
    //                                                               docId: docId,
    //                                                             ))));
    //                                               },
    //                                               icon: Icon(Icons.ads_click),
    //                                               label: Text(
    //                                                 "View Shop",
    //                                                 style: TextStyle(
    //                                                     color: Colors.white),
    //                                               )),
    //                                         )
    //                                       ],
    //                                     )),
    //                               )
    //                             ],
    //                           ),
    //                         ),
    //                       ),
    //                     );
    //                   }