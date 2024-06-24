// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:meatzy_app/Constants/Global_Variables.dart';
import 'package:meatzy_app/Model/meat_seller_model.dart';
import 'package:meatzy_app/Service/user_firebase_service.dart';
import 'package:provider/provider.dart';

import '../../../Widget/horizontal_text_widget.dart';
import 'detailed_meat_product_view_screen.dart';

class ShopViewScreen extends StatelessWidget {
  String docId;
  String shopAddress;
  // MeatSellerModel meatshop;
  ShopViewScreen({
    Key? key,
    required this.docId,
    required this.shopAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('%%%%%%%');
    // print("the meatshop is ${meatshop['products'][0]}");
    print("the docID is ${docId}");
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          backgroundColor: GlobalVariables.secondaryColor,
          title: Text(
            'ShopDetails',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: StreamBuilder<List<Product>>(
          stream: UserFirebaseService(
                  user: Provider.of<User>(context, listen: false))
              .getAllProductFromSingleMeatSeller(docId),
          builder: (context, snapshot) {
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
              List<Product>? allProduct = snapshot.data!.reversed.toList();
              return ListView.builder(
                  itemCount: allProduct!.length, //meatshop['products']?.length,
                  itemBuilder: (context, index) {
                    Product product = allProduct[index];
                    print('##########');

                    print(
                        "the product is ${product.productId} and sellerId is ${product.sellerId}");
                    print('##########');

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          print("the productId is ${product.productId} ");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      DetailedMeatProductViewScreen(
                                        shopAddress: shopAddress,
                                        //   sellerphoneNumber: meatshop['contactNumber'],
                                        product: product,
                                      ))));
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
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.width * 0.43,
                                // padding: EdgeInsets.only(left: 1),
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        bottomLeft: Radius.circular(12)),
                                    border: Border.all(
                                        color: GlobalVariables
                                            .selectedNavBarColor)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      bottomLeft: Radius.circular(12)),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: product.images[0],
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
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    padding: EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                        // color: Colors.blue,

                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(12),
                                            bottomRight: Radius.circular(12))),
                                    child: Column(
                                      children: [
                                        Text(
                                          product.productName,
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: GlobalVariables
                                                  .selectedNavBarColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                        Text(
                                          product.description,
                                          maxLines: 2,
                                          style: const TextStyle(
                                              color: GlobalVariables
                                                  .secondaryColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w300,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                        RatingBarIndicator(
                                          textDirection: TextDirection.ltr,
                                          rating: product.ratings.toDouble(),
                                          itemBuilder: (context, index) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          itemCount: 5,
                                          itemSize: 10.0,
                                          direction: Axis.horizontal,
                                        ),
                                        HorizontalTitleText(
                                            title: "Price",
                                            text:
                                                '₹ ${product.pricePerKg.toString()}',
                                            maxline: 1)
                                      ],
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return Container();
            }
          },
        ));
  }
}
