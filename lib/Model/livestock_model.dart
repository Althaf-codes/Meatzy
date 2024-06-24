// To parse this JSON data, do
//
//     final liveStockDetails = liveStockDetailsFromMap(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meatzy_app/Model/user_model.dart';

class LiveStockDetails {
  String? productId;
  String? age;
  String? liveStockType;
  String approxLiveStockKg;
  int? boughtPrice;
  String? boughtOwnerPhone;
  String? boughtOwnerName;
  String? boughtOwnerAddress;
  int? soldPrice;
  int? priceQuoted;
  bool? isFullyPaid;
  bool? isAdvanced;
  String? deadlinePayTime;
  String? buyerId;
  String? orderId;
  String? deliveryDateAndTime;
  DeliveryLocation? deliveryLocation;
  bool? isDelivered;
  List<String>? images;
  bool? isSold;
  String? description;
  String? highlightedDescription;
  Timestamp? postedAt;
  bool? isbutcherNeeded;
  bool? isOnSpotDelivery;
  int? cattleIdNo;
  String? liveStockSellerId;

  LiveStockDetails({
    required this.productId,
    required this.age,
    required this.liveStockType,
    required this.approxLiveStockKg,
    required this.boughtPrice,
    required this.boughtOwnerPhone,
    required this.boughtOwnerName,
    required this.boughtOwnerAddress,
    required this.soldPrice,
    required this.priceQuoted,
    required this.isFullyPaid,
    required this.isAdvanced,
    required this.deadlinePayTime,
    required this.buyerId,
    required this.orderId,
    required this.deliveryDateAndTime,
    required this.deliveryLocation,
    required this.isDelivered,
    required this.images,
    required this.isSold,
    required this.description,
    required this.highlightedDescription,
    required this.postedAt,
    required this.isbutcherNeeded,
    required this.isOnSpotDelivery,
    required this.cattleIdNo,
    required this.liveStockSellerId,
  });

  LiveStockDetails copyWith({
    String? productId,
    String? age,
    String? liveStockType,
    String? approxLiveStockKg,
    int? boughtPrice,
    String? boughtOwnerPhone,
    String? boughtOwnerName,
    String? boughtOwnerAddress,
    int? soldPrice,
    int? priceQuoted,
    bool? isFullyPaid,
    bool? isAdvanced,
    String? deadlinePayTime,
    String? buyerId,
    String? orderId,
    String? deliveryDateAndTime,
    DeliveryLocation? deliveryLocation,
    bool? isDelivered,
    List<String>? images,
    bool? isSold,
    String? description,
    String? highlightedDescription,
    Timestamp? postedAt,
    bool? isbutcherNeeded,
    bool? isOnSpotDelivery,
    int? cattleIdNo,
    String? liveStockSellerId,
  }) =>
      LiveStockDetails(
        productId: productId ?? this.productId,
        age: age ?? this.age,
        liveStockType: liveStockType ?? this.liveStockType,
        approxLiveStockKg: approxLiveStockKg ?? this.approxLiveStockKg,
        boughtPrice: boughtPrice ?? this.boughtPrice,
        boughtOwnerPhone: boughtOwnerPhone ?? this.boughtOwnerPhone,
        boughtOwnerName: boughtOwnerName ?? this.boughtOwnerName,
        boughtOwnerAddress: boughtOwnerAddress ?? this.boughtOwnerAddress,
        soldPrice: soldPrice ?? this.soldPrice,
        priceQuoted: priceQuoted ?? this.priceQuoted,
        isFullyPaid: isFullyPaid ?? this.isFullyPaid,
        isAdvanced: isAdvanced ?? this.isAdvanced,
        deadlinePayTime: deadlinePayTime ?? this.deadlinePayTime,
        buyerId: buyerId ?? this.buyerId,
        orderId: orderId ?? this.orderId,
        deliveryDateAndTime: deliveryDateAndTime ?? this.deliveryDateAndTime,
        deliveryLocation: deliveryLocation ?? this.deliveryLocation,
        isDelivered: isDelivered ?? this.isDelivered,
        images: images ?? this.images,
        isSold: isSold ?? this.isSold,
        description: description ?? this.description,
        highlightedDescription:
            highlightedDescription ?? this.highlightedDescription,
        postedAt: postedAt ?? this.postedAt,
        isbutcherNeeded: isbutcherNeeded ?? this.isbutcherNeeded,
        isOnSpotDelivery: isOnSpotDelivery ?? this.isOnSpotDelivery,
        cattleIdNo: cattleIdNo ?? this.cattleIdNo,
        liveStockSellerId: liveStockSellerId ?? this.liveStockSellerId,
      );

