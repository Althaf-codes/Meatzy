// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../Constants/Global_Variables.dart';
import '../../Model/meat_seller_model.dart';
import '../../Service/meat_seller_firebase_service.dart';
import '../../Utils/pick_image.dart';
import '../../Widget/textformfeild_widget.dart';
import '../MainHomePage.dart';

//12.0852827 , 79.8901109
class MeatSellerProductDetailsScreen0 extends StatefulWidget {
  Map sellerDetails;
  MeatSellerProductDetailsScreen0({Key? key, required this.sellerDetails})
      : super(key: key);

  @override
  State<MeatSellerProductDetailsScreen0> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<MeatSellerProductDetailsScreen0> {
  final TextEditingController categoryNameController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController maxKgController = TextEditingController();
  final TextEditingController minKgController = TextEditingController();
  final TextEditingController maxKgLimitPerDayController =
      TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController highlightedDescriptionController =
      TextEditingController();

  final TextEditingController stockInKgController = TextEditingController();
  final TextEditingController pricePerKgController = TextEditingController();

  final TextEditingController discountInPercentageController =
      TextEditingController();

  final formGlobalKey = GlobalKey<FormState>();
  bool isHavingStock = false;
  bool isDiscountable = false;
  bool isDeliverable = false;

  List<File> images = [];
  List<String> imageUrls = [];

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  void dispose() {
    categoryNameController.dispose();
    productNameController.dispose();
    maxKgController.dispose();
    minKgController.dispose();
    maxKgLimitPerDayController.dispose();
    descriptionController.dispose();
    highlightedDescriptionController.dispose();
    stockInKgController.dispose();
    pricePerKgController.dispose();
    discountInPercentageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var prefs;

    void initalizeShared() async {
      prefs = await SharedPreferences.getInstance();
    }

    final firebaseUser = context.watch<User?>();
    UploadTask? uploadTask;
    Future uploadFile() async {
      final storagereference = FirebaseStorage.instance.ref();

      for (int i = 0; i < images.length; i++) {
        final path = 'files/${firebaseUser!.uid}/${images[0].path}';
        final ref = storagereference.child(path);
        uploadTask = ref.putFile(images[i]);
        final snapshot = await uploadTask!.whenComplete(() {});
        final downloadUrl = await snapshot.ref.getDownloadURL();
        imageUrls.add(downloadUrl);
        print("the url is ${downloadUrl}");
        if (i >= images.length) {
          break;
        }
      }
    }

    return SafeArea(
      minimum: EdgeInsets.zero,
      child: Scaffold(
        backgroundColor:
            Colors.white, // const Color.fromARGB(255, 232, 240, 236),
        //backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formGlobalKey,
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Add Product",
                              style: TextStyle(
                                  // shadows: [
                                  //   Shadow(
                                  //       color:
                                  //           Color.fromARGB(255, 29, 201, 192),
                                  //       offset: Offset.zero,
                                  //       blurRadius: 4),
                                  // ],
                                  color: Color.fromARGB(255, 29, 201, 192),
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextFeild(
                      type: TextInputType.name,
                      hint: "i.e. meat, fish..",
                      label: "Category Name",
                      controller: categoryNameController),
                  MyTextFeild(
                      type: TextInputType.name,
                      hint: "i.e. chicken,mutton..",
                      label: "Product Name",
                      controller: productNameController),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: MyTextFeild(
                              hint: "i.e. 20 ",
                              label: "Max buying Kg/person",
                              icon: Icons.location_city,
                              controller: maxKgController,
                              type: TextInputType.number),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15, right: 15),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: GlobalVariables.selectedNavBarColor,
                                borderRadius: BorderRadius.circular(12)),
                            height: 50,
                            width: 55,
                            child: Text(
                              "KG",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            child: MyTextFeild(
                                hint: "i.e. 0.5",
                                label: "Min buying Kg/person",
                                icon: Icons.location_city,
                                controller: minKgController,
                                type: TextInputType.number)),
                        Padding(
                          padding: EdgeInsets.only(top: 15, right: 15),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: GlobalVariables.selectedNavBarColor,
                                borderRadius: BorderRadius.circular(12)),
                            height: 50,
                            width: 55,
                            child: Text(
                              "KG",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ]),
                  MyTextFeild(
                      hint: "i.e 50 ",
                      label: "Available Meat/day",
                      icon: Icons.location_city,
                      controller: maxKgLimitPerDayController,
                      type: TextInputType.number),
                  MyTextFeild(
                      maxline: 3,
                      hint: "Enter your Description",
                      label: "Description",
                      icon: Icons.pin,
                      controller: descriptionController,
                      type: TextInputType.text),
                  MyTextFeild(
                      hint: "Enter your higlights",
                      label: "Higlighted description",
                      icon: Icons.pin,
                      controller: highlightedDescriptionController,
                      type: TextInputType.text),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15.0),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: GlobalVariables.secondaryColor,
                            style: BorderStyle.solid,
                            width: 2),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Do you have Stock ?',
                            style: TextStyle(
                                color: GlobalVariables.secondaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          Switch(
                            value: isHavingStock,
                            onChanged: (value) {
                              setState(() {
                                isHavingStock = value;
                                print(isHavingStock);
                              });
                            },
                            activeTrackColor: GlobalVariables.secondaryColor,
                            activeColor: GlobalVariables.selectedNavBarColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  isHavingStock
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                              Expanded(
                                  child: MyTextFeild(
                                      type: TextInputType.number,
                                      hint: "Stock quantity",
                                      label: "Stocks In KG",
                                      controller: stockInKgController)),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 15, right: 15),
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color:
                                          GlobalVariables.selectedNavBarColor,
                                      borderRadius: BorderRadius.circular(12)),
                                  height: 50,
                                  width: 55,
                                  child: const Text(
                                    "KG",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            ])
                      : Container(),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            child: MyTextFeild(
                                type: TextInputType.number,
                                hint: "Enter your price",
                                label: "Price/KG",
                                controller: pricePerKgController)),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, right: 15),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: GlobalVariables.selectedNavBarColor,
                                borderRadius: BorderRadius.circular(12)),
                            height: 50,
                            width: 55,
                            child: const Text(
                              "KG",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ]),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15.0),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: GlobalVariables.secondaryColor,
                            style: BorderStyle.solid,
                            width: 2),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Will you offer discount?',
                                style: TextStyle(
                                    color: GlobalVariables.secondaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                              Switch(
                                value: isDiscountable,
                                onChanged: (value) {
                                  setState(() {
                                    isDiscountable = value;
                                    print(isDiscountable);
                                  });
                                },
                                activeTrackColor:
                                    GlobalVariables.secondaryColor,
                                activeColor:
                                    GlobalVariables.selectedNavBarColor,
                              ),
                            ],
                          ),
                          isDiscountable
                              ? const Padding(
                                  padding: EdgeInsets.all(3.0),
                                  child: Text(
                                    'Note: The dicount amount will be deducted from the original price',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                  isDiscountable
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                              Expanded(
                                  child: MyTextFeild(
                                      type: TextInputType.number,
                                      hint: "i.e.  2 %, 5% ..",
                                      label: "Discount Percentage",
                                      controller:
                                          discountInPercentageController)),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 15, right: 15),
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color:
                                          GlobalVariables.selectedNavBarColor,
                                      borderRadius: BorderRadius.circular(12)),
                                  height: 50,
                                  width: 55,
                                  child: const Text(
                                    "%",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            ])
                      : Container(),
                  const SizedBox(
                    height: 30,
                  ),
                  images.isNotEmpty
                      ? CarouselSlider(
                          items: images.map(
                            (i) {
                              return Builder(
                                builder: (BuildContext context) => Image.file(
                                  i,
                                  fit: BoxFit.cover,
                                  height: 200,
                                ),
                              );
                            },
                          ).toList(),
                          options: CarouselOptions(
                            viewportFraction: 1,
                            height: 200,
                          ),
                        )
                      : GestureDetector(
                          onTap: selectImages,
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(10),
                            dashPattern: const [10, 4],
                            strokeCap: StrokeCap.round,
                            child: Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.folder_open,
                                    size: 40,
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    'Select Product Images',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          backgroundColor: GlobalVariables.selectedNavBarColor),
                      onPressed: () async {
                        MeatSellerService meatSellerService =
                            MeatSellerService();

                        if (formGlobalKey.currentState!.validate()) {
                          formGlobalKey.currentState!.save();
                          initalizeShared();

                          // final firebaseUser = context.watch<User?>();

                          //  uploadFile();
                          const uid = Uuid();
                          // final firebaseUser = context.watch<User?>();

                          MeatSellerModel meatSellerModel = MeatSellerModel(
                              sellerName: widget.sellerDetails['sellerName'],
                              contactNumber:
                                  widget.sellerDetails['phoneNumber'],
                              meatShopName: widget.sellerDetails['shopName'],
                              location: SellerLocation(
                                  coordinates: [
                                    widget.sellerDetails['location'][0]
                                        .toString(),
                                    widget.sellerDetails['location'][1]
                                        .toString(),
                                  ],
                                  address: widget.sellerDetails['Address'],
                                  pincode: widget.sellerDetails['pincode']),
                              isNewMeatSeller: true,
                              isActive: true,
                              timings: Timings(
                                  closingTime: widget.sellerDetails['timings']
                                      ['closingTime'],
                                  noOfOpenDays: widget.sellerDetails['timings']
                                      ['noOfOpenDays'],
                                  openingTime: widget.sellerDetails['timings']
                                      ['openingTime']),
                              products: [
                                Product(
                                    productId: uid.v4(),
                                    categoryName: categoryNameController.text,
                                    productName: productNameController.text,
                                    maxKg: int.parse(maxKgController.text),
                                    minKg: double.parse(minKgController.text),
                                    maxKgLimitPerDay:
                                        int.parse(maxKgController.text),
                                    description: descriptionController.text,
                                    highlightedDescription:
                                        highlightedDescriptionController.text,
                                    images: [
                                      "https://firebasestorage.googleapis.com/v0/b/meatzy-9f511.appspot.com/o/files%2FqKpe3Pt735fz0dzr4Jcw3Y7D0Pr2%2Fdata%2Fuser%2F0%2Fcom.example.meatzy%2Fcache%2Ffile_picker%2FIMG_20220909_212432.jpg?alt=media&token=af48b380-005b-4710-a440-d189e2cfad18"
                                    ],
                                    isHavingStock: isHavingStock,
                                    stockInKg:
                                        int.parse(stockInKgController.text),
                                    pricePerKg:
                                        int.parse(pricePerKgController.text),
                                    isVerified: false,
                                    buyerId: [],
                                    isDiscountable: isDiscountable,
                                    discountInPercentage: int.parse(
                                        discountInPercentageController.text),
                                    ratings: 0,
                                    sellerId: firebaseUser!.uid)
                              ],
                              orders: [
                                // Order(
                                //     buyerId: '',
                                //     deliveryDate: '',
                                //     deliveryLocation: Location(
                                //         address: '',
                                //         coordinates: [],
                                //         pincode: ''),
                                //     discountPercentage: 0,
                                //     isDiscount: false,
                                //     orderStatus: '',
                                //     orderedDate: '',
                                //     productId: '',
                                //     quantityInKg: 0)
                              ],
                              ratings: 0,
                              notifications: [],
                              shopImage: '');

                          print(
                              'the final result is ${meatSellerModel.products![0].sellerId}');
                          await meatSellerService
                              .addMeatSellerDetails(context,
                                  data: meatSellerModel.toMap())
                              .then((value) async {
                            print("the value 1 is $value");
                            // final meatsellerprovider =
                            //     Provider.of<MeatSellerProvider>(context,
                            //         listen: false);

                            // meatsellerprovider
                            //     .setUserFromModel(meatSellerModel);

                            final prefs = await SharedPreferences.getInstance();
                            prefs.setBool("ismeatsellerRegistered", true);
                            print("data retreived successfully ");
                          }).then((value) => Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  MainHomePage.route,
                                  (route) => false));
                        }
                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
