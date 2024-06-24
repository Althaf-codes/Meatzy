// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meatzy_app/Constants/Utils.dart';
import 'package:meatzy_app/Model/meat_seller_model.dart';
import 'package:meatzy_app/Model/user_model.dart';
import 'package:provider/provider.dart';

import '../Model/livestock_model.dart';
import '../Provider/user_provider.dart';

class UserFirebaseService {
  User user;

  UserFirebaseService({
    required this.user,
  });
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future addUserDetails(BuildContext context,
      {required Map<String, dynamic> data}) async {
    CollectionReference _collection = _firestore.collection('Users');

    await _collection.doc(user.uid).set(data, SetOptions(merge: true));
  }

  Future addtocart(BuildContext context,
      {required Map<String, dynamic> cartdata,
      required String productId,
      required String cartType}) async {
    DocumentReference _userCartdocument = _firestore
        .collection('Users')
        .doc(user.uid)
        .collection("cart")
        .doc(productId.trim());
    var batch = _firestore.batch();

    batch.set(_userCartdocument, cartdata, SetOptions(merge: true));
    batch.set(_userCartdocument, {"cartType": cartType.toString()},
        SetOptions(merge: true));
    await batch.commit();
  }

  Future<void> buynowmeat(BuildContext context,
      {required String sellerId,
      required String productId,
      required SellerOrder sellerOrder,
      required UserMeatOrder userOrder,
      required SellerNotification notification,
      required String orderId}) async {
    CollectionReference _mcollection = _firestore.collection('MeatSeller');

    CollectionReference _mOrderCollection = _firestore
        .collection('MeatSeller')
        .doc(sellerId.trim())
        .collection("orders");

    CollectionReference _ucollection = _firestore.collection('Users');
    CollectionReference _uOrderCollection =
        _firestore.collection('Users').doc(user.uid).collection('orders');

    var batch = _firestore.batch();

    print("its coming buynow1");
    print("the sellerid is ${sellerId}");
    print("the user id is ${user.uid}");

    batch.set(_mOrderCollection.doc(orderId.trim()), sellerOrder.toMap());
    batch.set(_uOrderCollection.doc(orderId.trim()), userOrder.toMap());

    batch.update(_mcollection.doc(sellerId.trim()), {
      "notifications": FieldValue.arrayUnion([notification.toMap()])
    });
    // batch.update(_ucollection.doc(user.uid), {
    //   "orders": FieldValue.arrayUnion([userOrder.toMap()])
    // });
    batch.set(
        _uOrderCollection.doc(orderId.trim()), {"orderedProductType": "meat"});
    await batch.commit().then((value) {
      showSnackBar(context, "You wll receive order confirmation within 5 mins");
    });
  }

  Future<void> buynowlivestock(
    BuildContext context, {
    required String liveStockSellerId,
    required String productId,
    required LiveStockSellerOrder liveStockSellerOrder,
    required UserLiveStockOrder userLiveStockOrder,
    required LiveStockSellerNotification notification,
    required String orderId,
  }) async {
    CollectionReference _lacollection =
        _firestore.collection('LocalAreaAdmins');

    CollectionReference _laOrderCollection = _firestore
        .collection('LocalAreaAdmins')
        .doc(liveStockSellerId.trim())
        .collection("orders");

    CollectionReference _laliveStockDetailCollection = _firestore
        .collection('LocalAreaAdmins')
        .doc(liveStockSellerId.trim())
        .collection("LiveStockDetails");

    CollectionReference _ucollection = _firestore.collection('Users');
    CollectionReference _uOrderCollection =
        _firestore.collection('Users').doc(user.uid).collection('orders');

    var batch = _firestore.batch();

    print("its coming buynow1");
    // print("the sellerid is ${sellerId}");
    print("the user id is ${user.uid}");

    batch.set(
        _laOrderCollection.doc(orderId.trim()), liveStockSellerOrder.toMap());
    batch.set(
        _uOrderCollection.doc(orderId.trim()), userLiveStockOrder.toMap());
    batch.set(_uOrderCollection.doc(orderId.trim()),
        {"orderedProductType": "livestock"});

    batch.update(_lacollection.doc(liveStockSellerId.trim()), {
      "totalOrders": FieldValue.increment(1),
      "notifications": FieldValue.arrayUnion([notification.toMap()]),
      "soldLiveStockCount": FieldValue.increment(1)
    });
    // batch.set(
    //     _lacollection.doc(user.uid),
    //     {
    //       "totalCounts": {
    //         liveStockType: FieldValue.increment(1),
    //       }
    //     },
    //     SetOptions(merge: true));
    batch.update(_laliveStockDetailCollection.doc(productId), {
      "isSold": true,
      "soldPrice": liveStockSellerOrder.totalPrice,
    });

    // batch.update(_ucollection.doc(user.uid), {
    //   "orders": FieldValue.arrayUnion([userOrder.toMap()])
    // });
    await batch.commit().then((value) {
      showSnackBar(context, "You wll receive order confirmation within 5 mins");
    });
  }

  Stream<UserModel> getuserdata(BuildContext context) {
    CollectionReference _collection = _firestore.collection('Users');
    return _collection
        .doc(user.uid)
        .snapshots()
        .map((DocumentSnapshot snapshot) {
      UserModel user = UserModel.fromMap(snapshot);
      print("printed snapshot is ${snapshot.data()}");
      print("the user printed is ${user.userName}");
      Provider.of<UserProvider>(context, listen: false).setUserFromModel(user);

      return user;
    });
  }

