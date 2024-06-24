// import 'package:flutter/material.dart';

// Widget mywidget() {
//   return StreamBuilder<List<DocumentSnapshot>>(
//     initialData: null,
//     stream: UserFirebaseService(user: Provider.of<User>(context, listen: false))
//         .getAllMeatSeller(),
//     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
//         List<DocumentSnapshot> allDocumentSnap = snapshot.data;

//         print("allprodcts in f builder is ${allDocumentSnap.length}");

//         return ListView.builder(
//             scrollDirection: Axis.vertical,
//             controller: controller,
//             shrinkWrap: true,
//             itemCount: allDocumentSnap.length,
//             itemBuilder: (context, index) {
//               print("the alldocumentsnap is ${allDocumentSnap.length}");
//               DocumentSnapshot documentSnapshot = allDocumentSnap[index];
//               var docId = documentSnapshot.id;
//               MeatSellerModel singleShop =
//                   MeatSellerModel.fromMap(documentSnapshot);
//               print('///////////');
//               print("the length is ${allDocumentSnap.length}");
//               print("the index is ${index}");

//               print("singleshop is ${singleShop.sellerName}");
//               print('///////////');

//               return Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: ((context) =>
                        //                   DetailedProductViewScreen(
                        //                       liveStockDetails:
                        //                           liveStockDetails))));
                        //     },
                        //     child: Container(
                        //       height: MediaQuery.of(context).size.height * 0.3,
                        //       width: MediaQuery.of(context).size.width * 0.9,
                        //       decoration: BoxDecoration(
                        //           border: Border.all(
                        //               color:
                        //                   GlobalVariables.selectedNavBarColor,
                        //               width: 2),
                        //           // color: Color.fromARGB(255, 0, 42, 22),
                        //           borderRadius: BorderRadius.circular(12)),
                        //       child: Row(
                        //         children: [
                        //           // CachedNetworkImage(
                        //           //   imageUrl:
                        //           //       "https://media.istockphoto.com/photos/variety-of-raw-black-angus-prime-meat-steaks-picture-id923692030?k=20&m=923692030&s=612x612&w=0&h=k-b2wtmHwBbpmSM74dN0gZzRD9oEwBUYiXdlWYD6mHY=",
                        //           //   imageBuilder: (context, imageProvider) => Container(
                        //           //     height: MediaQuery.of(context).size.height * 0.3,
                        //           //     width: MediaQuery.of(context).size.width * 0.42,
                        //           //     decoration: BoxDecoration(
                        //           //       borderRadius: BorderRadius.only(
                        //           //           topLeft: Radius.circular(12),
                        //           //           bottomLeft: Radius.circular(12)),
                        //           //       image: DecorationImage(
                        //           //         image: imageProvider,
                        //           //         fit: BoxFit.cover,
                        //           //       ),
                        //           //     ),
                        //           //   ),
                        //           //   placeholder: (context, url) =>
                        //           //       CircularProgressIndicator(),
                        //           //   errorWidget: (context, url, error) =>
                        //           //       Icon(Icons.error),
                        //           // ),
                        //           Container(
                        //             height: MediaQuery.of(context).size.height *
                        //                 0.3,
                        //             width: MediaQuery.of(context).size.width *
                        //                 0.43,
                        //             // padding: EdgeInsets.only(left: 1),
                        //             decoration: BoxDecoration(
                        //                 color: Colors.grey,
                        //                 borderRadius: const BorderRadius.only(
                        //                     topLeft: Radius.circular(12),
                        //                     bottomLeft: Radius.circular(12)),
                        //                 border: Border.all(
                        //                     color: GlobalVariables
                        //                         .selectedNavBarColor)),
                        //             child: ClipRRect(
                        //               borderRadius: BorderRadius.only(
                        //                   topLeft: Radius.circular(12),
                        //                   bottomLeft: Radius.circular(12)),
                        //               child: CachedNetworkImage(
                        //                 fit: BoxFit.cover,
                        //                 imageUrl: liveStockDetails.images![0],
                        //                 placeholder: (context, url) =>
                        //                     const Center(
                        //                   child: CircularProgressIndicator(
                        //                     color:
                        //                         GlobalVariables.secondaryColor,
                        //                   ),
                        //                 ),
                        //                 errorWidget: (context, url, error) =>
                        //                     const Icon(
                        //                   Icons.error,
                        //                   color: Colors.grey,
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //           Expanded(
                        //             child: Container(
                        //                 height:
                        //                     MediaQuery.of(context).size.height *
                        //                         0.3,
                        //                 width:
                        //                     MediaQuery.of(context).size.width *
                        //                         0.5,
                        //                 padding: EdgeInsets.all(8),
                        //                 decoration: const BoxDecoration(
                        //                     // color: Colors.blue,

                        //                     borderRadius: BorderRadius.only(
                        //                         topRight: Radius.circular(12),
                        //                         bottomRight:
                        //                             Radius.circular(12))),
                        //                 child: Column(
                        //                   children: [
                        //                     Text(
                        //                       liveStockDetails.liveStockType ??
                        //                           '',
                        //                       maxLines: 1,
                        //                       style: TextStyle(
                        //                           color: GlobalVariables
                        //                               .selectedNavBarColor,
                        //                           fontSize: 16,
                        //                           fontWeight: FontWeight.w600,
                        //                           overflow:
                        //                               TextOverflow.ellipsis),
                        //                     ),
                        //                     Text(
                        //                       liveStockDetails.description ??
                        //                           '',
                        //                       maxLines: 2,
                        //                       style: const TextStyle(
                        //                           color: GlobalVariables
                        //                               .secondaryColor,
                        //                           fontSize: 13,
                        //                           fontWeight: FontWeight.w300,
                        //                           overflow:
                        //                               TextOverflow.ellipsis),
                        //                     ),
                        //                     // RatingBarIndicator(
                        //                     //   textDirection: TextDirection.ltr,
                        //                     //   rating:
                        //                     //       liveStockDetails.ratings.toDouble(),
                        //                     //   itemBuilder: (context, index) =>
                        //                     //       const Icon(
                        //                     //     Icons.star,
                        //                     //     color: Colors.amber,
                        //                     //   ),
                        //                     //   itemCount: 5,
                        //                     //   itemSize: 10.0,
                        //                     //   direction: Axis.horizontal,
                        //                     // ),
                        //                     HorizontalTitleText(
                        //                         title: "Price",
                        //                         text:
                        //                             '₹ ${liveStockDetails.priceQuoted.toString()}',
                        //                         maxline: 1)
                        //                   ],
                        //                 )),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // );
//             });
//       }
//       return const Center(child: Text("Please wait"));
//     },
//   );
// }
