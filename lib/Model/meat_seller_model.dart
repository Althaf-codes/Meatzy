// To parse this JSON data, do
//
//     final sellerModel = sellerModelFromMap(jsonString);

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class MeatSellerModel {
  MeatSellerModel(
      {required this.sellerName,
      required this.contactNumber,
      required this.meatShopName,
      required this.location,
      required this.isNewMeatSeller,
      required this.isActive,
      required this.timings,
      required this.products,
      required this.orders,
      required this.ratings,
      required this.notifications,
      required this.shopImage});

  String? sellerName;
  int? contactNumber;
  String? meatShopName;
  SellerLocation? location;
  bool? isNewMeatSeller;
  bool? isActive;
  Timings? timings;
  List<Product>? products;
  List<SellerOrder>? orders;
  int? ratings;
  List<SellerNotification> notifications;
  String? shopImage;

  MeatSellerModel copyWith({
    required String sellerName,
    required int contactNumber,
    required String meatShopName,
    required SellerLocation location,
    required bool isNewMeatSeller,
    required bool isActive,
    required Timings timings,
    required List<Product> products,
    required List<SellerOrder> orders,
    required int ratings,
    required List<SellerNotification> notifications,
    required String shopImage,
  }) =>
      MeatSellerModel(
        sellerName: sellerName,
        contactNumber: contactNumber,
        meatShopName: meatShopName,
        location: location,
        isNewMeatSeller: isNewMeatSeller,
        isActive: isActive,
        timings: timings,
        products: products,
        orders: orders,
        ratings: ratings,
        notifications: notifications,
        shopImage: shopImage,
      );

  factory MeatSellerModel.fromJson(String str) =>
      MeatSellerModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MeatSellerModel.fromMap(DocumentSnapshot json) => MeatSellerModel(
      sellerName: json["sellerName"],
      contactNumber: json["contactNumber"],
      meatShopName: json["meatShopName"],
      location: SellerLocation.fromMap(json["location"]),
      isNewMeatSeller: json["isNewMeatSeller"],
      isActive: json["isActive"],
      timings: Timings.fromMap(json["timings"]),
      products:
          List<Product>.from(json["products"].map((x) => Product.fromMap(x))),
      orders: List<SellerOrder>.from(
          json["orders"].map((x) => SellerOrder.fromMap(x))),
      ratings: json["ratings"],
      notifications: List<SellerNotification>.from(
          json["notifications"].map((x) => SellerNotification.fromMap(x))),
      shopImage: json["shopimage"]);

  Map<String, dynamic> toMap() => {
        "sellerName": sellerName,
        "contactNumber": contactNumber,
        "meatShopName": meatShopName,
        "location": location?.toMap(),
        "isNewMeatSeller": isNewMeatSeller,
        "isActive": isActive,
        "timings": timings?.toMap(),
        "products": List<dynamic>.from(products!.map((x) => x.toMap())),
        "orders": List<dynamic>.from(orders!.map((x) => x.toMap())),
        "ratings": ratings,
        "notifications":
            List<dynamic>.from(notifications.map((x) => x.toMap())),
        "shopImage": shopImage
      };
}

class SellerLocation {
  SellerLocation({
    required this.coordinates,
    required this.address,
    required this.pincode,
  });

  List<String> coordinates;
  String address;
  String pincode;

  SellerLocation copyWith({
    required List<String> coordinates,
    required String address,
    required String pincode,
  }) =>
      SellerLocation(
        coordinates: coordinates,
        address: address,
        pincode: pincode,
      );

  factory SellerLocation.fromJson(String str) =>
      SellerLocation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SellerLocation.fromMap(Map<String, dynamic> json) => SellerLocation(
        coordinates: List<String>.from(json["coordinates"].map((x) => x)),
        address: json["address"],
        pincode: json["pincode"],
      );

  Map<String, dynamic> toMap() => {
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
        "address": address,
        "pincode": pincode,
      };
}

