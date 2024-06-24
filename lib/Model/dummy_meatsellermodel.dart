// // To parse this JSON data, do
// //
// //     final sellerModel = sellerModelFromMap(jsonString);

// import 'package:meta/meta.dart';
// import 'dart:convert';

// class SellerModel {
//   SellerModel({
//     required this.sellerName,
//     required this.contactNumber,
//     required this.meatShopName,
//     required this.location,
//     required this.isNewMeatSeller,
//     required this.isActive,
//     required this.timings,
//     required this.products,
//     required this.orders,
//     required this.ratings,
//   });

//   String sellerName;
//   int contactNumber;
//   String meatShopName;
//   Location location;
//   bool isNewMeatSeller;
//   bool isActive;
//   Timings timings;
//   List<Product> products;
//   List<Order> orders;
//   int ratings;

//   SellerModel copyWith({
//     required String sellerName,
//     required int contactNumber,
//     required String meatShopName,
//     required Location location,
//     required bool isNewMeatSeller,
//     required bool isActive,
//     required Timings timings,
//     required List<Product> products,
//     required List<Order> orders,
//     required int ratings,
//   }) =>
//       SellerModel(
//         sellerName: sellerName,
//         contactNumber: contactNumber,
//         meatShopName: meatShopName,
//         location: location,
//         isNewMeatSeller: isNewMeatSeller,
//         isActive: isActive,
//         timings: timings,
//         products: products,
//         orders: orders,
//         ratings: ratings,
//       );

//   factory SellerModel.fromJson(String str) =>
//       SellerModel.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory SellerModel.fromMap(Map<String, dynamic> json) => SellerModel(
//         sellerName: json["sellerName"],
//         contactNumber: json["contactNumber"],
//         meatShopName: json["meatShopName"],
//         location: Location.fromMap(json["location"]),
//         isNewMeatSeller: json["isNewMeatSeller"],
//         isActive: json["isActive"],
//         timings: Timings.fromMap(json["timings"]),
//         products:
//             List<Product>.from(json["products"].map((x) => Product.fromMap(x))),
//         orders: List<Order>.from(json["orders"].map((x) => Order.fromMap(x))),
//         ratings: json["ratings"],
//       );

//   Map<String, dynamic> toMap() => {
//         "sellerName": sellerName,
//         "contactNumber": contactNumber,
//         "meatShopName": meatShopName,
//         "location": location.toMap(),
//         "isNewMeatSeller": isNewMeatSeller,
//         "isActive": isActive,
//         "timings": timings.toMap(),
//         "products": List<dynamic>.from(products.map((x) => x.toMap())),
//         "orders": List<dynamic>.from(orders.map((x) => x.toMap())),
//         "ratings": ratings,
//       };
// }

// class Location {
//   Location({
//     required this.coordinates,
//     required this.address,
//     required this.pincode,
//   });

//   List<String> coordinates;
//   String address;
//   String pincode;

//   Location copyWith({
//     required List<String> coordinates,
//     required String address,
//     required String pincode,
//   }) =>
//       Location(
//         coordinates: coordinates,
//         address: address,
//         pincode: pincode,
//       );

//   factory Location.fromJson(String str) => Location.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory Location.fromMap(Map<String, dynamic> json) => Location(
//         coordinates: List<String>.from(json["coordinates"].map((x) => x)),
//         address: json["address"],
//         pincode: json["pincode"],
//       );

//   Map<String, dynamic> toMap() => {
//         "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
//         "address": address,
//         "pincode": pincode,
//       };
// }

// class Order {
//   Order({
//     required this.productId,
//     required this.orderedDate,
//     required this.deliveryDate,
//     required this.orderStatus,
//     required this.buyerId,
//     required this.quantityInKg,
//     required this.deliveryLocation,
//     required this.isDiscount,
//     required this.discountPercentage,
//   });

//   String productId;
//   String orderedDate;
//   String deliveryDate;
//   String orderStatus;
//   String buyerId;
//   int quantityInKg;
//   Location deliveryLocation;
//   bool isDiscount;
//   int discountPercentage;

