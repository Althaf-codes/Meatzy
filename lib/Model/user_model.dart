// To parse this JSON data, do
//
//     final sellerModel = sellerModelFromMap(jsonString);

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class UserModel {
  UserModel({
    required this.userName,
    required this.phoneNumber,
    required this.location,
    // required this.cart,
    // required this.orders,
    required this.notifications,
  });

  String userName;
  int phoneNumber;
  MyLocation location;
  // List<MeatCart> cart;
  // List<Order> orders;
  List<UserNotification> notifications;

  UserModel copyWith({
    required String userName,
    required int phoneNumber,
    required MyLocation location,
    // required List<MeatCart> Meatcart,
    // required List<Order> orders,
    required List<UserNotification> notifications,
  }) =>
      UserModel(
        userName: userName,
        phoneNumber: phoneNumber,
        location: location,
        // cart: Meatcart,
        // orders: orders,
        notifications: notifications,
      );

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(DocumentSnapshot json) => UserModel(
        userName: json["userName"],
        phoneNumber: json["phoneNumber"],
        location: MyLocation.fromMap(json["location"]),
        // cart: List<MeatCart>.from(
        //     json["Meatcart"].map((x) => MeatCart.fromMap(x))),
        // orders: List<Order>.from(json["orders"].map((x) => Order.fromMap(x))),
        notifications: List<UserNotification>.from(
            json["notifications"].map((x) => UserNotification.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "userName": userName,
        "phoneNumber": phoneNumber,
        "location": location.toMap(),
        // "Meatcart": List<dynamic>.from(Meatcart.map((x) => x.toMap())),
        // "orders": List<dynamic>.from(orders.map((x) => x.toMap())),
        "notifications": List<dynamic>.from(notifications.map((x) => x.toMap()))
      };
}

class MeatCart {
  MeatCart({
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

  MeatCart copyWith({
    required String productId,
    required String categoryName,
    required String productName,
    required int maxKg,
    required double minKg,
    required int maxKgLimitPerDay,
    required String description,
    required String highlightedDescription,
    required List<String> images,
    required bool isHavingStock,
    required int stockInKg,
    required int pricePerKg,
    required bool isVerified,
    required List<String> buyerId,
    required bool isDiscountable,
    required int discountInPercentage,
    required int ratings,
    required String sellerId,
  }) =>
      MeatCart(
        productId: productId,
        categoryName: categoryName,
        productName: productName,
        maxKg: maxKg,
        minKg: minKg,
        maxKgLimitPerDay: maxKgLimitPerDay,
        description: description,
        highlightedDescription: highlightedDescription,
        images: images,
        isHavingStock: isHavingStock,
        stockInKg: stockInKg,
        pricePerKg: pricePerKg,
        isVerified: isVerified,
        buyerId: buyerId,
        isDiscountable: isDiscountable,
        discountInPercentage: discountInPercentage,
        ratings: ratings,
        sellerId: sellerId,
      );

  factory MeatCart.fromJson(String str) => MeatCart.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MeatCart.fromMap(Map<String, dynamic> json) => MeatCart(
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
  factory MeatCart.fromdocumentsnap(DocumentSnapshot json) => MeatCart(
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

class MyLocation {
  MyLocation({
    required this.coordinates,
    required this.address,
    required this.pincode,
  });

  List<String> coordinates;
  String address;
  String pincode;

  MyLocation copyWith({
    required List<String> coordinates,
    required String address,
    required String pincode,
  }) =>
      MyLocation(
        coordinates: coordinates,
        address: address,
        pincode: pincode,
      );

  factory MyLocation.fromJson(String str) =>
      MyLocation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MyLocation.fromMap(Map<String, dynamic> json) => MyLocation(
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

class UserMeatOrder {
  UserMeatOrder({
    required this.orderprice,
    required this.ordershopimage,
    required this.productId,
    required this.orderedDate,
    required this.deliveryDate,
    required this.orderStatus,
    required this.sellerId,
    required this.quantityInKg,
    required this.deliveryLocation,
    required this.isDiscount,
    required this.discountPercentage,
    required this.orderId,
  });
  int orderprice;
  String ordershopimage;
  String productId;
  String orderedDate;
  String deliveryDate;
  String orderStatus;
  String sellerId;
  int quantityInKg;
  MyLocation deliveryLocation;
  bool isDiscount;
  int discountPercentage;
  String orderId;

  UserMeatOrder copyWith({
    required int orderprice,
    required String ordershopimage,
    required String productId,
    required String orderedDate,
    required String deliveryDate,
    required String orderStatus,
    required String sellerId,
    required int quantityInKg,
    required MyLocation deliveryLocation,
    required bool isDiscount,
    required int discountPercentage,
    required String orderId,
  }) =>
      UserMeatOrder(
        orderprice: orderprice,
        ordershopimage: ordershopimage,
        productId: productId,
        orderedDate: orderedDate,
        deliveryDate: deliveryDate,
        orderStatus: orderStatus,
        sellerId: sellerId,
        quantityInKg: quantityInKg,
        deliveryLocation: deliveryLocation,
        isDiscount: isDiscount,
        discountPercentage: discountPercentage,
        orderId: orderId,
      );

  factory UserMeatOrder.fromJson(String str) =>
      UserMeatOrder.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserMeatOrder.fromMap(Map<String, dynamic> json) => UserMeatOrder(
        orderprice: json["orderprice"],
        ordershopimage: json["ordershopimage"],
        productId: json["productId"],
        orderedDate: json["orderedDate"],
        deliveryDate: json["deliveryDate"],
        orderStatus: json["orderStatus"],
        sellerId: json["sellerId"],
        quantityInKg: json["quantityInKg"],
        deliveryLocation: MyLocation.fromMap(json["deliveryLocation"]),
        isDiscount: json["isDiscount"],
        discountPercentage: json["discountPercentage"],
        orderId: json["orderId"],
      );

  factory UserMeatOrder.fromdocumentsnap(DocumentSnapshot json) =>
      UserMeatOrder(
        orderprice: json["orderprice"],
        ordershopimage: json["ordershopimage"],
        productId: json["productId"],
        orderedDate: json["orderedDate"],
        deliveryDate: json["deliveryDate"],
        orderStatus: json["orderStatus"],
        sellerId: json["sellerId"],
        quantityInKg: json["quantityInKg"],
        deliveryLocation: MyLocation.fromMap(json["deliveryLocation"]),
        isDiscount: json["isDiscount"],
        discountPercentage: json["discountPercentage"],
        orderId: json["orderId"],
      );

  Map<String, dynamic> toMap() => {
        "orderprice": orderprice,
        "ordershopimage": ordershopimage,
        "productId": productId,
        "orderedDate": orderedDate,
        "deliveryDate": deliveryDate,
        "orderStatus": orderStatus,
        "sellerId": sellerId,
        "quantityInKg": quantityInKg,
        "deliveryLocation": deliveryLocation.toMap(),
        "isDiscount": isDiscount,
        "discountPercentage": discountPercentage,
        "orderId": orderId,
      };
}

class UserLiveStockOrder {
  UserLiveStockOrder({
    required this.productPrice,
    required this.totalPrice,
    required this.orderProductImage,
    required this.productId,
    required this.orderedDate,
    required this.deliveryDate,
    required this.orderStatus,
    required this.livestockSellerId,
    required this.deliveryLocation,
    required this.orderId,
    required this.isbutcherNeeded,
    required this.isOnSpotDelivery,
    required this.cattleIdNo,
  });

  int? productPrice;
  int? totalPrice;
  String? orderProductImage;
  String? productId;
  Timestamp? orderedDate;
  Timestamp? deliveryDate;
  String? orderStatus;
  String? livestockSellerId;
  MyLocation? deliveryLocation;
  String? orderId;
  bool? isbutcherNeeded;
  bool? isOnSpotDelivery;
  int? cattleIdNo;

  UserLiveStockOrder copyWith({
    required int? productPrice,
    required int? totalPrice,
    required String? orderProductImage,
    required String? productId,
    required Timestamp? orderedDate,
    required Timestamp? deliveryDate,
    required String? orderStatus,
    required String? livestockSellerId,
    required MyLocation? deliveryLocation,
    required String? orderId,
    required bool? isbutcherNeeded,
    required bool? isOnSpotDelivery,
    required int? cattleIdNo,
  }) =>
      UserLiveStockOrder(
        productPrice: productPrice ?? this.productPrice,
        totalPrice: totalPrice ?? this.totalPrice,
        orderProductImage: orderProductImage ?? this.orderProductImage,
        productId: productId ?? this.productId,
        orderedDate: orderedDate ?? this.orderedDate,
        deliveryDate: deliveryDate ?? this.deliveryDate,
        orderStatus: orderStatus ?? this.orderStatus,
        livestockSellerId: livestockSellerId ?? this.livestockSellerId,
        deliveryLocation: deliveryLocation ?? this.deliveryLocation,
        orderId: orderId ?? this.orderId,
        isbutcherNeeded: isbutcherNeeded ?? this.isbutcherNeeded,
        isOnSpotDelivery: isOnSpotDelivery ?? this.isOnSpotDelivery,
        cattleIdNo: cattleIdNo ?? this.cattleIdNo,
      );

  factory UserLiveStockOrder.fromJson(String str) =>
      UserLiveStockOrder.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserLiveStockOrder.fromMap(Map<String, dynamic> json) =>
      UserLiveStockOrder(
        productPrice: json["productPrice"],
        totalPrice: json["totalPrice"],
        orderProductImage: json["orderProductImage"],
        productId: json["productId"],
        orderedDate: json["orderedDate"],
        deliveryDate: json["deliveryDate"],
        orderStatus: json["orderStatus"],
        livestockSellerId: json["livestockSellerId"],
        deliveryLocation: MyLocation.fromMap(
          json["deliveryLocation"],
        ),
        orderId: json["orderId"],
        isOnSpotDelivery: json["isOnSpotDelivery"],
        isbutcherNeeded: json["isbutcherNeeded"],
        cattleIdNo: json["cattleIdNo"],
      );

  factory UserLiveStockOrder.fromdocumentsnap(DocumentSnapshot json) =>
      UserLiveStockOrder(
        productPrice: json["productPrice"] ?? 0,
        totalPrice: json["totalPrice"] ?? 0,
        orderProductImage: json["orderProductImage"] ?? '',
        productId: json["productId"] ?? '',
        orderedDate: json["orderedDate"] ?? '',
        deliveryDate: json["deliveryDate"] ?? '',
        orderStatus: json["orderStatus"] ?? '',
        livestockSellerId: json["livestockSellerId"] ?? '',
        deliveryLocation: MyLocation.fromMap(json["deliveryLocation"]),
        orderId: json["orderId"] ?? '',
        isbutcherNeeded: json["isbutcherNeeded"] ?? false,
        isOnSpotDelivery: json["isOnSpotDelivery"] ?? false,
        cattleIdNo: json["cattleIdNo"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "productPrice": productPrice,
        "totalPrice": totalPrice,
        "orderProductImage": orderProductImage,
        "productId": productId,
        "orderedDate": orderedDate,
        "deliveryDate": deliveryDate,
        "orderStatus": orderStatus,
        "livestockSellerId": livestockSellerId,
        "deliveryLocation": deliveryLocation!.toMap(),
        "orderId": orderId,
        "isbutcherNeeded": isbutcherNeeded,
        "isOnSpotDelivery": isOnSpotDelivery,
        "cattleIdNo": cattleIdNo,
      };
}

class UserNotification {
  UserNotification({
    required this.message,
    required this.sellerId,
    required this.productId,
    required this.timeStamp,
    required this.isSeen,
    required this.productImage,
    required this.orderId,
  });

  String message;
  String sellerId;
  String productId;
  String timeStamp;
  bool isSeen;
  String productImage;
  String orderId;

  UserNotification copyWith({
    required String message,
    required String sellerId,
    required String productId,
    required String timeStamp,
    required bool isSeen,
    required String productImage,
    required String orderId,
  }) =>
      UserNotification(
        message: message,
        sellerId: sellerId,
        productId: productId,
        timeStamp: timeStamp,
        isSeen: isSeen,
        productImage: productImage,
        orderId: orderId,
      );

  factory UserNotification.fromJson(String str) =>
      UserNotification.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserNotification.fromMap(Map<String, dynamic> json) =>
      UserNotification(
        message: json["message"],
        sellerId: json["sellerId"],
        productId: json["productId"],
        timeStamp: json["timeStamp"],
        isSeen: json["isSeen"],
        productImage: json["productImage"],
        orderId: json["orderId"],
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "sellerId": sellerId,
        "productId": productId,
        "timeStamp": timeStamp,
        "isSeen": isSeen,
        "productImage": productImage,
        "orderId": orderId,
      };
}




/*// To parse this JSON data, do
//
//     final sellerModel = sellerModelFromMap(jsonString);

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class UserModel {
  UserModel({
    required this.userName,
    required this.phoneNumber,
    required this.location,
    required this.cart,
    required this.orders,
    required this.notifications,
  });

  String userName;
  int phoneNumber;
  MyLocation location;
  List<MeatCart> cart;
  List<Order> orders;
  List<UserNotification> notifications;

  UserModel copyWith({
    required String userName,
    required int phoneNumber,
    required MyLocation location,
    required List<MeatCart> Meatcart,
    required List<Order> orders,
    required List<UserNotification> notifications,
  }) =>
      UserModel(
        userName: userName,
        phoneNumber: phoneNumber,
        location: location,
        cart: Meatcart,
        orders: orders,
        notifications: notifications,
      );

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(DocumentSnapshot json) => UserModel(
        userName: json["userName"],
        phoneNumber: json["phoneNumber"],
        location: MyLocation.fromMap(json["location"]),
        cart: List<MeatCart>.from(
            json["Meatcart"].map((x) => MeatCart.fromMap(x))),
        orders: List<Order>.from(json["orders"].map((x) => Order.fromMap(x))),
        notifications: List<UserNotification>.from(
            json["notifications"].map((x) => UserNotification.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "userName": userName,
        "phoneNumber": phoneNumber,
        "location": location.toMap(),
        "Meatcart": List<dynamic>.from(Meatcart.map((x) => x.toMap())),
        "orders": List<dynamic>.from(orders.map((x) => x.toMap())),
        "notifications": List<dynamic>.from(notifications.map((x) => x.toMap()))
      };
}

class MeatCart {
  MeatCart({
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

  MeatCart copyWith({
    required String productId,
    required String categoryName,
    required String productName,
    required int maxKg,
    required double minKg,
    required int maxKgLimitPerDay,
    required String description,
    required String highlightedDescription,
    required List<String> images,
    required bool isHavingStock,
    required int stockInKg,
    required int pricePerKg,
    required bool isVerified,
    required List<String> buyerId,
    required bool isDiscountable,
    required int discountInPercentage,
    required int ratings,
    required String sellerId,
  }) =>
      MeatCart(
        productId: productId,
        categoryName: categoryName,
        productName: productName,
        maxKg: maxKg,
        minKg: minKg,
        maxKgLimitPerDay: maxKgLimitPerDay,
        description: description,
        highlightedDescription: highlightedDescription,
        images: images,
        isHavingStock: isHavingStock,
        stockInKg: stockInKg,
        pricePerKg: pricePerKg,
        isVerified: isVerified,
        buyerId: buyerId,
        isDiscountable: isDiscountable,
        discountInPercentage: discountInPercentage,
        ratings: ratings,
        sellerId: sellerId,
      );

  factory MeatCart.fromJson(String str) => MeatCart.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MeatCart.fromMap(Map<String, dynamic> json) => MeatCart(
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
  factory MeatCart.fromdocumentsnap(DocumentSnapshot json) => MeatCart(
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

class MyLocation {
  MyLocation({
    required this.coordinates,
    required this.address,
    required this.pincode,
  });

  List<String> coordinates;
  String address;
  String pincode;

  MyLocation copyWith({
    required List<String> coordinates,
    required String address,
    required String pincode,
  }) =>
      MyLocation(
        coordinates: coordinates,
        address: address,
        pincode: pincode,
      );

  factory MyLocation.fromJson(String str) =>
      MyLocation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MyLocation.fromMap(Map<String, dynamic> json) => MyLocation(
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

class Order {
  Order({
    required this.orderprice,
    required this.ordershopimage,
    required this.productId,
    required this.orderedDate,
    required this.deliveryDate,
    required this.orderStatus,
    required this.sellerId,
    required this.quantityInKg,
    required this.deliveryLocation,
    required this.isDiscount,
    required this.discountPercentage,
    required this.orderId,
  });
  int orderprice;
  String ordershopimage;
  String productId;
  String orderedDate;
  String deliveryDate;
  String orderStatus;
  String sellerId;
  int quantityInKg;
  MyLocation deliveryLocation;
  bool isDiscount;
  int discountPercentage;
  String orderId;

  Order copyWith({
    required int orderprice,
    required String ordershopimage,
    required String productId,
    required String orderedDate,
    required String deliveryDate,
    required String orderStatus,
    required String sellerId,
    required int quantityInKg,
    required MyLocation deliveryLocation,
    required bool isDiscount,
    required int discountPercentage,
    required String orderId,
  }) =>
      Order(
        orderprice: orderprice,
        ordershopimage: ordershopimage,
        productId: productId,
        orderedDate: orderedDate,
        deliveryDate: deliveryDate,
        orderStatus: orderStatus,
        sellerId: sellerId,
        quantityInKg: quantityInKg,
        deliveryLocation: deliveryLocation,
        isDiscount: isDiscount,
        discountPercentage: discountPercentage,
        orderId: orderId,
      );

  factory Order.fromJson(String str) => Order.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Order.fromMap(Map<String, dynamic> json) => Order(
        orderprice: json["orderprice"],
        ordershopimage: json["ordershopimage"],
        productId: json["productId"],
        orderedDate: json["orderedDate"],
        deliveryDate: json["deliveryDate"],
        orderStatus: json["orderStatus"],
        sellerId: json["sellerId"],
        quantityInKg: json["quantityInKg"],
        deliveryLocation: MyLocation.fromMap(json["deliveryLocation"]),
        isDiscount: json["isDiscount"],
        discountPercentage: json["discountPercentage"],
        orderId: json["orderId"],
      );

  factory Order.fromdocumentsnap(DocumentSnapshot json) => Order(
        orderprice: json["orderprice"],
        ordershopimage: json["ordershopimage"],
        productId: json["productId"],
        orderedDate: json["orderedDate"],
        deliveryDate: json["deliveryDate"],
        orderStatus: json["orderStatus"],
        sellerId: json["sellerId"],
        quantityInKg: json["quantityInKg"],
        deliveryLocation: MyLocation.fromMap(json["deliveryLocation"]),
        isDiscount: json["isDiscount"],
        discountPercentage: json["discountPercentage"],
        orderId: json["orderId"],
      );

  Map<String, dynamic> toMap() => {
        "orderprice": orderprice,
        "ordershopimage": ordershopimage,
        "productId": productId,
        "orderedDate": orderedDate,
        "deliveryDate": deliveryDate,
        "orderStatus": orderStatus,
        "sellerId": sellerId,
        "quantityInKg": quantityInKg,
        "deliveryLocation": deliveryLocation.toMap(),
        "isDiscount": isDiscount,
        "discountPercentage": discountPercentage,
        "orderId": orderId,
      };
}

class UserNotification {
  UserNotification({
    required this.message,
    required this.sellerId,
    required this.productId,
    required this.timeStamp,
    required this.isSeen,
    required this.productImage,
    required this.orderId,
  });

  String message;
  String sellerId;
  String productId;
  String timeStamp;
  bool isSeen;
  String productImage;
  String orderId;

  UserNotification copyWith({
    required String message,
    required String sellerId,
    required String productId,
    required String timeStamp,
    required bool isSeen,
    required String productImage,
    required String orderId,
  }) =>
      UserNotification(
        message: message,
        sellerId: sellerId,
        productId: productId,
        timeStamp: timeStamp,
        isSeen: isSeen,
        productImage: productImage,
        orderId: orderId,
      );

  factory UserNotification.fromJson(String str) =>
      UserNotification.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserNotification.fromMap(Map<String, dynamic> json) =>
      UserNotification(
        message: json["message"],
        sellerId: json["sellerId"],
        productId: json["productId"],
        timeStamp: json["timeStamp"],
        isSeen: json["isSeen"],
        productImage: json["productImage"],
        orderId: json["orderId"],
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "sellerId": sellerId,
        "productId": productId,
        "timeStamp": timeStamp,
        "isSeen": isSeen,
        "productImage": productImage,
        "orderId": orderId,
      };
}
*/