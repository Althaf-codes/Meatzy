import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:location/location.dart';
import 'package:meatzy_app/Model/user_model.dart';
import 'package:meatzy_app/Screen/MainHomePage.dart';
import 'package:meatzy_app/Service/user_firebase_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constants/Global_Variables.dart';
import '../../Widget/textformfeild_widget.dart';

//12.0852827 , 79.8901109
class UserDetailsScreen extends StatefulWidget {
  UserDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UserDetailsScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<UserDetailsScreen> {
  final TextEditingController phoneNumbercontroller = TextEditingController();
  final TextEditingController userNamecontroller = TextEditingController();
  final TextEditingController addresscontroller = TextEditingController();
  final TextEditingController pincodecontroller = TextEditingController();

  bool isObscure = true;
  final formGlobalKey = GlobalKey<FormState>();
  bool islogged = false;
  late int phoneNumber;

  //Time Picker
  TimeOfDay openingingTime = TimeOfDay.now();

  TimeOfDay closingTime = TimeOfDay.now();

  void timepic(BuildContext context, TimeOfDay time) async {
    TimeOfDay? newtime =
        await showTimePicker(context: context, initialTime: time);

    if (newtime == null) return;
    setState(() {
      time = newtime;
    });
  }

  //Date picker

  // DateTime date = DateTime.now();
  // void datepic(BuildContext context) async {
  //   DateTime? newdate = await showDatePicker(
  //       context: context,
  //       initialDate: date,
  //       firstDate: DateTime(2022),
  //       lastDate: DateTime(2100));

  //   if (newdate == null) return;
  //   setState(() {
  //     date = newdate;
  //   });
  // }

  void getSellerData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      islogged = prefs.getBool("isloggedInWithPhoneNumber")!;
      phoneNumber = prefs.getInt("PhoneNumber")!;

      print("the islogged in 1 is $islogged");
    });
    if (islogged == null) {
      setState(() {
        islogged = false;
        print('he islogged in 2 $islogged');
      });
    }
  }

  @override
  void dispose() {
    super.dispose();

    phoneNumbercontroller.dispose();
    addresscontroller.dispose();
    pincodecontroller.dispose();
  }

  Location location = Location();

  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.zero,
      child: Scaffold(
        backgroundColor:
            Colors.white, // const Color.fromARGB(255, 232, 240, 236),
        //backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formGlobalKey,
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tell us your details",
                              style: TextStyle(
                                  // shadows: [
                                  //   Shadow(
                                  //       color:
                                  //           Color.fromARGB(255, 29, 201, 192),
                                  //       offset: Offset.zero,
                                  //       blurRadius: 4),
                                  // ],
                                  color: Color.fromARGB(255, 29, 201, 192),
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15.0),
                    child: Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: Offset(1, 10),
                            color: Colors.grey.withOpacity(0.2)),
                        BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: Offset(10, 1),
                            color: Colors.grey.withOpacity(0.2))
                      ]),
                      child: TextFormField(
                        cursorColor: const Color.fromARGB(255, 29, 201, 192),
                        decoration: InputDecoration(
                            labelStyle: const TextStyle(
                                color: Color.fromARGB(255, 29, 201, 192)),
                            hintText: 'Enter your name',
                            labelText: 'Username',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: GlobalVariables.secondaryColor,
                                  style: BorderStyle.solid,
                                  width: 2),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.red,
                                  style: BorderStyle.solid,
                                  width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              gapPadding: 10,
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: GlobalVariables.selectedNavBarColor,
                                  style: BorderStyle.solid,
                                  width: 2),
                            ),
                            focusColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  style: BorderStyle.solid,
                                  width: 5),
                            ),
                            prefixIcon: IconButton(
                              icon: const Icon(
                                Icons.person,
                                color: const Color.fromARGB(255, 29, 201, 192),
                              ),
                              onPressed: () {},
                            ),
                            fillColor: Colors.white,
                            filled: true),
                        controller: userNamecontroller,
                        validator: (name) {
                          if (name != null && name.length < 5)
                            return "The username should have atleast 5 characters ";
                          else if (name!.length >= 5) {
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                  islogged
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 15.0),
                          child: Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: 7,
                                  offset: Offset(1, 10),
                                  color: Colors.grey.withOpacity(0.2)),
                              BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: 7,
                                  offset: Offset(10, 1),
                                  color: Colors.grey.withOpacity(0.2))
                            ]),
                            child: TextFormField(
                                cursorColor:
                                    const Color.fromARGB(255, 29, 201, 192),
                                decoration: InputDecoration(
                                    labelStyle: const TextStyle(
                                        color: const Color.fromARGB(
                                            255, 29, 201, 192)),
                                    hintText: 'Enter your phoneNumber',
                                    labelText: 'Contact.No',
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: GlobalVariables.secondaryColor,
                                          style: BorderStyle.solid,
                                          width: 2),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                          color: Colors.red,
                                          style: BorderStyle.solid,
                                          width: 2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      gapPadding: 10,
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: GlobalVariables
                                              .selectedNavBarColor,
                                          style: BorderStyle.solid,
                                          width: 2),
                                    ),
                                    focusColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                          color: Colors.transparent,
                                          style: BorderStyle.solid,
                                          width: 5),
                                    ),
                                    prefixIcon: IconButton(
                                      icon: const Icon(
                                        Icons.phone,
                                        color: const Color.fromARGB(
                                            255, 29, 201, 192),
                                      ),
                                      onPressed: () {},
                                    ),
                                    fillColor: Colors.white,
                                    filled: true),
                                controller: phoneNumbercontroller,
                                keyboardType: TextInputType.number,
                                validator: (phoneNumber) {
                                  // final re = RegExp(
                                  //     r'/(\+\d{1,3}\s?)?((\(\d{3}\)\s?)|(\d{3})(\s|-?))(\d{3}(\s|-?))(\d{4})(\s?(([E|e]xt[:|.|]?)|x|X)(\s?\d+))?/g');

                                  // Iterable<RegExpMatch> hasMatch =
                                  //     re.allMatches(phoneNumber.toString());
                                  if (phoneNumber != null &&
                                      phoneNumber.length < 10) {
                                    return 'Enter a valid phonenumber ';
                                  } else if (phoneNumber != null &&
                                      phoneNumber.length >= 10) {
                                    return null;
                                  }
                                }),
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15.0),
                    child: Container(
                      decoration: const BoxDecoration(),
                      child: TextFormField(
                        maxLines: 4,
                        cursorColor: const Color.fromARGB(255, 29, 201, 192),
                        decoration: InputDecoration(
                            labelStyle: const TextStyle(
                                color: const Color.fromARGB(255, 29, 201, 192)),
                            hintText: 'Enter your Address',
                            labelText: 'Address',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: GlobalVariables.secondaryColor,
                                  style: BorderStyle.solid,
                                  width: 2),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.red,
                                  style: BorderStyle.solid,
                                  width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              gapPadding: 10,
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: GlobalVariables.selectedNavBarColor,
                                  style: BorderStyle.solid,
                                  width: 2),
                            ),
                            focusColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  style: BorderStyle.solid,
                                  width: 5),
                            ),
                            prefixIcon: IconButton(
                              icon: const Icon(
                                Icons.map,
                                color: Color.fromARGB(255, 29, 201, 192),
                              ),
                              onPressed: () {},
                            ),
                            fillColor: Colors.white,
                            filled: true),
                        controller: addresscontroller,
                        validator: (name) {
                          if (name != null && name.length < 5)
                            return "The Address should be atleast 1 line";
                          else if (name!.length >= 5) {
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                  MyTextFeild(
                      hint: "Enter your Pincode",
                      label: "Pincode",
                      icon: Icons.pin,
                      controller: pincodecontroller,
                      type: TextInputType.number),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          fixedSize: Size(
                              MediaQuery.of(context).size.width * 0.5,
                              MediaQuery.of(context).size.height * 0.05),
                          backgroundColor: GlobalVariables.selectedNavBarColor),
                      onPressed: () async {
                        location.enableBackgroundMode(enable: true);
                        var serviceEnabled = await location.serviceEnabled();
                        if (!serviceEnabled) {
                          serviceEnabled = await location.requestService();
                          if (!serviceEnabled) {
                            return;
                          }
                        }

                        _permissionGranted = await location.hasPermission();
                        if (_permissionGranted == PermissionStatus.denied) {
                          _permissionGranted =
                              await location.requestPermission();
                          if (_permissionGranted != PermissionStatus.granted) {
                            return;
                          }
                        }

                        _locationData = await location.getLocation();
                        print(
                            "The location data is ${_locationData.latitude} , ${_locationData.longitude}}");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.location_on,
                            color: Colors.white,
                          ),
                          Text(
                            "Get Location",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      )),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: Builder(builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: ElevatedButton.icon(
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                            ),
                            style: ElevatedButton.styleFrom(
                                alignment: Alignment.center,
                                shape: StadiumBorder(),
                                backgroundColor:
                                    GlobalVariables.selectedNavBarColor),
                            onPressed: () async {
                              UserFirebaseService userFirebaseService =
                                  UserFirebaseService(
                                      user: Provider.of<User>(context,
                                          listen: false));
                              if (formGlobalKey.currentState!.validate() &&
                                  _locationData.latitude
                                      .toString()
                                      .isNotEmpty &&
                                  _locationData.longitude
                                      .toString()
                                      .isNotEmpty) {
                                formGlobalKey.currentState!.save();

                                print("data retreived successfully ");

                                UserModel userModel = UserModel(
                                    userName: userNamecontroller.text,
                                    phoneNumber: islogged
                                        ? phoneNumber
                                        : int.parse(phoneNumbercontroller.text),
                                    location: MyLocation(
                                        coordinates: [
                                          _locationData.latitude.toString(),
                                          _locationData.longitude.toString()
                                        ],
                                        address: addresscontroller.text,
                                        pincode: pincodecontroller.text),
                                    // cart: [],
                                    // orders: [],
                                    notifications: []);

                                await userFirebaseService
                                    .addUserDetails(context,
                                        data: userModel.toMap())
                                    .then((value) async {
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setBool("isUserRegistered", true);
                                  prefs.setString(
                                      "useraddress", addresscontroller.text);
                                  prefs.setInt("userpincode",
                                      int.parse(pincodecontroller.text));
                                }).then((value) =>
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            MainHomePage.route,
                                            (route) => false));
                              }
                            },
                            label: const Text(
                              "Submit",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            )),
                      );
                    }),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