//   Order copyWith({
//     required String productId,
//     required String orderedDate,
//     required String deliveryDate,
//     required String orderStatus,
//     required String buyerId,
//     required int quantityInKg,
//     required Location deliveryLocation,
//     required bool isDiscount,
//     required int discountPercentage,
//   }) =>
//       Order(
//         productId: productId,
//         orderedDate: orderedDate,
//         deliveryDate: deliveryDate,
//         orderStatus: orderStatus,
//         buyerId: buyerId,
//         quantityInKg: quantityInKg,
//         deliveryLocation: deliveryLocation,
//         isDiscount: isDiscount,
//         discountPercentage: discountPercentage,
//       );

//   factory Order.fromJson(String str) => Order.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory Order.fromMap(Map<String, dynamic> json) => Order(
//         productId: json["productId"],
//         orderedDate: json["orderedDate"],
//         deliveryDate: json["deliveryDate"],
//         orderStatus: json["orderStatus"],
//         buyerId: json["buyerId"],
//         quantityInKg: json["quantityInKg"],
//         deliveryLocation: Location.fromMap(json["deliveryLocation"]),
//         isDiscount: json["isDiscount"],
//         discountPercentage: json["discountPercentage"],
//       );

//   Map<String, dynamic> toMap() => {
//         "productId": productId,
//         "orderedDate": orderedDate,
//         "deliveryDate": deliveryDate,
//         "orderStatus": orderStatus,
//         "buyerId": buyerId,
//         "quantityInKg": quantityInKg,
//         "deliveryLocation": deliveryLocation.toMap(),
//         "isDiscount": isDiscount,
//         "discountPercentage": discountPercentage,
//       };
// }

// class Product {
//   Product({
//     required this.productId,
//     required this.categoryName,
//     required this.productName,
//     required this.maxKg,
//     required this.minKg,
//     required this.maxKgLimitPerDay,
//     required this.description,
//     required this.highlightedDescription,
//     required this.images,
//     required this.isHavingStock,
//     required this.stockInKg,
//     required this.pricePerKg,
//     required this.isVerified,
//     required this.buyerId,
//     required this.isDiscountable,
//     required this.discountInPercentage,
//     required this.ratings,
//     required this.sellerId,
//   });

//   String productId;
//   String categoryName;
//   String productName;
//   int maxKg;
//   double minKg;
//   int maxKgLimitPerDay;
//   String description;
//   String highlightedDescription;
//   List<String> images;
//   bool isHavingStock;
//   int stockInKg;
//   int pricePerKg;
//   bool isVerified;
//   List<String> buyerId;
//   bool isDiscountable;
//   int discountInPercentage;
//   int ratings;
//   String sellerId;

//   Product copyWith({
//     required String productId,
//     required String categoryName,
//     required String productName,
//     required int maxKg,
//     required double minKg,
//     required int maxKgLimitPerDay,
//     required String description,
//     required String highlightedDescription,
//     required List<String> images,
//     required bool isHavingStock,
//     required int stockInKg,
//     required int pricePerKg,
//     required bool isVerified,
//     required List<String> buyerId,
//     required bool isDiscountable,
//     required int discountInPercentage,
//     required int ratings,
//     required String sellerId,
//   }) =>
//       Product(
//         productId: productId,
//         categoryName: categoryName,
//         productName: productName,
//         maxKg: maxKg,
//         minKg: minKg,
//         maxKgLimitPerDay: maxKgLimitPerDay,
//         description: description,
//         highlightedDescription: highlightedDescription,
//         images: images,
//         isHavingStock: isHavingStock,
//         stockInKg: stockInKg,
//         pricePerKg: pricePerKg,
//         isVerified: isVerified,
//         buyerId: buyerId,
//         isDiscountable: isDiscountable,
//         discountInPercentage: discountInPercentage,
//         ratings: ratings,
//         sellerId: sellerId,
//       );

