// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meatzy_app/Constants/Global_Variables.dart';
import 'package:meatzy_app/Model/livestock_model.dart';
import 'package:meatzy_app/Model/meat_seller_model.dart';
import 'package:meatzy_app/Model/user_model.dart';
import 'package:meatzy_app/Service/user_firebase_service.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../Constants/Utils.dart';
import '../../Widget/textformfeild_widget.dart';
import '../MainHomePage.dart';

class BuyScreen extends StatefulWidget {
  UserModel userdata;
  LiveStockDetails liveStockDetails;
  BuyScreen({
    Key? key,
    required this.userdata,
    required this.liveStockDetails,
  }) : super(key: key);

  @override
  State<BuyScreen> createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  TextEditingController addressController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  bool iscattleCare = false;
  bool isOnSpotDelivery = false;
  bool isButcherNeeded = false;
  int sumtotal = 0;
  int deliveryfee = 500;
  late bool isfreedelivery;
  late GoogleMapController googleMapController;
  final Completer<GoogleMapController> _controller = Completer();
  double lat = 0;
  double lon = 0;

  BitmapDescriptor firebaseLocIcon =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);

  List<Marker> deliveryMarkerLoc = [];
  ScrollController _scrollController = ScrollController();
  bool isloading = false;
  final formGlobalKey = GlobalKey<FormState>();

  @override
  void initState() {
    addressController.text = widget.userdata.location.address;
    pincodeController.text = widget.userdata.location.pincode;
    deliveryMarkerLoc.add(Marker(
        markerId: const MarkerId('MeatzyDeliveryId'),
        position: LatLng(double.parse(widget.userdata.location.coordinates[0]),
            double.parse(widget.userdata.location.coordinates[1])),
        icon: firebaseLocIcon));

    super.initState();
  }

  @override
  void dispose() {
    addressController.dispose();
    pincodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isfreedelivery = iscattleCare && isOnSpotDelivery ? true : false;
    final firebaseUser = Provider.of<User>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        backgroundColor: GlobalVariables.secondaryColor,
        title: const Text(
          'Buy Now',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: isloading
          ? Center(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Buying Product..",
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CircularProgressIndicator(
                      color: GlobalVariables.selectedNavBarColor),
                ],
              ),
            )
          : ListView(
              controller: _scrollController,
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formGlobalKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'DELIVERY  DETAILS',
                          style: TextStyle(
                              color: GlobalVariables.selectedNavBarColor,
                              fontSize: 22,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w700),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Woahhh only few more steps !!!',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        MyTextFeild(
                            type: TextInputType.streetAddress,
                            hint: "Enter Your Address",
                            label: "Enter Address",
                            controller: addressController),
                        const SizedBox(
                          height: 5,
                        ),
                        MyTextFeild(
                            type: TextInputType.number,
                            hint: "Enter Your Pincode",
                            label: "Enter Pincode",
                            controller: pincodeController),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 500,
                          width: double.infinity,
                          color: Colors.red,
                          child: GoogleMap(
                              zoomGesturesEnabled: true,
                              tiltGesturesEnabled: true,
                              myLocationEnabled: true,
                              myLocationButtonEnabled: true,
                              onTap: (LatLng latLng) {
                                print("the Latlng is ${latLng}");
                                Marker newMarker = Marker(
                                    markerId:
                                        const MarkerId('NewDeliveryMarkerID'),
                                    position: LatLng(
                                        latLng.latitude, latLng.longitude),
                                    icon: firebaseLocIcon);
                                deliveryMarkerLoc.removeAt(0);
                                deliveryMarkerLoc.add(newMarker);
                                lat = latLng.latitude;
                                lon = latLng.longitude;
                                setState(() {});
                              },
                              mapType: MapType.hybrid,
                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                    double.parse(widget
                                        .userdata.location.coordinates[0]),
                                    double.parse(widget
                                        .userdata.location.coordinates[1])),
                                zoom: 13,
                              ),
                              markers: deliveryMarkerLoc.toSet(),

                              // Marker(
                              //     markerId: const MarkerId('currentlocation'),
                              //     position: LatLng(currentLocation!.latitude!,
                              //         currentLocation!.longitude!),
                              //     icon: currentLocationIcon),
                              // Marker(
                              //     markerId: MarkerId('source'),
                              //     position: sourceLocation,
                              //     icon: markerIcon),
                              // Marker(
                              //     markerId: MarkerId('destination'),
                              //     position: destinationLocation,
                              //     icon: markerIcon),
                              // Marker(
                              //   markerId: MarkerId('id1'),
                              //   position: LatLng(lat, lon),
                              //   icon: currentLocIcon,
                              // ),

                              onMapCreated: (mapController) {
                                _controller.complete(mapController);
                              }),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                                fixedSize: Size(
                                    MediaQuery.of(context).size.width * 0.5,
                                    MediaQuery.of(context).size.height * 0.05),
                                backgroundColor:
                                    GlobalVariables.selectedNavBarColor),
                            onPressed: () async {
                              // showModalBottomSheet(
                              //   context: context,
                              //   builder: (context) => Stack(
                              //     children: [
                              //       Container(
                              //         height: 500,
                              //         width: double.infinity,
                              //         color: Colors.red,
                              //         child: GoogleMap(
                              //             zoomGesturesEnabled: true,
                              //             tiltGesturesEnabled: true,
                              //             myLocationEnabled: true,
                              //             myLocationButtonEnabled: true,
                              //             onTap: (LatLng latLng) {
                              //               print("the Latlng is ${latLng}");
                              //               Marker newMarker = Marker(
                              //                   markerId:
                              //                       MarkerId('NewDeliveryMarkerID'),
                              //                   position: LatLng(
                              //                       latLng.latitude, latLng.longitude),
                              //                   icon: firebaseLocIcon);
                              //               deliveryMarkerLoc.removeAt(0);
                              //               deliveryMarkerLoc.add(newMarker);
                              //               setState(() {});
                              //             },
                              //             mapType: MapType.hybrid,
                              //             initialCameraPosition: CameraPosition(
                              //               target: LatLng(
                              //                   double.parse(widget
                              //                       .userdata.location.coordinates[0]),
                              //                   double.parse(widget
                              //                       .userdata.location.coordinates[1])),
                              //               zoom: 13,
                              //             ),
                              //             markers: deliveryMarkerLoc.toSet(),

                              //             // Marker(
                              //             //     markerId: const MarkerId('currentlocation'),
                              //             //     position: LatLng(currentLocation!.latitude!,
                              //             //         currentLocation!.longitude!),
                              //             //     icon: currentLocationIcon),
                              //             // Marker(
                              //             //     markerId: MarkerId('source'),
                              //             //     position: sourceLocation,
                              //             //     icon: markerIcon),
                              //             // Marker(
                              //             //     markerId: MarkerId('destination'),
                              //             //     position: destinationLocation,
                              //             //     icon: markerIcon),
                              //             // Marker(
                              //             //   markerId: MarkerId('id1'),
                              //             //   position: LatLng(lat, lon),
                              //             //   icon: currentLocIcon,
                              //             // ),

                              //             onMapCreated: (mapController) {
                              //               _controller.complete(mapController);
                              //             }),
                              //       ),
                              //     ],
                              //   ),
                              // );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Get Location",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        GlobalVariables.selectedNavBarColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                onPressed: () async {
                                  showModalBottomSheet(
                                      clipBehavior: Clip.none,
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (context) => StatefulBuilder(
                                              builder: (BuildContext context,
                                                  StateSetter setState) {
                                            return ListView(children: [
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                'PAYMENT',
                                                style: TextStyle(
                                                    color: GlobalVariables
                                                        .selectedNavBarColor,
                                                    fontSize: 22,
                                                    letterSpacing: 2,
                                                    fontWeight:
                                                        FontWeight.w700),
                                                textAlign: TextAlign.left,
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Banner(
                                                  color: GlobalVariables
                                                      .selectedNavBarColor,
                                                  location:
                                                      BannerLocation.topStart,
                                                  message: 'Qurbani Offer',
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        color: Colors.yellow),
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                'TAKE: ',
                                                                style: TextStyle(
                                                                    color: GlobalVariables
                                                                        .selectedNavBarColor,
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    wordSpacing:
                                                                        1),
                                                              ),
                                                              const SizedBox(
                                                                height: 3,
                                                              ),
                                                              const Text(
                                                                'CATTLE CARE 🤗+ BUTCHER 🔪',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .green,
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    wordSpacing:
                                                                        1),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                'GET :',
                                                                style: TextStyle(
                                                                    color: GlobalVariables
                                                                        .selectedNavBarColor,
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    wordSpacing:
                                                                        1),
                                                              ),
                                                              const Text(
                                                                'FREE DELIVERY 🚚',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .green,
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    wordSpacing:
                                                                        1),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.all(15.0),
                                                child: Text(
                                                  '⭐⭐  We suggest you to add CATTLE CARE and BUTCHER option. We will take care of your catlle,feed them properly until Qurbani and send Butcher to your home ⭐⭐',
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 9,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0,
                                                    right: 15.0,
                                                    top: 15.0),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    border: Border.all(
                                                        color: GlobalVariables
                                                            .secondaryColor,
                                                        style:
                                                            BorderStyle.solid,
                                                        width: 2),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Text(
                                                            'Do you want Butcher during Qurbani ?',
                                                            style: TextStyle(
                                                                color: GlobalVariables
                                                                    .secondaryColor,
                                                                fontSize: 11,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          Switch(
                                                            value:
                                                                isButcherNeeded,
                                                            onChanged: (value) {
                                                              isButcherNeeded =
                                                                  value;
                                                              if (value ==
                                                                  true) {
                                                                sumtotal += 750;
                                                              } else {
                                                                sumtotal -= 750;
                                                              }
                                                              if (value ==
                                                                      true &&
                                                                  iscattleCare) {
                                                                deliveryfee = 0;
                                                              } else {
                                                                deliveryfee =
                                                                    500;
                                                              }
                                                              print(
                                                                  isButcherNeeded);
                                                              print(
                                                                  "The deliveryfee $deliveryfee");
                                                              setState(() {});
                                                            },
                                                            activeTrackColor:
                                                                GlobalVariables
                                                                    .secondaryColor,
                                                            activeColor:
                                                                GlobalVariables
                                                                    .selectedNavBarColor,
                                                          ),
                                                        ],
                                                      ),
                                                      // isButcherNeeded
                                                      //     ? const Padding(
                                                      //         padding:
                                                      //             EdgeInsets.all(
                                                      //                 3.0),
                                                      //         child: Text(
                                                      //           'We suggest you to add Cattle Care option. We will take care of your catlle and feed them properly until Qurbani ',
                                                      //           style: TextStyle(
                                                      //               color: Colors
                                                      //                   .green,
                                                      //               fontSize: 11,
                                                      //               fontWeight:
                                                      //                   FontWeight
                                                      //                       .w400),
                                                      //         ),
                                                      //       )
                                                      //     : Container(),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0,
                                                    right: 15.0,
                                                    top: 15.0),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    border: Border.all(
                                                        color: GlobalVariables
                                                            .secondaryColor,
                                                        style:
                                                            BorderStyle.solid,
                                                        width: 2),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Text(
                                                            'Cattle Care until Qurbani ?',
                                                            style: TextStyle(
                                                                color: GlobalVariables
                                                                    .secondaryColor,
                                                                fontSize: 11,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          Column(
                                                            children: [
                                                              Switch(
                                                                value:
                                                                    iscattleCare,
                                                                onChanged:
                                                                    (value) {
                                                                  iscattleCare =
                                                                      value;
                                                                  print(
                                                                      iscattleCare);
                                                                  if (value ==
                                                                      true) {
                                                                    sumtotal +=
                                                                        2000;
                                                                  } else {
                                                                    sumtotal -=
                                                                        2000;
                                                                  }
                                                                  if (value ==
                                                                          true &&
                                                                      isButcherNeeded) {
                                                                    deliveryfee =
                                                                        0;
                                                                  } else {
                                                                    deliveryfee =
                                                                        500;
                                                                  }
                                                                  print(
                                                                      "The deliveryfee $deliveryfee");
                                                                  setState(
                                                                      () {});
                                                                },
                                                                activeTrackColor:
                                                                    GlobalVariables
                                                                        .secondaryColor,
                                                                activeColor:
                                                                    GlobalVariables
                                                                        .selectedNavBarColor,
                                                              ),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    'Take Delivery now',
                                                                    style:
                                                                        TextStyle(
                                                                      color: !iscattleCare
                                                                          ? Colors
                                                                              .green
                                                                          : Colors
                                                                              .green
                                                                              .withOpacity(0.6),
                                                                      fontSize:
                                                                          7,
                                                                      fontWeight: !iscattleCare
                                                                          ? FontWeight
                                                                              .bold
                                                                          : FontWeight
                                                                              .w600,
                                                                      backgroundColor: !iscattleCare
                                                                          ? Colors
                                                                              .black
                                                                          : Colors
                                                                              .white,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 15,
                                                                  ),
                                                                  Text(
                                                                    'Cattle Care',
                                                                    style: TextStyle(
                                                                        color: iscattleCare
                                                                            ? Colors
                                                                                .green
                                                                            : Colors.green.withOpacity(
                                                                                0.6),
                                                                        fontSize:
                                                                            7,
                                                                        fontWeight: iscattleCare
                                                                            ? FontWeight
                                                                                .bold
                                                                            : FontWeight
                                                                                .w600,
                                                                        backgroundColor: iscattleCare
                                                                            ? Colors.black
                                                                            : Colors.white),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Cattle Price -',
                                                          style: TextStyle(
                                                              color: GlobalVariables
                                                                  .selectedNavBarColor,
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Text(
                                                          'Rs.${widget.liveStockDetails.priceQuoted}',
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 3,
                                                    ),
                                                    iscattleCare
                                                        ? Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                'Cattle Care -',
                                                                style: TextStyle(
                                                                    color: GlobalVariables
                                                                        .selectedNavBarColor,
                                                                    fontSize:
                                                                        11,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              const Text(
                                                                'Rs.2000 (Until Qurbani)',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ],
                                                          )
                                                        : Container(),
                                                    SizedBox(
                                                      height:
                                                          iscattleCare ? 3 : 0,
                                                    ),
                                                    isButcherNeeded
                                                        ? Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                'Butcher -',
                                                                style: TextStyle(
                                                                    color: GlobalVariables
                                                                        .selectedNavBarColor,
                                                                    fontSize:
                                                                        11,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              const Text(
                                                                'Rs.750',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ],
                                                          )
                                                        : Container(),
                                                    SizedBox(
                                                      height: isButcherNeeded
                                                          ? 3
                                                          : 0,
                                                    ),
                                                    isButcherNeeded &&
                                                            iscattleCare
                                                        ? Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                'Delivery -',
                                                                style: TextStyle(
                                                                    color: GlobalVariables
                                                                        .selectedNavBarColor,
                                                                    fontSize:
                                                                        11,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              const Text(
                                                                '⭐FREE⭐',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ],
                                                          )
                                                        : Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                'Delivery -',
                                                                style: TextStyle(
                                                                    color: GlobalVariables
                                                                        .selectedNavBarColor,
                                                                    fontSize:
                                                                        11,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              const Text(
                                                                '500',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ],
                                                          ),
                                                    const Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Divider(
                                                        thickness: 1,
                                                        endIndent: 10,
                                                        indent: 20,
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          'Total -',
                                                          style: TextStyle(
                                                              color: GlobalVariables
                                                                  .selectedNavBarColor,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          (widget.liveStockDetails
                                                                      .priceQuoted! +
                                                                  sumtotal +
                                                                  deliveryfee)
                                                              .toString(),
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: ElevatedButton.icon(
                                                      onPressed: () async {
                                                        if (formGlobalKey
                                                            .currentState!
                                                            .validate()) {
                                                          formGlobalKey
                                                              .currentState!
                                                              .save();

                                                          setState(() {
                                                            isloading = true;
                                                          });
                                                          const uid = Uuid();
                                                          final orderuId =
                                                              uid.v4();

                                                          LiveStockSellerOrder liveStockSellerOrder = LiveStockSellerOrder(
                                                              productPrice: widget
                                                                  .liveStockDetails
                                                                  .priceQuoted,
                                                              totalPrice: (widget
                                                                      .liveStockDetails
                                                                      .priceQuoted! +
                                                                  sumtotal +
                                                                  deliveryfee),
                                                              orderProductImage: widget
                                                                  .liveStockDetails
                                                                  .images![0],
                                                              productId: widget
                                                                  .liveStockDetails
                                                                  .productId,
                                                              orderedDate:
                                                                  Timestamp
                                                                      .now(),
                                                              deliveryDate:
                                                                  null,
                                                              orderStatus:
                                                                  "Order Request",
                                                              buyerId:
                                                                  firebaseUser
                                                                      .uid,
                                                              deliveryLocation: MyLocation(
                                                                  coordinates: [
                                                                    lat.toString(),
                                                                    lon.toString()
                                                                  ],
                                                                  address: addressController.text,
                                                                  pincode: pincodeController.text),
                                                              orderId: orderuId,
                                                              isbutcherNeeded: isButcherNeeded,
                                                              isOnSpotDelivery: isOnSpotDelivery,
                                                              cattleIdNo: widget.liveStockDetails.cattleIdNo);

                                                          UserLiveStockOrder userLiveStockOrder = UserLiveStockOrder(
                                                              productPrice: widget
                                                                  .liveStockDetails
                                                                  .priceQuoted,
                                                              totalPrice: (widget
                                                                      .liveStockDetails
                                                                      .priceQuoted! +
                                                                  sumtotal +
                                                                  deliveryfee),
                                                              orderProductImage: widget
                                                                  .liveStockDetails
                                                                  .images![0],
                                                              productId: widget
                                                                  .liveStockDetails
                                                                  .productId,
                                                              orderedDate: Timestamp
                                                                  .now(),
                                                              deliveryDate:
                                                                  null,
                                                              orderStatus:
                                                                  'Order Request',
                                                              livestockSellerId: widget
                                                                  .liveStockDetails
                                                                  .liveStockSellerId,
                                                              deliveryLocation: MyLocation(
                                                                  coordinates: [
                                                                    lat.toString(),
                                                                    lon.toString()
                                                                  ],
                                                                  address: addressController.text,
                                                                  pincode: pincodeController.text),
                                                              orderId: orderuId,
                                                              isbutcherNeeded: isButcherNeeded,
                                                              isOnSpotDelivery: isOnSpotDelivery,
                                                              cattleIdNo: widget.liveStockDetails.cattleIdNo);

                                                          LiveStockSellerNotification sellerNotification = LiveStockSellerNotification(
                                                              message:
                                                                  "Hey you got an order of ${widget.liveStockDetails.liveStockType} from ${addressController.text}",
                                                              buyerId:
                                                                  firebaseUser
                                                                      .uid,
                                                              productId: widget
                                                                  .liveStockDetails
                                                                  .productId!,
                                                              isSeen: false,
                                                              productImage: widget
                                                                  .liveStockDetails
                                                                  .images![0],
                                                              orderId: orderuId,
                                                              notifiedAt:
                                                                  Timestamp
                                                                      .now(),
                                                              productType: widget
                                                                  .liveStockDetails
                                                                  .liveStockType!);

                                                          await UserFirebaseService(
                                                                  user:
                                                                      firebaseUser)
                                                              .buynowlivestock(
                                                            context,
                                                            liveStockSellerId: widget
                                                                .liveStockDetails
                                                                .liveStockSellerId!,
                                                            productId: widget
                                                                .liveStockDetails
                                                                .productId!,
                                                            liveStockSellerOrder:
                                                                liveStockSellerOrder,
                                                            userLiveStockOrder:
                                                                userLiveStockOrder,
                                                            notification:
                                                                sellerNotification,
                                                            orderId: orderuId,
                                                          )
                                                              .then((value) {
                                                            setState(() {
                                                              isloading = false;
                                                            });
                                                            Navigator.pop(
                                                                context);
                                                            print(
                                                                "ordered Placed successfully");
                                                            Navigator
                                                                .pushReplacementNamed(
                                                                    context,
                                                                    MainHomePage
                                                                        .route);
                                                            showSnackBar(
                                                                context,
                                                                'Order Placed Successfully');
                                                          });
                                                        }
                                                      },
                                                      icon: const Icon(
                                                        Icons
                                                            .ads_click_outlined,
                                                        size: 15,
                                                      ),
                                                      label: const Text(
                                                        'CheckOut',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      )),
                                                ),
                                              ),
                                            ]);
                                          }));
                                },
                                icon: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 15,
                                ),
                                label: const Text(
                                  'Proceed',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
