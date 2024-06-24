import 'package:flutter/material.dart';

import '../Model/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel _user = UserModel(
      userName: "",
      phoneNumber: 0,
      location: MyLocation(
        address: "",
        coordinates: [],
        pincode: '',
      ),
      // cart: [
      //   MeatCart(
      //       productId: "",
      //       categoryName: "",
      //       productName: "",
      //       maxKg: 0,
      //       minKg: 0,
      //       maxKgLimitPerDay: 0,
      //       description: "",
      //       highlightedDescription: "",
      //       images: [""],
      //       isHavingStock: true,
      //       stockInKg: 0,
      //       pricePerKg: 0,
      //       isVerified: true,
      //       buyerId: [],
      //       isDiscountable: false,
      //       discountInPercentage: 0,
      //       ratings: 0,
      //       sellerId: "")
      // ],
      // orders: [
      //   Order(
      //       orderprice: 0,
      //       ordershopimage: "",
      //       productId: "",
      //       deliveryDate: '',
      //       deliveryLocation: MyLocation(
      //         address: "",
      //         coordinates: [],
      //         pincode: '',
      //       ),
      //       discountPercentage: 0,
      //       isDiscount: false,
      //       orderStatus: '',
      //       orderedDate: '',
      //       quantityInKg: 0,
      //       sellerId: '',
      //       orderId: '')
      // ],
      notifications: []);

  UserModel get user => _user;

  void setUser(String user) {
    _user = UserModel.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(UserModel user) {
    _user = user;
    notifyListeners();
  }
}