//   factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory Product.fromMap(Map<String, dynamic> json) => Product(
//         productId: json["productId"],
//         categoryName: json["categoryName"],
//         productName: json["productName"],
//         maxKg: json["maxKg"],
//         minKg: json["minKg"].toDouble(),
//         maxKgLimitPerDay: json["maxKgLimitPerDay"],
//         description: json["description"],
//         highlightedDescription: json["highlightedDescription"],
//         images: List<String>.from(json["images"].map((x) => x)),
//         isHavingStock: json["isHavingStock"],
//         stockInKg: json["stockInKg"],
//         pricePerKg: json["pricePerKg"],
//         isVerified: json["isVerified"],
//         buyerId: List<String>.from(json["buyerID"].map((x) => x)),
//         isDiscountable: json["isDiscountable"],
//         discountInPercentage: json["discountInPercentage"],
//         ratings: json["ratings"],
//         sellerId: json["sellerId"],
//       );

//   Map<String, dynamic> toMap() => {
//         "productId": productId,
//         "categoryName": categoryName,
//         "productName": productName,
//         "maxKg": maxKg,
//         "minKg": minKg,
//         "maxKgLimitPerDay": maxKgLimitPerDay,
//         "description": description,
//         "highlightedDescription": highlightedDescription,
//         "images": List<dynamic>.from(images.map((x) => x)),
//         "isHavingStock": isHavingStock,
//         "stockInKg": stockInKg,
//         "pricePerKg": pricePerKg,
//         "isVerified": isVerified,
//         "buyerID": List<dynamic>.from(buyerId.map((x) => x)),
//         "isDiscountable": isDiscountable,
//         "discountInPercentage": discountInPercentage,
//         "ratings": ratings,
//         "sellerId": sellerId,
//       };
// }

// class Timings {
//   Timings({
//     required this.openingTime,
//     required this.closingTime,
//     required this.noOfOpenDays,
//   });

//   String openingTime;
//   String closingTime;
//   int noOfOpenDays;

//   Timings copyWith({
//     required String openingTime,
//     required String closingTime,
//     required int noOfOpenDays,
//   }) =>
//       Timings(
//         openingTime: openingTime,
//         closingTime: closingTime,
//         noOfOpenDays: noOfOpenDays,
//       );

//   factory Timings.fromJson(String str) => Timings.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory Timings.fromMap(Map<String, dynamic> json) => Timings(
//         openingTime: json["openingTime"],
//         closingTime: json["closingTime"],
//         noOfOpenDays: json["noOfOpenDays"],
//       );

//   Map<String, dynamic> toMap() => {
//         "openingTime": openingTime,
//         "closingTime": closingTime,
//         "noOfOpenDays": noOfOpenDays,
//       };
// }








//with optional properties code


// To parse this JSON data, do
//
//     final sellerModel = sellerModelFromMap(jsonString);

// import 'package:meta/meta.dart';
// import 'dart:convert';

// class SellerModel {
//     SellerModel({
//         @required this.sellerName,
//         @required this.contactNumber,
//         @required this.meatShopName,
//         @required this.location,
//         @required this.isNewMeatSeller,
//         @required this.isActive,
//         @required this.timings,
//         @required this.products,
//         @required this.orders,
//         @required this.ratings,
//     });

//     String sellerName;
//     int contactNumber;
//     String meatShopName;
//     Location location;
//     bool isNewMeatSeller;
//     bool isActive;
//     Timings timings;
//     List<Product> products;
//     List<Order> orders;
//     int ratings;

//     SellerModel copyWith({
//         String sellerName,
//         int contactNumber,
//         String meatShopName,
//         Location location,
//         bool isNewMeatSeller,
//         bool isActive,
//         Timings timings,
//         List<Product> products,
//         List<Order> orders,
//         int ratings,
//     }) => 
//         SellerModel(
//             sellerName: sellerName ?? this.sellerName,
//             contactNumber: contactNumber ?? this.contactNumber,
//             meatShopName: meatShopName ?? this.meatShopName,
//             location: location ?? this.location,
//             isNewMeatSeller: isNewMeatSeller ?? this.isNewMeatSeller,
//             isActive: isActive ?? this.isActive,
//             timings: timings ?? this.timings,
//             products: products ?? this.products,
//             orders: orders ?? this.orders,
//             ratings: ratings ?? this.ratings,
//         );