class SellerOrder {
  SellerOrder({
    required this.price,
    required this.image,
    required this.productId,
    required this.orderedDate,
    required this.deliveryDate,
    required this.orderStatus,
    required this.buyerId,
    required this.quantityInKg,
    required this.deliveryLocation,
    required this.isDiscount,
    required this.discountPercentage,
    required this.orderId,
  });
  int price;
  String image;
  String productId;
  String orderedDate;
  String deliveryDate;
  String orderStatus;
  String buyerId;
  int quantityInKg;
  SellerLocation deliveryLocation;
  bool isDiscount;
  int discountPercentage;
  String orderId;

  SellerOrder copyWith({
    required String image,
    required int price,
    required String productId,
    required String orderedDate,
    required String deliveryDate,
    required String orderStatus,
    required String buyerId,
    required int quantityInKg,
    required SellerLocation deliveryLocation,
    required bool isDiscount,
    required int discountPercentage,
    required String orderId,
  }) =>
      SellerOrder(
        price: price,
        image: image,
        productId: productId,
        orderedDate: orderedDate,
        deliveryDate: deliveryDate,
        orderStatus: orderStatus,
        buyerId: buyerId,
        quantityInKg: quantityInKg,
        deliveryLocation: deliveryLocation,
        isDiscount: isDiscount,
        discountPercentage: discountPercentage,
        orderId: orderId,
      );

  factory SellerOrder.fromJson(String str) =>
      SellerOrder.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SellerOrder.fromMap(Map<String, dynamic> json) => SellerOrder(
        price: json["price"],
        image: json['image'],
        productId: json["productId"],
        orderedDate: json["orderedDate"],
        deliveryDate: json["deliveryDate"],
        orderStatus: json["orderStatus"],
        buyerId: json["buyerId"],
        quantityInKg: json["quantityInKg"],
        deliveryLocation: SellerLocation.fromMap(json["deliveryLocation"]),
        isDiscount: json["isDiscount"],
        discountPercentage: json["discountPercentage"],
        orderId: json["orderId"],
      );

  Map<String, dynamic> toMap() => {
        "image": image,
        "price": price,
        "productId": productId,
        "orderedDate": orderedDate,
        "deliveryDate": deliveryDate,
        "orderStatus": orderStatus,
        "buyerId": buyerId,
        "quantityInKg": quantityInKg,
        "deliveryLocation": deliveryLocation.toMap(),
        "isDiscount": isDiscount,
        "discountPercentage": discountPercentage,
        "orderId": orderId,
      };
}

class Product {
  Product({
    required this.productId,
    required this.categoryName,
    required this.productName,
    required this.maxKg,
    required this.minKg,
    required this.maxKgLimitPerDay,
    required this.description,
    required this.highlightedDescription,
    required this.images,
    required this.isHavingStock,
    required this.stockInKg,
    required this.pricePerKg,
    required this.isVerified,
    required this.buyerId,
    required this.isDiscountable,
    required this.discountInPercentage,
    required this.ratings,
    required this.sellerId,
  });

  String productId;
  String categoryName;
  String productName;
  int maxKg;
  double minKg;
  int maxKgLimitPerDay;
  String description;
  String highlightedDescription;
  List<String> images;
  bool isHavingStock;
  int stockInKg;
  int pricePerKg;
  bool isVerified;
  List<String> buyerId;
  bool isDiscountable;
  int discountInPercentage;
  int ratings;
  String sellerId;

