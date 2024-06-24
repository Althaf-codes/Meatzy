// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meatzy_app/Provider/user_provider.dart';
import 'package:meatzy_app/Screen/Checkout/buy_screen.dart';
import 'package:provider/provider.dart';

import '../../../Constants/Global_Variables.dart';
import '../../../Widget/carousel_widget.dart';
import '../../Constants/Utils.dart';
import '../../Model/livestock_model.dart';
import '../../Model/user_model.dart';
import '../../Service/user_firebase_service.dart';
import '../../Widget/notificationWidget.dart';
import '../../Widget/textformfeild_widget.dart';
import '../Cart/cart_screen.dart';

class DetailedLiveStockProductViewScreen extends StatefulWidget {
  LiveStockDetails liveStockDetails;
  DetailedLiveStockProductViewScreen({
    Key? key,
    required this.liveStockDetails,
  }) : super(key: key);

  @override
  State<DetailedLiveStockProductViewScreen> createState() =>
      _DetailedLiveStockProductViewScreenState();
}

class _DetailedLiveStockProductViewScreenState
    extends State<DetailedLiveStockProductViewScreen> {
  TextEditingController addressController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  bool iscattleCare = false;
  bool isOnSpotDelivery = false;
  bool isButcherNeeded = false;
  int sumtotal = 0;
  int deliveryfee = 500;
  late bool isfreedelivery;

  @override
  void dispose() {
    addressController.dispose();
    pincodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isfreedelivery = iscattleCare && isOnSpotDelivery ? true : false;
    print("the delivery fee is ${deliveryfee}");

    ScrollController scrollController = ScrollController();
    const textStyle = TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        wordSpacing: 3);

    const seeAllStyle = TextStyle(
        color: Color.fromARGB(255, 6, 81, 143),
        fontSize: 14,
        fontWeight: FontWeight.w800);
    return Scaffold(
      // appBar: AppBar(
      //     backgroundColor: GlobalVariables.secondaryColor,
      //     leading: IconButton(
      //       icon: Icon(
      //         Icons.arrow_back_ios,
      //         color: Colors.white,
      //       ),
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //     )),

      appBar: AppBar(
        actions: [
          StreamBuilder(
              stream: UserFirebaseService(
                      user: Provider.of<User>(context, listen: false))
                  .getallUserCarts(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: GlobalVariables.selectedNavBarColor,
                  ));
                }
                if (snapshot.hasError) {
                  return cartWidget(
                      text: '',
                      ontap: () {
                        showSnackBar(context, "Error occurred");
                      });
                }
                if (!snapshot.hasData) {
                  cartWidget(
                      text: '0',
                      ontap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: ((context) {
                          return CartScreen();
                        })));
                      });
                }
                if (snapshot.hasData) {
                  // List<MeatCart>? userModel = snapshot.data;

                  List? cartlist = snapshot.data!.toList();
                  return cartWidget(
                      text: cartlist!.length.toString(),
                      ontap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: ((context) {
                          return CartScreen();
                        })));
                      });
                } else {
                  return Container();
                }
              }))
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        backgroundColor: GlobalVariables.secondaryColor,
      ),
      body: ListView(children: [
        Column(
          children: [
            SizedBox(
              height: 20,
            ),
            // Container(
            //   height: 250,
            //   width: MediaQuery.of(context).size.width * 0.9,
            //   child: CarouselSlider(
            //     items: product.images.map(
            //       (i) {
            //         return Builder(
            //           builder: (BuildContext context) => Image.network(
            //             i,
            //             fit: BoxFit.cover,
            //             height: 200,
            //           ),
            //         );
            //       },
            //     ).toList(),
            //     options: CarouselOptions(
            //       enlargeCenterPage: true,
            //       viewportFraction: 1,
            //       height: 200,
            //     ),
            //   ),
            // ),
            Container(
                child:
                    CarouselWidget(imgUrls: widget.liveStockDetails.images!)),
            Container(
              decoration: BoxDecoration(
                color: Colors.white, //Color.fromARGB(255, 175, 217, 252),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      widget.liveStockDetails.liveStockType ?? '',
                      style: textStyle,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Description",
                        style: TextStyle(
                          color: GlobalVariables.selectedNavBarColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: widget.liveStockDetails
                                  .highlightedDescription, //product.highlightedDescription,
                              style: TextStyle(
                                  color: GlobalVariables.selectedNavBarColor,
                                  fontWeight: FontWeight.bold))
                        ],
                        text: widget.liveStockDetails
                            .description, // product.description,
                        style: TextStyle(
                            color: GlobalVariables.selectedNavBarColor,
                            wordSpacing: 2,
                            fontSize: 17,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text("Category  :   ",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                            Expanded(
                              child: Text(
                                  widget.liveStockDetails.liveStockType ??
                                      '', //product.categoryName,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 131, 130, 130),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text("Approx KG :   ",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                            Expanded(
                              child: Text(
                                  widget.liveStockDetails
                                      .approxLiveStockKg, //product.minKg.toString(),
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 131, 130, 130),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text("Age :   ",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                            Expanded(
                              child: Text(
                                  widget.liveStockDetails.age ??
                                      '', //product.maxKg.toString(),
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 131, 130, 130),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text("Bought Price:   ",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                            Expanded(
                              child: Text(
                                  widget.liveStockDetails.boughtPrice
                                      .toString(), //product.maxKgLimitPerDay.toString(),
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 131, 130, 130),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text("Bought Owner Phone.No :   ",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                            Expanded(
                              child: Text(
                                  widget.liveStockDetails.boughtOwnerPhone
                                      .toString(),
                                  //product.isHavingStock == false ? 'NO' : 'Yes',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 131, 130, 130),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text("Bought Owner Name:   ",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                            Expanded(
                              child: Text(
                                  widget.liveStockDetails.boughtOwnerName
                                      .toString(),
                                  //'${product.discountInPercentage.toString()} % off ',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 131, 130, 130),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text("Bought Owner Address:   ",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                            Expanded(
                              child: Text(
                                  widget.liveStockDetails.boughtOwnerAddress
                                      .toString(),
                                  //'${product.discountInPercentage.toString()} % off ',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 131, 130, 130),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text("Is Sold:   ",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                            Expanded(
                              child: Text(
                                  widget.liveStockDetails.isSold!
                                      ? 'Yes'
                                      : 'No',
                                  //'${product.discountInPercentage.toString()} % off ',
                                  style: TextStyle(
                                    color: widget.liveStockDetails.isSold!
                                        ? Colors.green
                                        : Colors.red,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text("Sold Price:   ",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                            Expanded(
                              child: Text(
                                  widget.liveStockDetails.soldPrice.toString(),
                                  //'${product.discountInPercentage.toString()} % off ',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 131, 130, 130),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text("Price Quoted :   ",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                            Row(
                              children: [
                                Text(
                                  "₹",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                    widget.liveStockDetails.priceQuoted
                                        .toString(), //product.pricePerKg.toString(),
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 131, 130, 130),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ))
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const Text("Is Advanced:   ",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                            Expanded(
                              child: Text(
                                  widget.liveStockDetails.isAdvanced!
                                      ? 'Yes'
                                      : 'No',
                                  //'${product.discountInPercentage.toString()} % off ',
                                  style: TextStyle(
                                    color: widget.liveStockDetails.isAdvanced!
                                        ? Colors.green
                                        : Colors.red,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text("Is Fully Paid:   ",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                            Expanded(
                              child: Text(
                                  widget.liveStockDetails.isFullyPaid!
                                      ? 'Yes'
                                      : 'No',
                                  //'${product.discountInPercentage.toString()} % off ',
                                  style: TextStyle(
                                    color: widget.liveStockDetails.isSold!
                                        ? Colors.green
                                        : Colors.red,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const Text("Is Delivered:   ",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                            Expanded(
                              child: Text(
                                  widget.liveStockDetails.isDelivered!
                                      ? 'Yes'
                                      : 'No',
                                  //'${product.discountInPercentage.toString()} % off ',
                                  style: TextStyle(
                                    color: widget.liveStockDetails.isSold!
                                        ? Colors.green
                                        : Colors.red,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const Text("Deadline PayTime:   ",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                            Expanded(
                              child: Text(
                                  widget.liveStockDetails.deadlinePayTime ?? '',
                                  //'${product.discountInPercentage.toString()} % off ',
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 131, 130, 130),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const Text("DeliveryDateAndTime :   ",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                            Expanded(
                              child: Text(
                                  widget.liveStockDetails.deliveryDateAndTime ??
                                      '',
                                  //'${product.discountInPercentage.toString()} % off ',
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 131, 130, 130),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const Text("Delivery Address:   ",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                            Expanded(
                              child: Text(
                                  widget.liveStockDetails.deliveryLocation!
                                      .address,
                                  //'${product.discountInPercentage.toString()} % off ',
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 131, 130, 130),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const Text("Delivery Pincode:   ",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                            Expanded(
                              child: Text(
                                  widget.liveStockDetails.deliveryLocation!
                                      .pincode,
                                  //'${product.discountInPercentage.toString()} % off ',
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 131, 130, 130),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const Text("Delivery Coordinates:   ",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                            Expanded(
                              child: Text('',
                                  // "${liveStockDetails.deliveryLocation!.coordinates[0] ?? ''}, ${liveStockDetails.deliveryLocation!.coordinates[1] ?? ''}",
                                  //'${product.discountInPercentage.toString()} % off ',
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 131, 130, 130),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: [
                    //     ElevatedButton.icon(
                    //         style: ElevatedButton.styleFrom(
                    //             shape: RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(15))),
                    //         onPressed: () {},
                    //         icon: Icon(
                    //           Icons.edit_note_outlined,
                    //           size: 14,
                    //         ),
                    //         label: Text(
                    //           'Edit ',
                    //           style: TextStyle(
                    //               color: Colors.white,
                    //               fontSize: 15,
                    //               fontWeight: FontWeight.w500),
                    //         )),
                    //     ElevatedButton.icon(
                    //         style: ElevatedButton.styleFrom(
                    //             primary: Color.fromARGB(255, 188, 55, 211),
                    //             shape: RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(15))),
                    //         onPressed: () {},
                    //         icon: Icon(
                    //           Icons.discount_outlined,
                    //           size: 14,
                    //         ),
                    //         label: Text(
                    //           'Add Discount',
                    //           style: TextStyle(
                    //               color: Colors.white,
                    //               fontSize: 15,
                    //               fontWeight: FontWeight.w500),
                    //         )),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        widget.liveStockDetails.isSold!
                            ? ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: GlobalVariables
                                        .secondaryColor
                                        .withOpacity(0.4),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                onPressed: () async {
                                  showSnackBar(
                                      context, "Sorry, Already Sold Out");
                                },
                                icon: Icon(
                                  Icons.shopping_cart_outlined,
                                  size: 15,
                                ),
                                label: Text(
                                  'Add To Cart',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ))
                            : ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        GlobalVariables.secondaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                onPressed: () async {
                                  LiveStockDetails liveStockCart = LiveStockDetails(
                                      productId:
                                          widget.liveStockDetails.productId,
                                      age: widget.liveStockDetails.age,
                                      liveStockType:
                                          widget.liveStockDetails.liveStockType,
                                      approxLiveStockKg: widget
                                          .liveStockDetails.approxLiveStockKg,
                                      boughtPrice:
                                          widget.liveStockDetails.boughtPrice,
                                      boughtOwnerPhone: widget
                                          .liveStockDetails.boughtOwnerPhone,
                                      boughtOwnerName: widget
                                          .liveStockDetails.boughtOwnerName,
                                      boughtOwnerAddress: widget
                                          .liveStockDetails.boughtOwnerAddress,
                                      soldPrice:
                                          widget.liveStockDetails.soldPrice,
                                      priceQuoted:
                                          widget.liveStockDetails.priceQuoted,
                                      isFullyPaid:
                                          widget.liveStockDetails.isFullyPaid,
                                      isAdvanced:
                                          widget.liveStockDetails.isAdvanced,
                                      deadlinePayTime: widget
                                          .liveStockDetails.deadlinePayTime,
                                      buyerId: widget.liveStockDetails.buyerId,
                                      orderId: widget.liveStockDetails.orderId,
                                      deliveryDateAndTime: widget
                                          .liveStockDetails.deliveryDateAndTime,
                                      deliveryLocation: widget
                                          .liveStockDetails.deliveryLocation,
                                      isDelivered:
                                          widget.liveStockDetails.isDelivered,
                                      images: widget.liveStockDetails.images,
                                      isSold: widget.liveStockDetails.isSold,
                                      description:
                                          widget.liveStockDetails.description,
                                      highlightedDescription: widget
                                          .liveStockDetails
                                          .highlightedDescription,
                                      postedAt:
                                          Timestamp.fromDate(DateTime.now()),
                                      isbutcherNeeded: widget
                                          .liveStockDetails.isbutcherNeeded,
                                      isOnSpotDelivery: widget.liveStockDetails.isOnSpotDelivery,
                                      cattleIdNo: widget.liveStockDetails.cattleIdNo,
                                      liveStockSellerId: widget.liveStockDetails.liveStockSellerId);
                                  await UserFirebaseService(
                                          user: Provider.of<User>(context,
                                              listen: false))
                                      .addtocart(context,
                                          cartdata: liveStockCart.toMap(),
                                          productId: liveStockCart.productId
                                              .toString(),
                                          cartType: 'livestock')
                                      .then((value) {
                                    print("posted successfully");
                                    showSnackBar(
                                        context, "Added to cart successfully");
                                  });
                                },
                                icon: Icon(
                                  Icons.shopping_cart_outlined,
                                  size: 15,
                                ),
                                label: Text(
                                  'Add To Cart',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                )),
                        widget.liveStockDetails.isSold!
                            ? ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: GlobalVariables
                                        .secondaryColor
                                        .withOpacity(0.4),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                onPressed: () async {
                                  showSnackBar(
                                      context, "Sorry, Already Sold Out");
                                },
                                icon: Icon(
                                  Icons.ads_click_outlined,
                                  size: 15,
                                ),
                                label: Text(
                                  'Buy Now',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ))
                            : ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        GlobalVariables.secondaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                onPressed: () async {
                                  UserModel userdata =
                                      Provider.of<UserProvider>(context,
                                              listen: false)
                                          .user;
                                  setState(() {
                                    addressController.text =
                                        userdata.location.address;
                                    pincodeController.text =
                                        userdata.location.pincode;
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BuyScreen(
                                              userdata: userdata,
                                              liveStockDetails:
                                                  widget.liveStockDetails)));

                                  //   showModalBottomSheet(
                                  //       clipBehavior: Clip.none,
                                  //       isScrollControlled: true,
                                  //       context: context,
                                  //       builder: (context) => StatefulBuilder(builder:
                                  //               (BuildContext context,
                                  //                   StateSetter setState) {
                                  //             return ListView(
                                  //               children: [
                                  //                 Column(
                                  //                   children: [
                                  //                     SizedBox(
                                  //                       height: 40,
                                  //                     ),
                                  //                     MyTextFeild(
                                  //                         type: TextInputType
                                  //                             .streetAddress,
                                  //                         hint: "Enter Your Address",
                                  //                         label: "Enter Address",
                                  //                         controller:
                                  //                             addressController),
                                  //                     const SizedBox(
                                  //                       height: 5,
                                  //                     ),
                                  //                     MyTextFeild(
                                  //                         type: TextInputType.number,
                                  //                         hint: "Enter Your Pincode",
                                  //                         label: "Enter Pincode",
                                  //                         controller:
                                  //                             pincodeController),
                                  //                     const SizedBox(
                                  //                       height: 5,
                                  //                     ),
                                  //                     ElevatedButton(
                                  //                         style: ElevatedButton.styleFrom(
                                  //                             shape: StadiumBorder(),
                                  //                             fixedSize: Size(
                                  //                                 MediaQuery.of(
                                  //                                             context)
                                  //                                         .size
                                  //                                         .width *
                                  //                                     0.5,
                                  //                                 MediaQuery.of(
                                  //                                             context)
                                  //                                         .size
                                  //                                         .height *
                                  //                                     0.05),
                                  //                             backgroundColor:
                                  //                                 GlobalVariables
                                  //                                     .selectedNavBarColor),
                                  //                         onPressed: () async {
                                  //                           showModalBottomSheet(
                                  //                               context: context,
                                  //                               builder: (context) =>
                                  //                                   Container(
                                  //                                       height: 500,
                                  //                                       width: double
                                  //                                           .infinity,
                                  //                                       color: Colors
                                  //                                           .red));

                                  //                           // location.enableBackgroundMode(
                                  //                           //     enable: true);
                                  //                           // var serviceEnabled =
                                  //                           //     await location
                                  //                           //         .serviceEnabled();
                                  //                           // if (!serviceEnabled) {
                                  //                           //   serviceEnabled =
                                  //                           //       await location
                                  //                           //           .requestService();
                                  //                           //   if (!serviceEnabled) {
                                  //                           //     return;
                                  //                           //   }
                                  //                           // }

                                  //                           // _permissionGranted =
                                  //                           //     await location
                                  //                           //         .hasPermission();
                                  //                           // if (_permissionGranted ==
                                  //                           //     PermissionStatus.denied) {
                                  //                           //   _permissionGranted =
                                  //                           //       await location
                                  //                           //           .requestPermission();
                                  //                           //   if (_permissionGranted !=
                                  //                           //       PermissionStatus
                                  //                           //           .granted) {
                                  //                           //     return;
                                  //                           //   }
                                  //                           // }

                                  //                           // _locationData = await location
                                  //                           //     .getLocation();
                                  //                           // print(
                                  //                           //     "The location data is ${_locationData.latitude} , ${_locationData.longitude}}");
                                  //                         },
                                  //                         child: Row(
                                  //                           mainAxisAlignment:
                                  //                               MainAxisAlignment
                                  //                                   .center,
                                  //                           children: const [
                                  //                             Icon(
                                  //                               Icons.location_on,
                                  //                               color: Colors.white,
                                  //                             ),
                                  //                             Text(
                                  //                               "Get Location",
                                  //                               style: TextStyle(
                                  //                                   color:
                                  //                                       Colors.white),
                                  //                             ),
                                  //                           ],
                                  //                         )),
                                  //                     const SizedBox(
                                  //                       height: 10,
                                  //                     ),
                                  //                     Padding(
                                  //                       padding:
                                  //                           const EdgeInsets.all(8.0),
                                  //                       child: Banner(
                                  //                         color: GlobalVariables
                                  //                             .selectedNavBarColor,
                                  //                         location:
                                  //                             BannerLocation.topStart,
                                  //                         message: 'Qurbani Offer',
                                  //                         child: Container(
                                  //                           decoration: BoxDecoration(
                                  //                               borderRadius:
                                  //                                   BorderRadius
                                  //                                       .circular(12),
                                  //                               color: Colors.yellow),
                                  //                           child: Column(
                                  //                             children: [
                                  //                               Padding(
                                  //                                 padding:
                                  //                                     const EdgeInsets
                                  //                                         .all(15.0),
                                  //                                 child: Column(
                                  //                                   children: [
                                  //                                     Text(
                                  //                                       'TAKE: ',
                                  //                                       style: TextStyle(
                                  //                                           color: GlobalVariables
                                  //                                               .selectedNavBarColor,
                                  //                                           fontSize:
                                  //                                               15,
                                  //                                           fontWeight:
                                  //                                               FontWeight
                                  //                                                   .w500,
                                  //                                           wordSpacing:
                                  //                                               1),
                                  //                                     ),
                                  //                                     const SizedBox(
                                  //                                       height: 3,
                                  //                                     ),
                                  //                                     const Text(
                                  //                                       'CATTLE CARE 🤗+ BUTCHER 🔪',
                                  //                                       style: TextStyle(
                                  //                                           color: Colors
                                  //                                               .green,
                                  //                                           fontSize:
                                  //                                               15,
                                  //                                           fontWeight:
                                  //                                               FontWeight
                                  //                                                   .w500,
                                  //                                           wordSpacing:
                                  //                                               1),
                                  //                                     ),
                                  //                                   ],
                                  //                                 ),
                                  //                               ),
                                  //                               const SizedBox(
                                  //                                 height: 10,
                                  //                               ),
                                  //                               Padding(
                                  //                                 padding:
                                  //                                     const EdgeInsets
                                  //                                         .all(15.0),
                                  //                                 child: Column(
                                  //                                   children: [
                                  //                                     Text(
                                  //                                       'GET :',
                                  //                                       style: TextStyle(
                                  //                                           color: GlobalVariables
                                  //                                               .selectedNavBarColor,
                                  //                                           fontSize:
                                  //                                               15,
                                  //                                           fontWeight:
                                  //                                               FontWeight
                                  //                                                   .w500,
                                  //                                           wordSpacing:
                                  //                                               1),
                                  //                                     ),
                                  //                                     const Text(
                                  //                                       'FREE DELIVERY 🚚',
                                  //                                       style: TextStyle(
                                  //                                           color: Colors
                                  //                                               .green,
                                  //                                           fontSize:
                                  //                                               15,
                                  //                                           fontWeight:
                                  //                                               FontWeight
                                  //                                                   .w500,
                                  //                                           wordSpacing:
                                  //                                               1),
                                  //                                     ),
                                  //                                   ],
                                  //                                 ),
                                  //                               ),
                                  //                             ],
                                  //                           ),
                                  //                         ),
                                  //                       ),
                                  //                     ),
                                  //                     Padding(
                                  //                       padding: const EdgeInsets.all(
                                  //                           15.0),
                                  //                       child: const Text(
                                  //                         '⭐⭐  We suggest you to add CATTLE CARE and BUTCHER option. We will take care of your catlle,feed them properly until Qurbani and send Butcher to your home ⭐⭐',
                                  //                         style: TextStyle(
                                  //                             color: Colors.green,
                                  //                             fontSize: 9,
                                  //                             fontWeight:
                                  //                                 FontWeight.w400),
                                  //                       ),
                                  //                     ),
                                  //                     Padding(
                                  //                       padding:
                                  //                           const EdgeInsets.only(
                                  //                               left: 15.0,
                                  //                               right: 15.0,
                                  //                               top: 15.0),
                                  //                       child: Container(
                                  //                         padding:
                                  //                             const EdgeInsets.all(8),
                                  //                         decoration: BoxDecoration(
                                  //                           color: Colors.white,
                                  //                           borderRadius:
                                  //                               BorderRadius.circular(
                                  //                                   15),
                                  //                           border: Border.all(
                                  //                               color: GlobalVariables
                                  //                                   .secondaryColor,
                                  //                               style:
                                  //                                   BorderStyle.solid,
                                  //                               width: 2),
                                  //                         ),
                                  //                         child: Column(
                                  //                           children: [
                                  //                             Row(
                                  //                               mainAxisAlignment:
                                  //                                   MainAxisAlignment
                                  //                                       .spaceBetween,
                                  //                               children: [
                                  //                                 Text(
                                  //                                   'Do you want Butcher during Qurbani ?',
                                  //                                   style: TextStyle(
                                  //                                       color: GlobalVariables
                                  //                                           .secondaryColor,
                                  //                                       fontSize: 11,
                                  //                                       fontWeight:
                                  //                                           FontWeight
                                  //                                               .w600),
                                  //                                 ),
                                  //                                 Switch(
                                  //                                   value:
                                  //                                       isButcherNeeded,
                                  //                                   onChanged:
                                  //                                       (value) {
                                  //                                     isButcherNeeded =
                                  //                                         value;
                                  //                                     if (value ==
                                  //                                         true) {
                                  //                                       sumtotal +=
                                  //                                           750;
                                  //                                     } else {
                                  //                                       sumtotal -=
                                  //                                           750;
                                  //                                     }
                                  //                                     if (value ==
                                  //                                             true &&
                                  //                                         iscattleCare) {
                                  //                                       deliveryfee =
                                  //                                           0;
                                  //                                     } else {
                                  //                                       deliveryfee =
                                  //                                           500;
                                  //                                     }
                                  //                                     print(
                                  //                                         isButcherNeeded);
                                  //                                     print(
                                  //                                         "The deliveryfee $deliveryfee");
                                  //                                     setState(() {});
                                  //                                   },
                                  //                                   activeTrackColor:
                                  //                                       GlobalVariables
                                  //                                           .secondaryColor,
                                  //                                   activeColor:
                                  //                                       GlobalVariables
                                  //                                           .selectedNavBarColor,
                                  //                                 ),
                                  //                               ],
                                  //                             ),
                                  //                             // isButcherNeeded
                                  //                             //     ? const Padding(
                                  //                             //         padding:
                                  //                             //             EdgeInsets.all(
                                  //                             //                 3.0),
                                  //                             //         child: Text(
                                  //                             //           'We suggest you to add Cattle Care option. We will take care of your catlle and feed them properly until Qurbani ',
                                  //                             //           style: TextStyle(
                                  //                             //               color: Colors
                                  //                             //                   .green,
                                  //                             //               fontSize: 11,
                                  //                             //               fontWeight:
                                  //                             //                   FontWeight
                                  //                             //                       .w400),
                                  //                             //         ),
                                  //                             //       )
                                  //                             //     : Container(),
                                  //                           ],
                                  //                         ),
                                  //                       ),
                                  //                     ),
                                  //                     Padding(
                                  //                       padding:
                                  //                           const EdgeInsets.only(
                                  //                               left: 15.0,
                                  //                               right: 15.0,
                                  //                               top: 15.0),
                                  //                       child: Container(
                                  //                         padding:
                                  //                             const EdgeInsets.all(8),
                                  //                         decoration: BoxDecoration(
                                  //                           color: Colors.white,
                                  //                           borderRadius:
                                  //                               BorderRadius.circular(
                                  //                                   15),
                                  //                           border: Border.all(
                                  //                               color: GlobalVariables
                                  //                                   .secondaryColor,
                                  //                               style:
                                  //                                   BorderStyle.solid,
                                  //                               width: 2),
                                  //                         ),
                                  //                         child: Column(
                                  //                           children: [
                                  //                             Row(
                                  //                               mainAxisAlignment:
                                  //                                   MainAxisAlignment
                                  //                                       .spaceBetween,
                                  //                               children: [
                                  //                                 Text(
                                  //                                   'Cattle Care until Qurbani ?',
                                  //                                   style: TextStyle(
                                  //                                       color: GlobalVariables
                                  //                                           .secondaryColor,
                                  //                                       fontSize: 11,
                                  //                                       fontWeight:
                                  //                                           FontWeight
                                  //                                               .w600),
                                  //                                 ),
                                  //                                 Column(
                                  //                                   children: [
                                  //                                     Switch(
                                  //                                       value:
                                  //                                           iscattleCare,
                                  //                                       onChanged:
                                  //                                           (value) {
                                  //                                         iscattleCare =
                                  //                                             value;
                                  //                                         print(
                                  //                                             iscattleCare);
                                  //                                         if (value ==
                                  //                                             true) {
                                  //                                           sumtotal +=
                                  //                                               2000;
                                  //                                         } else {
                                  //                                           sumtotal -=
                                  //                                               2000;
                                  //                                         }
                                  //                                         if (value ==
                                  //                                                 true &&
                                  //                                             isButcherNeeded) {
                                  //                                           deliveryfee =
                                  //                                               0;
                                  //                                         } else {
                                  //                                           deliveryfee =
                                  //                                               500;
                                  //                                         }
                                  //                                         print(
                                  //                                             "The deliveryfee $deliveryfee");
                                  //                                         setState(
                                  //                                             () {});
                                  //                                       },
                                  //                                       activeTrackColor:
                                  //                                           GlobalVariables
                                  //                                               .secondaryColor,
                                  //                                       activeColor:
                                  //                                           GlobalVariables
                                  //                                               .selectedNavBarColor,
                                  //                                     ),
                                  //                                     SizedBox(
                                  //                                       height: 5,
                                  //                                     ),
                                  //                                     Row(
                                  //                                       mainAxisAlignment:
                                  //                                           MainAxisAlignment
                                  //                                               .spaceBetween,
                                  //                                       children: [
                                  //                                         Text(
                                  //                                           'Take Delivery now',
                                  //                                           style:
                                  //                                               TextStyle(
                                  //                                             color: !iscattleCare
                                  //                                                 ? Colors.green
                                  //                                                 : Colors.green.withOpacity(0.6),
                                  //                                             fontSize:
                                  //                                                 7,
                                  //                                             fontWeight: !iscattleCare
                                  //                                                 ? FontWeight.bold
                                  //                                                 : FontWeight.w600,
                                  //                                             backgroundColor: !iscattleCare
                                  //                                                 ? Colors.black
                                  //                                                 : Colors.white,
                                  //                                           ),
                                  //                                         ),
                                  //                                         const SizedBox(
                                  //                                           width: 15,
                                  //                                         ),
                                  //                                         Text(
                                  //                                           'Cattle Care',
                                  //                                           style: TextStyle(
                                  //                                               color: iscattleCare
                                  //                                                   ? Colors
                                  //                                                       .green
                                  //                                                   : Colors.green.withOpacity(
                                  //                                                       0.6),
                                  //                                               fontSize:
                                  //                                                   7,
                                  //                                               fontWeight: iscattleCare
                                  //                                                   ? FontWeight
                                  //                                                       .bold
                                  //                                                   : FontWeight
                                  //                                                       .w600,
                                  //                                               backgroundColor: iscattleCare
                                  //                                                   ? Colors.black
                                  //                                                   : Colors.white),
                                  //                                         ),
                                  //                                       ],
                                  //                                     )
                                  //                                   ],
                                  //                                 ),
                                  //                               ],
                                  //                             ),
                                  //                           ],
                                  //                         ),
                                  //                       ),
                                  //                     ),
                                  //                     SizedBox(
                                  //                       height: 5,
                                  //                     ),
                                  //                     Padding(
                                  //                       padding: const EdgeInsets.all(
                                  //                           20.0),
                                  //                       child: Column(
                                  //                         children: [
                                  //                           Row(
                                  //                             mainAxisAlignment:
                                  //                                 MainAxisAlignment
                                  //                                     .spaceBetween,
                                  //                             children: [
                                  //                               Text(
                                  //                                 'Cattle Price -',
                                  //                                 style: TextStyle(
                                  //                                     color: GlobalVariables
                                  //                                         .selectedNavBarColor,
                                  //                                     fontSize: 11,
                                  //                                     fontWeight:
                                  //                                         FontWeight
                                  //                                             .w500),
                                  //                               ),
                                  //                               Text(
                                  //                                 'Rs.${widget.liveStockDetails.priceQuoted}',
                                  //                                 style: TextStyle(
                                  //                                     color: Colors
                                  //                                         .black,
                                  //                                     fontSize: 10,
                                  //                                     fontWeight:
                                  //                                         FontWeight
                                  //                                             .w500),
                                  //                               ),
                                  //                             ],
                                  //                           ),
                                  //                           const SizedBox(
                                  //                             height: 3,
                                  //                           ),
                                  //                           iscattleCare
                                  //                               ? Row(
                                  //                                   mainAxisAlignment:
                                  //                                       MainAxisAlignment
                                  //                                           .spaceBetween,
                                  //                                   children: [
                                  //                                     Text(
                                  //                                       'Cattle Care -',
                                  //                                       style: TextStyle(
                                  //                                           color: GlobalVariables
                                  //                                               .selectedNavBarColor,
                                  //                                           fontSize:
                                  //                                               11,
                                  //                                           fontWeight:
                                  //                                               FontWeight
                                  //                                                   .w500),
                                  //                                     ),
                                  //                                     Text(
                                  //                                       'Rs.2000 (Until Qurbani)',
                                  //                                       style: TextStyle(
                                  //                                           color: Colors
                                  //                                               .black,
                                  //                                           fontSize:
                                  //                                               10,
                                  //                                           fontWeight:
                                  //                                               FontWeight
                                  //                                                   .w500),
                                  //                                     ),
                                  //                                   ],
                                  //                                 )
                                  //                               : Container(),
                                  //                           SizedBox(
                                  //                             height: iscattleCare
                                  //                                 ? 3
                                  //                                 : 0,
                                  //                           ),
                                  //                           isButcherNeeded
                                  //                               ? Row(
                                  //                                   mainAxisAlignment:
                                  //                                       MainAxisAlignment
                                  //                                           .spaceBetween,
                                  //                                   children: [
                                  //                                     Text(
                                  //                                       'Butcher -',
                                  //                                       style: TextStyle(
                                  //                                           color: GlobalVariables
                                  //                                               .selectedNavBarColor,
                                  //                                           fontSize:
                                  //                                               11,
                                  //                                           fontWeight:
                                  //                                               FontWeight
                                  //                                                   .w500),
                                  //                                     ),
                                  //                                     const Text(
                                  //                                       'Rs.750',
                                  //                                       style: TextStyle(
                                  //                                           color: Colors
                                  //                                               .black,
                                  //                                           fontSize:
                                  //                                               10,
                                  //                                           fontWeight:
                                  //                                               FontWeight
                                  //                                                   .w500),
                                  //                                     ),
                                  //                                   ],
                                  //                                 )
                                  //                               : Container(),
                                  //                           SizedBox(
                                  //                             height: isButcherNeeded
                                  //                                 ? 3
                                  //                                 : 0,
                                  //                           ),
                                  //                           isButcherNeeded &&
                                  //                                   iscattleCare
                                  //                               ? Row(
                                  //                                   mainAxisAlignment:
                                  //                                       MainAxisAlignment
                                  //                                           .spaceBetween,
                                  //                                   children: [
                                  //                                     Text(
                                  //                                       'Delivery -',
                                  //                                       style: TextStyle(
                                  //                                           color: GlobalVariables
                                  //                                               .selectedNavBarColor,
                                  //                                           fontSize:
                                  //                                               11,
                                  //                                           fontWeight:
                                  //                                               FontWeight
                                  //                                                   .w500),
                                  //                                     ),
                                  //                                     const Text(
                                  //                                       '⭐FREE⭐',
                                  //                                       style: TextStyle(
                                  //                                           color: Colors
                                  //                                               .black,
                                  //                                           fontSize:
                                  //                                               10,
                                  //                                           fontWeight:
                                  //                                               FontWeight
                                  //                                                   .w500),
                                  //                                     ),
                                  //                                   ],
                                  //                                 )
                                  //                               : Row(
                                  //                                   mainAxisAlignment:
                                  //                                       MainAxisAlignment
                                  //                                           .spaceBetween,
                                  //                                   children: [
                                  //                                     Text(
                                  //                                       'Delivery -',
                                  //                                       style: TextStyle(
                                  //                                           color: GlobalVariables
                                  //                                               .selectedNavBarColor,
                                  //                                           fontSize:
                                  //                                               11,
                                  //                                           fontWeight:
                                  //                                               FontWeight
                                  //                                                   .w500),
                                  //                                     ),
                                  //                                     const Text(
                                  //                                       '500',
                                  //                                       style: TextStyle(
                                  //                                           color: Colors
                                  //                                               .black,
                                  //                                           fontSize:
                                  //                                               10,
                                  //                                           fontWeight:
                                  //                                               FontWeight
                                  //                                                   .w500),
                                  //                                     ),
                                  //                                   ],
                                  //                                 ),
                                  //                           const Align(
                                  //                             alignment: Alignment
                                  //                                 .centerLeft,
                                  //                             child: Divider(
                                  //                               thickness: 1,
                                  //                               endIndent: 10,
                                  //                               indent: 20,
                                  //                             ),
                                  //                           ),
                                  //                           Row(
                                  //                             mainAxisAlignment:
                                  //                                 MainAxisAlignment
                                  //                                     .end,
                                  //                             children: [
                                  //                               Text(
                                  //                                 'Total -',
                                  //                                 style: TextStyle(
                                  //                                     color: GlobalVariables
                                  //                                         .selectedNavBarColor,
                                  //                                     fontSize: 12,
                                  //                                     fontWeight:
                                  //                                         FontWeight
                                  //                                             .w500),
                                  //                               ),
                                  //                               const SizedBox(
                                  //                                 width: 10,
                                  //                               ),
                                  //                               Text(
                                  //                                 (widget.liveStockDetails
                                  //                                             .priceQuoted! +
                                  //                                         sumtotal +
                                  //                                         deliveryfee)
                                  //                                     .toString(),
                                  //                                 style: const TextStyle(
                                  //                                     color: Colors
                                  //                                         .black,
                                  //                                     fontSize: 10,
                                  //                                     fontWeight:
                                  //                                         FontWeight
                                  //                                             .w500),
                                  //                               ),
                                  //                             ],
                                  //                           )
                                  //                         ],
                                  //                       ),
                                  //                     ),
                                  //                     ElevatedButton.icon(
                                  //                         onPressed: () async {},
                                  //                         icon: Icon(
                                  //                           Icons.ads_click_outlined,
                                  //                           size: 15,
                                  //                         ),
                                  //                         label: Text(
                                  //                           'Buy Now',
                                  //                           style: TextStyle(
                                  //                               color: Colors.white,
                                  //                               fontSize: 13,
                                  //                               fontWeight:
                                  //                                   FontWeight.w500),
                                  //                         )),
                                  //                   ],
                                  //                 ),
                                  //               ],
                                  //             );
                                  //           }));
                                  // },
                                },
                                icon: Icon(
                                  Icons.ads_click_outlined,
                                  size: 15,
                                ),
                                label: Text(
                                  'Buy Now',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                )),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Align(
                      alignment: Alignment.center,
                      child: widget.liveStockDetails.isSold!
                          ? ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: GlobalVariables
                                      .secondaryColor
                                      .withOpacity(0.4),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              onPressed: () async {
                                showSnackBar(
                                    context, "Sorry, Already Sold Out");
                              },
                              icon: Icon(
                                Icons.call,
                                size: 15,
                              ),
                              label: Text(
                                'Call',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ))
                          : ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      GlobalVariables.selectedNavBarColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              onPressed: () {
                                // final Uri launchUri = Uri(
                                //   scheme: 'tel',
                                //   path: '+${widget.sellerphoneNumber.toString()}',
                                // );
                                //  await launchUrl(launchUri);
                                //  _makePhoneCall('+91${phoneNo.toString()}');
                              },
                              icon: Icon(
                                Icons.call,
                                size: 15,
                              ),
                              label: Text(
                                'Call',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              )),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