//     factory SellerModel.fromJson(String str) => SellerModel.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory SellerModel.fromMap(Map<String, dynamic> json) => SellerModel(
//         sellerName: json["sellerName"] == null ? null : json["sellerName"],
//         contactNumber: json["contactNumber"] == null ? null : json["contactNumber"],
//         meatShopName: json["meatShopName"] == null ? null : json["meatShopName"],
//         location: json["location"] == null ? null : Location.fromMap(json["location"]),
//         isNewMeatSeller: json["isNewMeatSeller"] == null ? null : json["isNewMeatSeller"],
//         isActive: json["isActive"] == null ? null : json["isActive"],
//         timings: json["timings"] == null ? null : Timings.fromMap(json["timings"]),
//         products: json["products"] == null ? null : List<Product>.from(json["products"].map((x) => Product.fromMap(x))),
//         orders: json["orders"] == null ? null : List<Order>.from(json["orders"].map((x) => Order.fromMap(x))),
//         ratings: json["ratings"] == null ? null : json["ratings"],
//     );

//     Map<String, dynamic> toMap() => {
//         "sellerName": sellerName == null ? null : sellerName,
//         "contactNumber": contactNumber == null ? null : contactNumber,
//         "meatShopName": meatShopName == null ? null : meatShopName,
//         "location": location == null ? null : location.toMap(),
//         "isNewMeatSeller": isNewMeatSeller == null ? null : isNewMeatSeller,
//         "isActive": isActive == null ? null : isActive,
//         "timings": timings == null ? null : timings.toMap(),
//         "products": products == null ? null : List<dynamic>.from(products.map((x) => x.toMap())),
//         "orders": orders == null ? null : List<dynamic>.from(orders.map((x) => x.toMap())),
//         "ratings": ratings == null ? null : ratings,
//     };
// }

// class Location {
//     Location({
//         @required this.coordinates,
//         @required this.address,
//         @required this.pincode,
//     });

//     List<String> coordinates;
//     String address;
//     String pincode;

//     Location copyWith({
//         List<String> coordinates,
//         String address,
//         String pincode,
//     }) => 
//         Location(
//             coordinates: coordinates ?? this.coordinates,
//             address: address ?? this.address,
//             pincode: pincode ?? this.pincode,
//         );

//     factory Location.fromJson(String str) => Location.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory Location.fromMap(Map<String, dynamic> json) => Location(
//         coordinates: json["coordinates"] == null ? null : List<String>.from(json["coordinates"].map((x) => x)),
//         address: json["address"] == null ? null : json["address"],
//         pincode: json["pincode"] == null ? null : json["pincode"],
//     );

//     Map<String, dynamic> toMap() => {
//         "coordinates": coordinates == null ? null : List<dynamic>.from(coordinates.map((x) => x)),
//         "address": address == null ? null : address,
//         "pincode": pincode == null ? null : pincode,
//     };
// }

// class Order {
//     Order({
//         @required this.productId,
//         @required this.orderedDate,
//         @required this.deliveryDate,
//         @required this.orderStatus,
//         @required this.buyerId,
//         @required this.quantityInKg,
//         @required this.deliveryLocation,
//         @required this.isDiscount,
//         @required this.discountPercentage,
//     });

//     String productId;
//     String orderedDate;
//     String deliveryDate;
//     String orderStatus;
//     String buyerId;
//     int quantityInKg;
//     Location deliveryLocation;
//     bool isDiscount;
//     int discountPercentage;

//     Order copyWith({
//         String productId,
//         String orderedDate,
//         String deliveryDate,
//         String orderStatus,
//         String buyerId,
//         int quantityInKg,
//         Location deliveryLocation,
//         bool isDiscount,
//         int discountPercentage,
//     }) => 
//         Order(
//             productId: productId ?? this.productId,
//             orderedDate: orderedDate ?? this.orderedDate,
//             deliveryDate: deliveryDate ?? this.deliveryDate,
//             orderStatus: orderStatus ?? this.orderStatus,
//             buyerId: buyerId ?? this.buyerId,
//             quantityInKg: quantityInKg ?? this.quantityInKg,
//             deliveryLocation: deliveryLocation ?? this.deliveryLocation,
//             isDiscount: isDiscount ?? this.isDiscount,
//             discountPercentage: discountPercentage ?? this.discountPercentage,
//         );