  factory LiveStockDetails.fromJson(String str) =>
      LiveStockDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LiveStockDetails.fromMap(DocumentSnapshot json) => LiveStockDetails(
        productId: json["productId"],
        age: json["age"],
        liveStockType: json["liveStockType"],
        approxLiveStockKg: json["approxLiveStockKg"],
        boughtPrice: json["boughtPrice"],
        boughtOwnerPhone: json["boughtOwnerPhone"],
        boughtOwnerName: json["boughtOwnerName"],
        boughtOwnerAddress: json["boughtOwnerAddress"],
        soldPrice: json["soldPrice"],
        priceQuoted: json["priceQuoted"],
        isFullyPaid: json["isFullyPaid"],
        isAdvanced: json["isAdvanced"],
        deadlinePayTime: json["DeadlinePayTime"],
        buyerId: json["buyerId"],
        orderId: json["orderID"],
        deliveryDateAndTime: json["deliveryDateAndTime"],
        deliveryLocation: DeliveryLocation.fromMap(json["deliveryLocation"]),
        isDelivered: json["isDelivered"],
        images: List<String>.from(json["images"].map((x) => x)),
        isSold: json["isSold"],
        description: json["description"],
        highlightedDescription: json["highlightedDescription"],
        postedAt: json["postedAt"],
        isOnSpotDelivery: json["isOnSpotDelivery"],
        isbutcherNeeded: json["isbutcherNeeded"],
        cattleIdNo: json["cattleIdNo"],
        liveStockSellerId: json["liveStockSellerId"],
      );

  Map<String, dynamic> toMap() => {
        "productId": productId,
        "age": age,
        "liveStockType": liveStockType,
        "approxLiveStockKg": approxLiveStockKg,
        "boughtPrice": boughtPrice,
        "boughtOwnerPhone": boughtOwnerPhone,
        "boughtOwnerName": boughtOwnerName,
        "boughtOwnerAddress": boughtOwnerAddress,
        "soldPrice": soldPrice,
        "priceQuoted": priceQuoted,
        "isFullyPaid": isFullyPaid,
        "isAdvanced": isAdvanced,
        "DeadlinePayTime": deadlinePayTime,
        "buyerId": buyerId,
        "orderID": orderId,
        "deliveryDateAndTime": deliveryDateAndTime,
        "deliveryLocation": deliveryLocation?.toMap(),
        "isDelivered": isDelivered,
        "images": List<dynamic>.from(images!.map((x) => x)),
        "postedAt": postedAt,
        "isSold": isSold,
        "description": description,
        "highlightedDescription": highlightedDescription,
        "isbutcherNeeded": isbutcherNeeded,
        "isOnSpotDelivery": isOnSpotDelivery,
        "cattleIdNo": cattleIdNo,
        "liveStockSellerId": liveStockSellerId
      };
}

class DeliveryLocation {
  String address;
  List<dynamic> coordinates;
  String pincode;

  DeliveryLocation({
    required this.address,
    required this.coordinates,
    required this.pincode,
  });

  DeliveryLocation copyWith({
    String? address,
    List<dynamic>? coordinates,
    String? pincode,
  }) =>
      DeliveryLocation(
        address: address ?? this.address,
        coordinates: coordinates ?? this.coordinates,
        pincode: pincode ?? this.pincode,
      );

  factory DeliveryLocation.fromJson(String str) =>
      DeliveryLocation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeliveryLocation.fromMap(Map<String, dynamic> json) =>
      DeliveryLocation(
        address: json["address"],
        coordinates: List<dynamic>.from(json["coordinates"].map((x) => x)),
        pincode: json["pincode"],
      );

  Map<String, dynamic> toMap() => {
        "address": address,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
        "pincode": pincode,
      };
}