  Future testgetAllUserOrder() async {
    print("the uid is ${user.uid}");
    CollectionReference _userOrderCollection =
        _firestore.collection('Users').doc(user.uid).collection("orders");

    // List<Order> meatorder = await _userOrderCollection
    //     .snapshots()
    //     .map((val) => val.docs
    //         .where((element) => element['orderedProductType'] == "meat"))
    //     .map((event) {
    //   print("the event is ${event.length}");
    //   // =>
    //   event.map((e) => Order.fromdocumentsnap(e));
    //   return Order.fromdocumentsnap(event.first);
    // }).toList();
    List<UserMeatOrder> meatorder = await _userOrderCollection
        .snapshots()
        .map((val) => val.docs
            .where((element) => element['orderedProductType'] == "meat"))
        .map((event) =>
            event.map((e) => UserMeatOrder.fromdocumentsnap(e)).toList())
        .first;

    print("the meatorder is ${meatorder.length}");
  }

  Stream<List<QueryDocumentSnapshot>> getAllUserOrder() {
    CollectionReference _userOrderCollection =
        _firestore.collection('Users').doc(user.uid).collection("orders");

    return _userOrderCollection
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.toList());
  }

  Stream<List<QueryDocumentSnapshot>> getallUserCarts() {
    CollectionReference _userCartCollection =
        _firestore.collection('Users').doc(user.uid).collection("cart");

    return _userCartCollection
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.toList());
  }

  // old array of object type

  // Future getallproducts(BuildContext context) async {
  //   CollectionReference collection = _firestore.collection("MeatSeller");
  //   List<Product> allproduct = [];
  //   QuerySnapshot snapshot = await collection.get();

  //   final allData = snapshot.docs.map((doc) => doc.data()).toList();
  //   print("the future data is ${allData}");
  //   return allData;
  // }

  Stream<List<Product>> getallProduct() {
    var collection = _firestore.collectionGroup("products");

    return collection.snapshots().map((querySnapshot) => querySnapshot.docs
        .map((documentSnapshot) => Product.fromdocumentsnap(documentSnapshot))
        .toList());
  }

  Future<Product> getProductById(
      {required String sellerId, required String productId}) async {
    CollectionReference _productCollection = _firestore
        .collection("MeatSeller")
        .doc(sellerId.trim())
        .collection("products");

    return _productCollection
        .doc(productId.trim())
        .snapshots()
        .map((documentSnapshot) {
      return Product.fromdocumentsnap(documentSnapshot);
    }).first;
  }

  // Future<List<DocumentSnapshot>> getAllMeatSeller() async {
  //   CollectionReference collection = _firestore.collection("MeatSeller");
  //   List<DocumentSnapshot> allMeatSellers;
  //   QuerySnapshot snapshot = await collection.get();

  //   allMeatSellers = snapshot.docs.map((doc) => doc).toList();
  //   print("the allPro data is ${allMeatSellers}");
  //   return allMeatSellers;
  // }
  Stream<List<DocumentSnapshot>> getAllMeatSeller() async* {
    CollectionReference collection = _firestore.collection("MeatSeller");
    QuerySnapshot snapshot = await collection.get();

    yield snapshot.docs.map((documentSnapshot) => documentSnapshot).toList();
  }

  Stream<List<Product>> getAllProductFromSingleMeatSeller(String docId) {
    CollectionReference _productCollection = _firestore
        .collection("MeatSeller")
        .doc(docId.trim())
        .collection('products');

    return _productCollection.snapshots().map((querySnapshot) => querySnapshot
        .docs
        .map((documentSnapshot) => Product.fromdocumentsnap(documentSnapshot))
        .toList());
  }

  Future<void> addNewFeildTest(BuildContext context) async {
    CollectionReference _collection = _firestore.collection('Users');
    _collection
        .doc('PxivDbNG9WO4OZMIin3drm5M4te2')
        .set({'notifications': []}, SetOptions(merge: true));
  }

  Stream<List<LiveStockDetails>> getallLiveStockDetails() {
    CollectionReference localAreaAdminLiveStockCollection = _firestore
        .collection("LocalAreaAdmins")
        .doc("N23h2DhuCsSU8mGBvaJQapt8ovF2")
        .collection("LiveStockDetails");

    return localAreaAdminLiveStockCollection
        .orderBy("postedAt", descending: true)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((documentSnapshot) =>
                LiveStockDetails.fromMap(documentSnapshot))
            .toList());
  }

  Future addTokenToFirebase(String token) async {
    CollectionReference _usercollection = _firestore.collection('Users');

    await _usercollection
        .doc(user.uid)
        .set({"token": token.trim()}, SetOptions(merge: true));
  }
  // Future addTestSubcollection(String orderId, Map<String, dynamic> data) async {
  //   CollectionReference orderCollection =
  //       _firestore.collection("Users").doc(user.uid).collection("orders");

  //   await orderCollection
  //       .doc(orderId)
  //       .set(data, SetOptions(merge: true))
  //       .then((value) => print("updated successfully"));
  // }
}