  Product copyWith({
    required String? productId,
    required String? categoryName,
    required String? productName,
    required int? maxKg,
    required double? minKg,
    required int? maxKgLimitPerDay,
    required String? description,
    required String? highlightedDescription,
    required List<String>? images,
    required bool? isHavingStock,
    required int? stockInKg,
    required int? pricePerKg,
    required bool? isVerified,
    required List<String>? buyerId,
    required bool? isDiscountable,
    required int? discountInPercentage,
    required int? ratings,
    required String? sellerId,
  }) =>
      Product(
        productId: productId ?? '',
        categoryName: categoryName ?? '',
        productName: productName ?? '',
        maxKg: maxKg ?? 0,
        minKg: minKg ?? 0,
        maxKgLimitPerDay: maxKgLimitPerDay ?? 0,
        description: description ?? '',
        highlightedDescription: highlightedDescription ?? '',
        images: images ?? [],
        isHavingStock: isHavingStock ?? false,
        stockInKg: stockInKg ?? 0,
        pricePerKg: pricePerKg ?? 0,
        isVerified: isVerified ?? false,
        buyerId: buyerId ?? [],
        isDiscountable: isDiscountable ?? false,
        discountInPercentage: discountInPercentage ?? 0,
        ratings: ratings ?? 0,
        sellerId: sellerId ?? '',
      );

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        productId: json["productId"],
        categoryName: json["categoryName"],
        productName: json["productName"],
        maxKg: json["maxKg"],
        minKg: json["minKg"].toDouble(),
        maxKgLimitPerDay: json["maxKgLimitPerDay"],
        description: json["description"],
        highlightedDescription: json["highlightedDescription"],
        images: List<String>.from(json["images"].map((x) => x)),
        isHavingStock: json["isHavingStock"],
        stockInKg: json["stockInKg"],
        pricePerKg: json["pricePerKg"],
        isVerified: json["isVerified"],
        buyerId: List<String>.from(json["buyerID"].map((x) => x)),
        isDiscountable: json["isDiscountable"],
        discountInPercentage: json["discountInPercentage"],
        ratings: json["ratings"],
        sellerId: json["sellerId"],
      );

  factory Product.fromdocumentsnap(DocumentSnapshot json) => Product(
        productId: json["productId"],
        categoryName: json["categoryName"],
        productName: json["productName"],
        maxKg: json["maxKg"],
        minKg: json["minKg"].toDouble(),
        maxKgLimitPerDay: json["maxKgLimitPerDay"],
        description: json["description"],
        highlightedDescription: json["highlightedDescription"],
        images: List<String>.from(json["images"].map((x) => x)),
        isHavingStock: json["isHavingStock"],
        stockInKg: json["stockInKg"],
        pricePerKg: json["pricePerKg"],
        isVerified: json["isVerified"],
        buyerId: List<String>.from(json["buyerID"].map((x) => x)),
        isDiscountable: json["isDiscountable"],
        discountInPercentage: json["discountInPercentage"],
        ratings: json["ratings"],
        sellerId: json["sellerId"],
      );

  Map<String, dynamic> toMap() => {
        "productId": productId,
        "categoryName": categoryName,
        "productName": productName,
        "maxKg": maxKg,
        "minKg": minKg,
        "maxKgLimitPerDay": maxKgLimitPerDay,
        "description": description,
        "highlightedDescription": highlightedDescription,
        "images": List<dynamic>.from(images.map((x) => x)),
        "isHavingStock": isHavingStock,
        "stockInKg": stockInKg,
        "pricePerKg": pricePerKg,
        "isVerified": isVerified,
        "buyerID": List<dynamic>.from(buyerId.map((x) => x)),
        "isDiscountable": isDiscountable,
        "discountInPercentage": discountInPercentage,
        "ratings": ratings,
        "sellerId": sellerId,
      };
}

class Timings {
  Timings({
    required this.openingTime,
    required this.closingTime,
    required this.noOfOpenDays,
  });

  String openingTime;
  String closingTime;
  int noOfOpenDays;

  Timings copyWith({
    required String openingTime,
    required String closingTime,
    required int noOfOpenDays,
  }) =>
      Timings(
        openingTime: openingTime,
        closingTime: closingTime,
        noOfOpenDays: noOfOpenDays,
      );

  factory Timings.fromJson(String str) => Timings.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Timings.fromMap(Map<String, dynamic> json) => Timings(
        openingTime: json["openingTime"],
        closingTime: json["closingTime"],
        noOfOpenDays: json["noOfOpenDays"],
      );

  Map<String, dynamic> toMap() => {
        "openingTime": openingTime,
        "closingTime": closingTime,
        "noOfOpenDays": noOfOpenDays,
      };
}