//     factory Order.fromJson(String str) => Order.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory Order.fromMap(Map<String, dynamic> json) => Order(
//         productId: json["productId"] == null ? null : json["productId"],
//         orderedDate: json["orderedDate"] == null ? null : json["orderedDate"],
//         deliveryDate: json["deliveryDate"] == null ? null : json["deliveryDate"],
//         orderStatus: json["orderStatus"] == null ? null : json["orderStatus"],
//         buyerId: json["buyerId"] == null ? null : json["buyerId"],
//         quantityInKg: json["quantityInKg"] == null ? null : json["quantityInKg"],
//         deliveryLocation: json["deliveryLocation"] == null ? null : Location.fromMap(json["deliveryLocation"]),
//         isDiscount: json["isDiscount"] == null ? null : json["isDiscount"],
//         discountPercentage: json["discountPercentage"] == null ? null : json["discountPercentage"],
//     );

//     Map<String, dynamic> toMap() => {
//         "productId": productId == null ? null : productId,
//         "orderedDate": orderedDate == null ? null : orderedDate,
//         "deliveryDate": deliveryDate == null ? null : deliveryDate,
//         "orderStatus": orderStatus == null ? null : orderStatus,
//         "buyerId": buyerId == null ? null : buyerId,
//         "quantityInKg": quantityInKg == null ? null : quantityInKg,
//         "deliveryLocation": deliveryLocation == null ? null : deliveryLocation.toMap(),
//         "isDiscount": isDiscount == null ? null : isDiscount,
//         "discountPercentage": discountPercentage == null ? null : discountPercentage,
//     };
// }

// class Product {
//     Product({
//         @required this.productId,
//         @required this.categoryName,
//         @required this.productName,
//         @required this.maxKg,
//         @required this.minKg,
//         @required this.maxKgLimitPerDay,
//         @required this.description,
//         @required this.highlightedDescription,
//         @required this.images,
//         @required this.isHavingStock,
//         @required this.stockInKg,
//         @required this.pricePerKg,
//         @required this.isVerified,
//         @required this.buyerId,
//         @required this.isDiscountable,
//         @required this.discountInPercentage,
//         @required this.ratings,
//         @required this.sellerId,
//     });

//     String productId;
//     String categoryName;
//     String productName;
//     int maxKg;
//     double minKg;
//     int maxKgLimitPerDay;
//     String description;
//     String highlightedDescription;
//     List<String> images;
//     bool isHavingStock;
//     int stockInKg;
//     int pricePerKg;
//     bool isVerified;
//     List<String> buyerId;
//     bool isDiscountable;
//     int discountInPercentage;
//     int ratings;
//     String sellerId;

//     Product copyWith({
//         String productId,
//         String categoryName,
//         String productName,
//         int maxKg,
//         double minKg,
//         int maxKgLimitPerDay,
//         String description,
//         String highlightedDescription,
//         List<String> images,
//         bool isHavingStock,
//         int stockInKg,
//         int pricePerKg,
//         bool isVerified,
//         List<String> buyerId,
//         bool isDiscountable,
//         int discountInPercentage,
//         int ratings,
//         String sellerId,
//     }) => 
//         Product(
//             productId: productId ?? this.productId,
//             categoryName: categoryName ?? this.categoryName,
//             productName: productName ?? this.productName,
//             maxKg: maxKg ?? this.maxKg,
//             minKg: minKg ?? this.minKg,
//             maxKgLimitPerDay: maxKgLimitPerDay ?? this.maxKgLimitPerDay,
//             description: description ?? this.description,
//             highlightedDescription: highlightedDescription ?? this.highlightedDescription,
//             images: images ?? this.images,
//             isHavingStock: isHavingStock ?? this.isHavingStock,
//             stockInKg: stockInKg ?? this.stockInKg,
//             pricePerKg: pricePerKg ?? this.pricePerKg,
//             isVerified: isVerified ?? this.isVerified,
//             buyerId: buyerId ?? this.buyerId,
//             isDiscountable: isDiscountable ?? this.isDiscountable,
//             discountInPercentage: discountInPercentage ?? this.discountInPercentage,
//             ratings: ratings ?? this.ratings,
//             sellerId: sellerId ?? this.sellerId,
//         );

