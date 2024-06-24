// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:meatzy_app/Constants/Utils.dart';
import 'package:meatzy_app/Model/meat_seller_model.dart';
import 'package:meatzy_app/Model/user_model.dart';
import 'package:meatzy_app/Provider/user_provider.dart';
import 'package:meatzy_app/Screen/Cart/cart_screen.dart';
import 'package:meatzy_app/Service/user_firebase_service.dart';
import 'package:meatzy_app/Widget/notificationWidget.dart';
import 'package:meatzy_app/Widget/textformfeild_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import '../../../Constants/Global_Variables.dart';
import '../../../Widget/carousel_widget.dart';

class DetailedMeatProductViewScreen extends StatefulWidget {
  String productId;
  Product product;
  String shopAddress;

  DetailedMeatProductViewScreen({
    Key? key,
    this.productId = '',
    required this.product,
    required this.shopAddress,
  }) : super(key: key);

  @override
  State<DetailedMeatProductViewScreen> createState() =>
      _DetailedMeatProductViewScreenState();
}

class _DetailedMeatProductViewScreenState
    extends State<DetailedMeatProductViewScreen> {
  TextEditingController quantityController = TextEditingController();

  String address = '2/241 ecr main road kalapet, puducherry';
  int pincode = 604303;
  int phoneNo = 911212121212;
  void getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      address = prefs.getString("useraddress")!;
      pincode = prefs.getInt("userpincode")!;
      phoneNo = prefs.getInt("PhoneNumber")!;
    });
  }

  @override
  void initState() {
    // _makePhoneCall(phoneNumber);
    getUserData();
    super.initState();
  }

  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Location location = Location();
  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    User firebaseuser = Provider.of<User>(context, listen: false);
    late PermissionStatus _permissionGranted;
    late LocationData _locationData;
    const textStyle = TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        wordSpacing: 3);

    const seeAllStyle = TextStyle(
        color: GlobalVariables.secondaryColor,
        fontSize: 14,
        fontWeight: FontWeight.w800);
    return Scaffold(
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
            Container(child: CarouselWidget(imgUrls: widget.product.images)),
            Container(
              decoration: BoxDecoration(
                color: Colors.white, //GlobalVariables.secondaryColor,
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
                      widget.product.productName,
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
                              text: widget.product.highlightedDescription,
                              style: TextStyle(
                                  color: GlobalVariables.selectedNavBarColor,
                                  fontWeight: FontWeight.bold))
                        ],
                        text: widget.product.description,
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
                            Text("Shop Address  :   ",
                                style: TextStyle(
                                  color: GlobalVariables.selectedNavBarColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                            Expanded(
                              child: Text(widget.shopAddress,
                                  style: TextStyle(
                                    color: GlobalVariables.secondaryColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Category  :   ",
                                style: TextStyle(
                                  color: GlobalVariables.selectedNavBarColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                            Expanded(
                              child: Text(widget.product.categoryName,
                                  style: TextStyle(
                                    color: GlobalVariables.secondaryColor,
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
                            Text("Min Kg  :   ",
                                style: TextStyle(
                                  color: GlobalVariables.selectedNavBarColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                            Expanded(
                              child: Text(widget.product.minKg.toString(),
                                  style: TextStyle(
                                    color: GlobalVariables.secondaryColor,
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
                            Text("Max KG  :   ",
                                style: TextStyle(
                                  color: GlobalVariables.selectedNavBarColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                            Expanded(
                              child: Text(widget.product.maxKg.toString(),
                                  style: TextStyle(
                                    color: GlobalVariables.secondaryColor,
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
                            Text("Max KG Limit Per Day  :   ",
                                style: TextStyle(
                                  color: GlobalVariables.selectedNavBarColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                            Expanded(
                              child: Text(
                                  widget.product.maxKgLimitPerDay.toString(),
                                  style: TextStyle(
                                    color: GlobalVariables.secondaryColor,
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
                            Text("Is Having Stock :   ",
                                style: TextStyle(
                                  color: GlobalVariables.selectedNavBarColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                            Expanded(
                              child: Text(
                                  widget.product.isHavingStock == false
                                      ? 'NO'
                                      : 'Yes',
                                  style: TextStyle(
                                    color: GlobalVariables.secondaryColor,
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
                            Text("Discount:   ",
                                style: TextStyle(
                                  color: GlobalVariables.selectedNavBarColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                            Expanded(
                              child: Text(
                                  '${widget.product.discountInPercentage.toString()} % off ',
                                  style: TextStyle(
                                    color: GlobalVariables.secondaryColor,
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
                            Text("Price  :   ",
                                style: TextStyle(
                                  color: GlobalVariables.selectedNavBarColor,
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
                                Text(widget.product.pricePerKg.toString(),
                                    style: TextStyle(
                                      color: GlobalVariables.secondaryColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: GlobalVariables.secondaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            onPressed: () async {
                              MeatCart cart = MeatCart(
                                  productId: widget.product.productId,
                                  categoryName: widget.product.categoryName,
                                  productName: widget.product.productName,
                                  maxKg: widget.product.maxKg,
                                  minKg: widget.product.minKg,
                                  maxKgLimitPerDay:
                                      widget.product.maxKgLimitPerDay,
                                  description: widget.product.description,
                                  highlightedDescription:
                                      widget.product.highlightedDescription,
                                  images: widget.product.images,
                                  isHavingStock: widget.product.isHavingStock,
                                  stockInKg: widget.product.stockInKg,
                                  pricePerKg: widget.product.pricePerKg,
                                  isVerified: widget.product.isVerified,
                                  buyerId: widget.product.buyerId,
                                  isDiscountable: widget.product.isDiscountable,
                                  discountInPercentage:
                                      widget.product.discountInPercentage,
                                  ratings: widget.product.ratings,
                                  sellerId: widget.product.sellerId);
                              await UserFirebaseService(
                                      user: Provider.of<User>(context,
                                          listen: false))
                                  .addtocart(context,
                                      cartdata: cart.toMap(),
                                      productId: cart.productId,
                                      cartType: 'meat')
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
                        Consumer<UserProvider>(builder:
                            (BuildContext context, value, Widget? child) {
                          return ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  primary: GlobalVariables.secondaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              onPressed: () async {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) => Column(
                                          children: [
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Expanded(
                                                      child: MyTextFeild(
                                                          type: TextInputType
                                                              .number,
                                                          hint: "Enter in KG ",
                                                          label:
                                                              "Enter Quantity",
                                                          controller:
                                                              quantityController)),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 15, right: 15),
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          color: GlobalVariables
                                                              .selectedNavBarColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12)),
                                                      height: 50,
                                                      width: 55,
                                                      child: const Text(
                                                        "KG",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  )
                                                ]),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    shape: StadiumBorder(),
                                                    fixedSize: Size(
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.05),
                                                    backgroundColor:
                                                        GlobalVariables
                                                            .selectedNavBarColor),
                                                onPressed: () async {
                                                  location.enableBackgroundMode(
                                                      enable: true);
                                                  var serviceEnabled =
                                                      await location
                                                          .serviceEnabled();
                                                  if (!serviceEnabled) {
                                                    serviceEnabled =
                                                        await location
                                                            .requestService();
                                                    if (!serviceEnabled) {
                                                      return;
                                                    }
                                                  }

                                                  _permissionGranted =
                                                      await location
                                                          .hasPermission();
                                                  if (_permissionGranted ==
                                                      PermissionStatus.denied) {
                                                    _permissionGranted =
                                                        await location
                                                            .requestPermission();
                                                    if (_permissionGranted !=
                                                        PermissionStatus
                                                            .granted) {
                                                      return;
                                                    }
                                                  }

                                                  _locationData = await location
                                                      .getLocation();
                                                  print(
                                                      "The location data is ${_locationData.latitude} , ${_locationData.longitude}}");
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    Icon(
                                                      Icons.location_on,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      "Get Location",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                )),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            ElevatedButton.icon(
                                                onPressed: () async {
                                                  const uid = Uuid();
                                                  print('//////////////////');
                                                  print(
                                                      'the seller id is ${widget.product.sellerId}');
                                                  print('//////////////////');
                                                  final orderuId = uid.v4();
                                                  SellerOrder sellerOrder =
                                                      SellerOrder(
                                                          price: widget.product
                                                                  .pricePerKg *
                                                              int.parse(quantityController
                                                                  .text),
                                                          image: widget.product
                                                              .images[0],
                                                          productId: widget
                                                              .product
                                                              .productId,
                                                          orderedDate: DateTime.now()
                                                              .toString(),
                                                          deliveryDate: "",
                                                          orderStatus:
                                                              "Order Request",
                                                          buyerId:
                                                              firebaseuser.uid,
                                                          quantityInKg: int.parse(
                                                              quantityController
                                                                  .text),
                                                          deliveryLocation:
                                                              SellerLocation(
                                                            address: address,
                                                            coordinates: [
                                                              _locationData
                                                                  .latitude
                                                                  .toString(),
                                                              _locationData
                                                                  .longitude
                                                                  .toString()
                                                            ],
                                                            pincode: pincode
                                                                .toString(),
                                                          ),
                                                          isDiscount: widget
                                                              .product
                                                              .isDiscountable,
                                                          discountPercentage: widget
                                                              .product
                                                              .discountInPercentage,
                                                          orderId: orderuId);

                                                  UserMeatOrder userorder = UserMeatOrder(
                                                      orderprice: widget.product
                                                              .pricePerKg *
                                                          int.parse(
                                                              quantityController
                                                                  .text),
                                                      ordershopimage: widget
                                                          .product.images[0],
                                                      productId: widget
                                                          .product.productId,
                                                      orderedDate:
                                                          DateTime.now()
                                                              .toString(),
                                                      deliveryDate: '',
                                                      orderStatus:
                                                          "Order Request",
                                                      sellerId: widget
                                                          .product.sellerId,
                                                      quantityInKg: int.parse(
                                                          quantityController
                                                              .text),
                                                      deliveryLocation: MyLocation(
                                                          address: address,
                                                          coordinates: [_locationData.latitude.toString(), _locationData.longitude.toString()],
                                                          pincode: pincode.toString()),
                                                      isDiscount: widget.product.isDiscountable,
                                                      discountPercentage: widget.product.discountInPercentage,
                                                      orderId: orderuId);

                                                  SellerNotification
                                                      sellerNotification =
                                                      SellerNotification(
                                                          message:
                                                              "Hey, You got an Order of ${quantityController.text}KG of ${widget.product.productName}",
                                                          buyerId:
                                                              firebaseuser.uid,
                                                          productId: widget
                                                              .product
                                                              .productId,
                                                          timeStamp:
                                                              DateTime.now()
                                                                  .toString(),
                                                          isSeen: false,
                                                          productImage: widget
                                                              .product
                                                              .images[0],
                                                          orderId: orderuId);
                                                  await UserFirebaseService(
                                                          user: firebaseuser)
                                                      .buynowmeat(context,
                                                          sellerId: widget
                                                              .product.sellerId,
                                                          productId: widget
                                                              .product
                                                              .productId,
                                                          sellerOrder:
                                                              sellerOrder,
                                                          userOrder: userorder,
                                                          notification:
                                                              sellerNotification,
                                                          orderId: orderuId)
                                                      .then((value) {
                                                    Navigator.pop(context);
                                                    print(
                                                        "order posted successfully");
                                                    showSnackBar(context,
                                                        'Ordered Successfully');
                                                  });
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
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ))
                                          ],
                                        ));
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
                              ));
                        }),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton.icon(
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
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ]),
    );
  }
}