class SellerNotification {
  SellerNotification({
    required this.message,
    required this.buyerId,
    required this.productId,
    required this.timeStamp,
    required this.isSeen,
    required this.productImage,
    required this.orderId,
  });

  String message;
  String buyerId;
  String productId;
  String timeStamp;
  bool isSeen;
  String productImage;
  String orderId;

  SellerNotification copyWith({
    required String message,
    required String buyerId,
    required String productId,
    required String timeStamp,
    required bool isSeen,
    required String productImage,
    required String orderId,
  }) =>
      SellerNotification(
        message: message,
        buyerId: buyerId,
        productId: productId,
        timeStamp: timeStamp,
        isSeen: isSeen,
        productImage: productImage,
        orderId: orderId,
      );

  factory SellerNotification.fromJson(String str) =>
      SellerNotification.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SellerNotification.fromMap(Map<String, dynamic> json) =>
      SellerNotification(
        message: json["message"],
        buyerId: json["buyerId"],
        productId: json["productId"],
        timeStamp: json["timeStamp"],
        isSeen: json["isSeen"],
        productImage: json["productImage"],
        orderId: json["orderId"],
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "buyerId": buyerId,
        "productId": productId,
        "timeStamp": timeStamp,
        "isSeen": isSeen,
        "productImage": productImage,
        "orderId": orderId,
      };
}





















// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';
// import 'dart:html';

// import 'package:collection/collection.dart';

// class MeatSellerModel {
//   String meatSellerName;
//   int contactNumber;
//   String meatShopName;
//   MyLocation location;

//   MeatSellerModel(
//       {required this.meatSellerName,
//       required this.contactNumber,
//       required this.meatShopName,
//       required this.location});

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'meatSellerName': meatSellerName,
//       'contactNumber': contactNumber,
//       'meatShopName': meatShopName,
//       'location': location
//     };
//   }

//   factory MeatSellerModel.fromMap(Map<String, dynamic> map) {
//     return MeatSellerModel(
//         meatSellerName: map['meatSellerName'] as String,
//         contactNumber: map['contactNumber'] as int,
//         meatShopName: map['meatShopName'] as String,
//         location: map['location'] as MyLocation);
//   }

//   String toJson() => json.encode(toMap());

//   factory MeatSellerModel.fromJson(String source) =>
//       MeatSellerModel.fromMap(json.decode(source) as Map<String, dynamic>);

//   MeatSellerModel copyWith({
//     String? meatSellerName,
//     int? contactNumber,
//     String? meatShopName,
//   }) {
//     return MeatSellerModel(
//         meatSellerName: meatSellerName ?? this.meatSellerName,
//         contactNumber: contactNumber ?? this.contactNumber,
//         meatShopName: meatShopName ?? this.meatShopName,
//         location: location ?? this.location);
//   }

//   @override
//   String toString() =>
//       'MeatSellerModel(meatSellerName: $meatSellerName, contactNumber: $contactNumber, meatShopName: $meatShopName)';

//   @override
//   bool operator ==(covariant MeatSellerModel other) {
//     if (identical(this, other)) return true;

//     return other.meatSellerName == meatSellerName &&
//         other.contactNumber == contactNumber &&
//         other.meatShopName == meatShopName;
//   }

//   @override
//   int get hashCode =>
//       meatSellerName.hashCode ^ contactNumber.hashCode ^ meatShopName.hashCode;
// }

// class MyLocation {
//   Map<String, dynamic> coordinates;
//   String address;
//   int pincode;
//   MyLocation({
//     required this.coordinates,
//     required this.address,
//     required this.pincode,
//   });
// }


// orders:[{
//   "productId":"",
//   "orderedDate":"",
//   "deliveryDate":"",
//   "orderStatus":"",
//   "buyerId":"",
//   "quantityInKg":2,
//   "deliveryLocation":{
//     "coordinates":[""],
//        "address":"",
//        "pincode":""
//        },
//   "isDiscount":true,
//   "discountPercentage":5,
  

// }],
// "ratings":4