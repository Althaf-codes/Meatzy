import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/Global_Variables.dart';
import '../Constants/errror_handling.dart';
import '../Model/user_model.dart';
import '../Provider/user_provider.dart';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String phoneNumber,
    required String password,
    required String userName,
    required String email,
  }) async {
    // try {
    //   User user = User(
    //     id: '',
    //     email: email,
    //     userName: userName,
    //     phoneNumber: phoneNumber,
    //     password: password,
    //     address: '',
    //     cart: [],
    //     wishlist: [],
    //     orders: [],
    //     profileImage: '',
    //     isSeller: false,
    //     isPremiumSeller: false,
    //     isLocalAreaAdmin: false,
    //     isMainAdmin: false,
    //     isMeatSeller: false,
    //     type: '',
    //     chats: '',
    //     token: '',
    //     sellerID: '',
    //     localAreaAdminID: '',
    //     meatSellerID: '',
    //     mainAdminID: '',
    //   );
    //   http.Response res = await http.post(
    //     Uri.parse('${uri}/api/signup'),
    //     body: user.toJson(),
    //     headers: <String, String>{
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //   );
    //   final userRes = jsonDecode(res.body);
    //   print('the userRes is ${userRes}');

    //   httpErrorHandle(
    //       response: res,
    //       context: context,
    //       onSuccess: () async {
    //         SharedPreferences prefs = await SharedPreferences.getInstance();

    //         await prefs.setString("x-userName", userRes['user']['userName']);
    //         await prefs.setString(
    //             "x-phoneNumber", userRes['user']['phoneNumber']);
    //         // Navigator.pushNamedAndRemoveUntil(
    //         //   context,
    //         //   MainHomePage.route,
    //         //   ((route) => false),
    //         // );
    //         showSnackBar(
    //             context, 'Account created! Login with the same credentials!');
    //       });
    // } catch (e) {
    //   print('the err is ${e.toString()}');
    //   showSnackBar(context, e.toString());
    // }
  }

  void signIn({
    required BuildContext context,
    required String phoneNumber,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('${uri}/api/signIn'),
        body: jsonEncode({'password': password, 'phoneNumber': phoneNumber}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      var user = jsonDecode(res.body);

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();

          await prefs.setString("x-userName", user['user']['userName']);
          await prefs.setString("x-phoneNumber", user['user']['phoneNumber']);
          await prefs.setString("x-auth-token", user['token']);

          // Navigator.pushNamedAndRemoveUntil(
          //     context, MainHomePage.route, (route) => false,
          //     arguments: LogInArguments(
          //         userName: user['user']['userName'],
          //         phnNum: user['user']['phoneNumber']));
        },
      );
    } catch (e) {
      print('the err is ${e.toString()}');
      showSnackBar(context, e.toString());
    }
  }

  void getUserData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      print('its coming in  the getuserdata');
      var tokenRes = await http.post(Uri.parse('${uri}/tokenIsValid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token!
          });

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token,
          },
        );

        print('the userRes is ${jsonDecode(userRes.body)}');

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);

        print('it passes the getuserdata');
        var userDetails = jsonDecode(userRes.body);
        // if (userDetails['isSeller'] == true) {
        //   getSellerData(context);
        // }
      }
    } catch (e) {
      print('Error occured in getuserData');
      print(e.toString());
      //showSnackBar(context, e.toString());
    }
  }

  void signOutSharedPreference(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("x-userName", '');

    prefs.setString('x-phoneNumber', '');

    prefs.setString('x-auth-token', '');
  }

  // void sellerSignUp(
  //     {required BuildContext context,
  //     required String phoneNumber,
  //     required String password,
  //     required String sellerName,
  //     required String companyName,
  //     required String address,
  //     required List<dynamic> specializedCategory}) async {
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String? token = prefs.getString('x-auth-token');

  //     if (token == null) {
  //       prefs.setString('x-auth-token', '');
  //     }

  //     Seller seller = Seller(
  //         id: "",
  //         sellerName: sellerName,
  //         userId: "",
  //         phoneNumber: phoneNumber,
  //         password: password,
  //         isPremiumSeller: false,
  //         companyName: companyName,
  //         location: address,
  //         specializedCategory: specializedCategory,
  //         orders: [],
  //         products: [],
  //         ratings: [],
  //         isNewSeller: true,
  //         isActive: false);

  //     http.Response res = await http.post(
  //       Uri.parse('${uri}/api/sellerSignUp'),
  //       body: seller.toJson(),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'x-auth-token': token!
  //       },
  //     );

  //     final sellerRes = jsonDecode(res.body);
  //     print('the sellerRes is ${sellerRes}');

  //     httpErrorHandle(
  //         response: res,
  //         context: context,
  //         onSuccess: () async {
  //           final prefs = await SharedPreferences.getInstance();
  //           await prefs.setString("x-sellerAuth-token", sellerRes['token']);
  //           await prefs.setString(
  //               "x-sellerName", sellerRes['seller']['sellerName']);
  //           await prefs.setString(
  //               "x-sellerPhoneNumber", sellerRes['seller']['phoneNumber']);
  //           await prefs.setBool("isSeller", true);

  //           var userProvider =
  //               Provider.of<UserProvider>(context, listen: false);
  //           var sellerProvider =
  //               Provider.of<SellerProvider>(context, listen: false);
  //           userProvider.setUser(sellerRes['user']);
  //           sellerProvider.setSeller(sellerRes['seller']);

  //           // Navigator.pushNamedAndRemoveUntil(
  //           //   context,
  //           //   MainHomePage.route,
  //           //   ((route) => false),
  //           // );

  //           showSnackBar(
  //               context, 'Account created! Login with the same credentials!');

  //           Navigator.pop(context);
  //         });
  //   } catch (e) {
  //     showSnackBar(context, e.toString());
  //   }
  // }

  // void sellerSignIn({
  //   required BuildContext context,
  //   required String phoneNumber,
  //   required String password,
  // }) async {
  //   try {
  //     http.Response res = await http.post(
  //       Uri.parse('${uri}/api/sellerSignIn'),
  //       body: jsonEncode({'password': password, 'phoneNumber': phoneNumber}),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //     );

  //     var seller = jsonDecode(res.body);

  //     httpErrorHandle(
  //       response: res,
  //       context: context,
  //       onSuccess: () async {
  //         SharedPreferences prefs = await SharedPreferences.getInstance();

  //         await prefs.setString("x-sellerName", seller['seller']['sellerName']);
  //         await prefs.setString(
  //             "x-sellerPhoneNumber", seller['seller']['phoneNumber']);
  //         await prefs.setString("x-sellerAuth-token", seller['token']);
  //         await prefs.setBool("isSeller", true);

  //         Navigator.popAndPushNamed(context, MainHomePage.route);
  //         // Navigator.pushNamedAndRemoveUntil(
  //         //     context, MainHomePage.route, (route) => false,
  //         //     arguments: LogInArguments(
  //         //         userName: user['user']['userName'],
  //         //         phnNum: user['user']['phoneNumber']));
  //       },
  //     );
  //   } catch (e) {
  //     print('error occurred in sellerSigin');
  //   }
  // }

  // void getSellerData(BuildContext context) async {
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String? sellertoken = prefs.getString('x-sellerAuth-token');
  //     String? token = prefs.getString('x-auth-token');
  //     print('its coming in the getSellerdata');
  //     if (token == null) {
  //       prefs.setString('x-auth-token', '');
  //     }

  //     if (sellertoken == null) {
  //       prefs.setString('x-sellerAuth-token', '');
  //     }
  //     print('the seller token is ${sellertoken}');
  //     var tokenRes = await http
  //         .get(Uri.parse('$uri/api/getSellerById'), headers: <String, String>{
  //       'Content-Type': 'application/json;charset=UTF-8',
  //       'x-sellerAuth-token': sellertoken!,
  //       'x-auth-token': token!
  //     });
  //     print('the tokenRes is ${jsonDecode(tokenRes.body)}');

  //     print('it passes the getSellerdata');
  //     var response = jsonDecode(tokenRes.body);
  //     print('the response is ${response}');
  //     print('the category is ${response['specializedCategory']} ');
  //     var elements =
  //         List<String>.from(response["specializedCategory"].map((x) => x));
  //     print('the elements are ${elements}');

  //     var sellerProvider = Provider.of<SellerProvider>(context, listen: false);
  //     sellerProvider.setSeller(tokenRes.body);

  //     await prefs.setString("x-sellerAuth-token", response['token']);
  //     await prefs.setString("x-sellerName", response['sellerName']);
  //     await prefs.setString("x-sellerPhoneNumber", response['phoneNumber']);
  //     await prefs.setBool("isSeller", true);
  //   } catch (e) {
  //     print('Error occured in getsellerData');
  //     print(e.toString());
  //     // showSnackBar(context, e.toString());
  //   }
  // }

  void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 5),
        content: Text(text),
      ),
    );
  }
}
