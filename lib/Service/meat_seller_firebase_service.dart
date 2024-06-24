// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

class MeatSellerService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future addMeatSellerDetails(BuildContext context,
      {required Map<String, dynamic> data}) async {
    CollectionReference _collection = _firestore.collection('MeatSeller');
    User? _firebaseUser =
        Provider.of<User?>(context, listen: false); //context.watch<User?>();

    print(
        "the fireuser is ${_firebaseUser!.uid}"); //Provider.of<User?>(context, listen: false);
    //context.watch<User?>();
    //final _auth = Provider.of<FirebaseAuthMethods>(context).user;

    await _collection.doc(_firebaseUser.uid).set(data);
  }

  // Stream<MeatSellerModel> getMeatSellerDetails(BuildContext context) {
  //   //  User? _firebaseUser = Provider.of<User?>(context, listen: false);

  //   //  print("firebase id is ${_firebaseUser!.uid}");
  //   CollectionReference collection = _firestore.collection("MeatSeller");

  //   return collection
  //       .doc("qKpe3Pt735fz0dzr4Jcw3Y7D0Pr2")
  //       .snapshots()
  //       .map((snapshot) => MeatSellerModel.fromMap(snapshot));
  // }

  Stream getOrderStatus(BuildContext context) async* {
    User? _firebaseUser = Provider.of<User?>(context, listen: false);

    CollectionReference collection = _firestore.collection("MeatSeller");
    yield collection.doc(_firebaseUser!.uid).snapshots();
  }

  Future gettest(BuildContext context) async {
    User? _firebaseUser = Provider.of<User?>(context, listen: false);
    CollectionReference collection = _firestore.collection("MeatSeller");
    return collection.where("mymap",
        arrayContains: {"productId"}, isEqualTo: 3);
  }
}