class LiveStockSellerOrder {
  LiveStockSellerOrder({
    required this.productPrice,
    required this.totalPrice,
    required this.orderProductImage,
    required this.productId,
    required this.orderedDate,
    required this.deliveryDate,
    required this.orderStatus,
    required this.buyerId,
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
  String? buyerId;
  MyLocation? deliveryLocation;
  String? orderId;
  bool? isbutcherNeeded;
  bool? isOnSpotDelivery;
  int? cattleIdNo;

  LiveStockSellerOrder copyWith({
    required int? productPrice,
    required int? toalPrice,
    required String? orderProductImage,
    required String? productId,
    required Timestamp? orderedDate,
    required Timestamp? deliveryDate,
    required String? orderStatus,
    required String? buyerId,
    required MyLocation? deliveryLocation,
    required String? orderId,
  }) =>
      LiveStockSellerOrder(
        productPrice: productPrice,
        totalPrice: totalPrice,
        orderProductImage: orderProductImage,
        productId: productId,
        orderedDate: orderedDate,
        deliveryDate: deliveryDate,
        orderStatus: orderStatus,
        buyerId: buyerId,
        deliveryLocation: deliveryLocation,
        orderId: orderId,
        isbutcherNeeded: isbutcherNeeded ?? isbutcherNeeded,
        isOnSpotDelivery: isOnSpotDelivery ?? isOnSpotDelivery,
        cattleIdNo: cattleIdNo ?? cattleIdNo,
      );

  factory LiveStockSellerOrder.fromJson(String str) =>
      LiveStockSellerOrder.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LiveStockSellerOrder.fromMap(Map<String, dynamic> json) =>
      LiveStockSellerOrder(
        productPrice: json["productPrice"],
        totalPrice: json["totalPrice"],
        orderProductImage: json["orderProductImage"],
        productId: json["productId"],
        orderedDate: json["orderedDate"],
        deliveryDate: json["deliveryDate"],
        orderStatus: json["orderStatus"],
        buyerId: json["buyerId "],
        deliveryLocation: MyLocation.fromMap(
          json["deliveryLocation"],
        ),
        orderId: json["orderId"],
        isOnSpotDelivery: json["isOnSpotDelivery"],
        isbutcherNeeded: json["isbutcherNeeded"],
        cattleIdNo: json["cattleIdNo"],
      );

  factory LiveStockSellerOrder.fromdocumentsnap(DocumentSnapshot json) =>
      LiveStockSellerOrder(
        productPrice: json["productPrice"],
        totalPrice: json["totalPrice"],
        orderProductImage: json["orderProductImage"],
        productId: json["productId"],
        orderedDate: json["orderedDate"],
        deliveryDate: json["deliveryDate"],
        orderStatus: json["orderStatus"],
        buyerId: json["buyerId "],
        deliveryLocation: MyLocation.fromMap(json["deliveryLocation"]),
        orderId: json["orderId"],
        isOnSpotDelivery: json["isOnSpotDelivery"],
        isbutcherNeeded: json["isbutcherNeeded"],
        cattleIdNo: json["cattleIdNo"],
      );

  Map<String, dynamic> toMap() => {
        "productPrice": productPrice,
        "totalPrice": totalPrice,
        "orderProductImage": orderProductImage,
        "productId": productId,
        "orderedDate": orderedDate,
        "deliveryDate": deliveryDate,
        "orderStatus": orderStatus,
        "buyerId": buyerId,
        "deliveryLocation": deliveryLocation!.toMap(),
        "orderId": orderId,
        "isbutcherNeeded": isbutcherNeeded,
        "isOnSpotDelivery": isOnSpotDelivery,
        "cattleIdNo": cattleIdNo,
      };
}

class LiveStockSellerNotification {
  LiveStockSellerNotification({
    required this.message,
    required this.buyerId,
    required this.productId,
    required this.notifiedAt,
    required this.isSeen,
    required this.productImage,
    required this.orderId,
    required this.productType,
  });

  String message;
  String buyerId;
  String productId;
  Timestamp notifiedAt;
  bool isSeen;
  String productImage;
  String orderId;
  String productType;

  LiveStockSellerNotification copyWith({
    required String message,
    required String buyerId,
    required String productId,
    required Timestamp notifiedAt,
    required bool isSeen,
    required String productImage,
    required String orderId,
    required String productType,
  }) =>
      LiveStockSellerNotification(
          message: message,
          buyerId: buyerId,
          productId: productId,
          notifiedAt: notifiedAt,
          isSeen: isSeen,
          productImage: productImage,
          orderId: orderId,
          productType: productType);

  factory LiveStockSellerNotification.fromJson(String str) =>
      LiveStockSellerNotification.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LiveStockSellerNotification.fromMap(Map<String, dynamic> json) =>
      LiveStockSellerNotification(
        message: json["message"],
        buyerId: json["buyerId"],
        productId: json["productId"],
        notifiedAt: json["notifiedAt"],
        isSeen: json["isSeen"],
        productImage: json["productImage"],
        orderId: json["orderId"],
        productType: json["productType"],
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "buyerId": buyerId,
        "productId": productId,
        "notifiedAt": notifiedAt,
        "isSeen": isSeen,
        "productImage": productImage,
        "orderId": orderId,
        "productType": productType
      };
}