//     factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory Product.fromMap(Map<String, dynamic> json) => Product(
//         productId: json["productId"] == null ? null : json["productId"],
//         categoryName: json["categoryName"] == null ? null : json["categoryName"],
//         productName: json["productName"] == null ? null : json["productName"],
//         maxKg: json["maxKg"] == null ? null : json["maxKg"],
//         minKg: json["minKg"] == null ? null : json["minKg"].toDouble(),
//         maxKgLimitPerDay: json["maxKgLimitPerDay"] == null ? null : json["maxKgLimitPerDay"],
//         description: json["description"] == null ? null : json["description"],
//         highlightedDescription: json["highlightedDescription"] == null ? null : json["highlightedDescription"],
//         images: json["images"] == null ? null : List<String>.from(json["images"].map((x) => x)),
//         isHavingStock: json["isHavingStock"] == null ? null : json["isHavingStock"],
//         stockInKg: json["stockInKg"] == null ? null : json["stockInKg"],
//         pricePerKg: json["pricePerKg"] == null ? null : json["pricePerKg"],
//         isVerified: json["isVerified"] == null ? null : json["isVerified"],
//         buyerId: json["buyerID"] == null ? null : List<String>.from(json["buyerID"].map((x) => x)),
//         isDiscountable: json["isDiscountable"] == null ? null : json["isDiscountable"],
//         discountInPercentage: json["discountInPercentage"] == null ? null : json["discountInPercentage"],
//         ratings: json["ratings"] == null ? null : json["ratings"],
//         sellerId: json["sellerId"] == null ? null : json["sellerId"],
//     );

//     Map<String, dynamic> toMap() => {
//         "productId": productId == null ? null : productId,
//         "categoryName": categoryName == null ? null : categoryName,
//         "productName": productName == null ? null : productName,
//         "maxKg": maxKg == null ? null : maxKg,
//         "minKg": minKg == null ? null : minKg,
//         "maxKgLimitPerDay": maxKgLimitPerDay == null ? null : maxKgLimitPerDay,
//         "description": description == null ? null : description,
//         "highlightedDescription": highlightedDescription == null ? null : highlightedDescription,
//         "images": images == null ? null : List<dynamic>.from(images.map((x) => x)),
//         "isHavingStock": isHavingStock == null ? null : isHavingStock,
//         "stockInKg": stockInKg == null ? null : stockInKg,
//         "pricePerKg": pricePerKg == null ? null : pricePerKg,
//         "isVerified": isVerified == null ? null : isVerified,
//         "buyerID": buyerId == null ? null : List<dynamic>.from(buyerId.map((x) => x)),
//         "isDiscountable": isDiscountable == null ? null : isDiscountable,
//         "discountInPercentage": discountInPercentage == null ? null : discountInPercentage,
//         "ratings": ratings == null ? null : ratings,
//         "sellerId": sellerId == null ? null : sellerId,
//     };
// }

// class Timings {
//     Timings({
//         @required this.openingTime,
//         @required this.closingTime,
//         @required this.noOfOpenDays,
//     });

//     String openingTime;
//     String closingTime;
//     int noOfOpenDays;

//     Timings copyWith({
//         String openingTime,
//         String closingTime,
//         int noOfOpenDays,
//     }) => 
//         Timings(
//             openingTime: openingTime ?? this.openingTime,
//             closingTime: closingTime ?? this.closingTime,
//             noOfOpenDays: noOfOpenDays ?? this.noOfOpenDays,
//         );

//     factory Timings.fromJson(String str) => Timings.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory Timings.fromMap(Map<String, dynamic> json) => Timings(
//         openingTime: json["openingTime"] == null ? null : json["openingTime"],
//         closingTime: json["closingTime"] == null ? null : json["closingTime"],
//         noOfOpenDays: json["noOfOpenDays"] == null ? null : json["noOfOpenDays"],
//     );

//     Map<String, dynamic> toMap() => {
//         "openingTime": openingTime == null ? null : openingTime,
//         "closingTime": closingTime == null ? null : closingTime,
//         "noOfOpenDays": noOfOpenDays == null ? null : noOfOpenDays,
//     };
// }
