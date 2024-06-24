import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:meatzy_app/Constants/Utils.dart';
import 'package:meatzy_app/Screen/testfcm_page.dart';
import 'package:meatzy_app/Service/user_firebase_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Constants/Global_Variables.dart';
import 'Provider/user_provider.dart';
import 'Screen/Details/user_details_screen.dart';
import 'Screen/MainHomePage.dart';
import 'Service/firebase_auth_service.dart';
import 'Service/notification_service.dart';
import 'Widget/toggle.dart';
import 'firebase_options.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

const GlobalKey<NavigatorState> navigatorkey = GlobalObjectKey(NavigatorState);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // NotificationService().initNotification();

  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
  //   print("onMessageOpened: $message ");
  //   NotificationService().showNotification(
  //       id: Random().nextInt(10000),
  //       title: message.notification!.title.toString(),
  //       body: message.notification!.body.toString(),
  //       imgurl: message.notification!.android!.imageUrl.toString());

  //   // Navigator.pushNamed(navigatorkey.currentState!.context, 'fcm-page',
  //   //     arguments: {"message": jsonEncode(message.data)});
  // });

  // FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
  //   if (message != null) {
  //     print("Getintialmessage : ${message.data} ");
  //     NotificationService().showNotification(
  //       id: Random().nextInt(10000),
  //       title: message.notification!.title.toString(),
  //       body: message.notification!.body.toString(),
  //       imgurl: message.notification!.android!.imageUrl.toString(),
  //     );
  //     // Navigator.pushNamed(navigatorkey.currentState!.context, 'fcm-page',
  //     //     arguments: {"message": jsonEncode(message.data)});
  //   }

  // });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("//////////////////////////////////////////////////");
  print("message is ${message.data['title']}");
  print("//////////////////////////////////////////////////");

  NotificationService().showLocalNotification(message
      // id: Random().nextInt(10000),
      // title: message.notification!.title.toString(),
      // body: message.notification!.body.toString(),
      // imgurl: message.notification!.android!.imageUrl.toString()
      );

  print("_firebaseMessagingBackgroundHandler: ${message.data}");
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  NotificationService notificationServices = NotificationService();

  @override
  void initState() {
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthMethods>(
            create: (_) => FirebaseAuthMethods(
                  FirebaseAuth.instance,
                )),
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
        // ChangeNotifierProvider<MeatSellerProvider>(
        //     create: (_) => MeatSellerProvider()),
        StreamProvider(
            create: (context) => context.read<FirebaseAuthMethods>().authState,
            initialData: null),
      ],
      child: MaterialApp(
          navigatorKey: navigatorkey,
          scaffoldMessengerKey: _scaffoldKey,
          title: 'Meatzy',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: false,
            scaffoldBackgroundColor: GlobalVariables.greyBackgroundCOlor,
            appBarTheme: const AppBarTheme(
                elevation: 0, iconTheme: IconThemeData(color: Colors.black)),
          ),
          routes: {
            Toggle.route: (context) => const Toggle(),
            MainHomePage.route: (context) => const MainHomePage(),
            // '/fcm-page': ((context) => const TestFcmPage())
          },

          //  onGenerateRoute: (route) => getRoutes(route),
          home: const AuthWrapper()
          //  HomeScreen(controller: scrollController)
          ), //const AuthWrapper()),
    );
    //const SellScreen());  // const AdminMainHomePage()); // MainHomePage());
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool isUserRegistered = false;
  // void initializeShared() async {}

  @override
  void initState() {
    getSellerData();

    super.initState();
  }

  void gettoken({required User user}) {
    FirebaseMessaging.instance.getToken().then((value) async {
      print("Token: $value");
      UserFirebaseService userFirebaseService = UserFirebaseService(user: user);
      if (value != null) {
        await userFirebaseService.addTokenToFirebase(value.toString());
      }
    });
  }

  void listentokenchange({required User user}) async {
    FirebaseMessaging.instance.onTokenRefresh.listen((event) async {
      UserFirebaseService userFirebaseService = UserFirebaseService(user: user);

      await userFirebaseService.addTokenToFirebase(event);
    }).onError((err) {
      showSnackBar(
          navigatorkey.currentState!.context, 'Error in getting token');
    });
  }

  // FirebaseMessaging.instance.onTokenRefresh.listen((event) async {
  //   UserFirebaseService userFirebaseService = UserFirebaseService(
  //       user: Provider.of<User>(navigatorkey.currentState!.context,
  //           listen: false));

  //   await userFirebaseService.addTokenToFirebase(event);
  // }).onError((err) {
  //   showSnackBar(navigatorkey.currentState!.context, 'Error in getting token');
  // });

  void getSellerData() async {
    final prefs = await SharedPreferences.getInstance();
    // prefs.setString("useraddress", "2/241 ECR Main Road kalapet, Puducherry ");
    // prefs.setInt("userpincode", 604306);
    setState(() {
      //prefs.setBool("isUserRegistered", true);
      isUserRegistered = prefs.getBool("isUserRegistered") ?? false;
      // print("the isUserRegistered in 1 is $isUserRegistered");
    });
    // if (isUserRegistered == null) {
    //   setState(() {
    //     isUserRegistered = false;
    //     print('he islogged in 2 $isUserRegistered');
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      // print("isloggedin value in main.dart is $isUserRegistered");
      gettoken(user: firebaseUser);
      listentokenchange(user: firebaseUser);

      if (isUserRegistered == false) {
        // if (kIsWeb) {
        //   return MainHomePage();
        // } else {
        return UserDetailsScreen();

        // }
      }

      print('THE USER IS ${firebaseUser.uid}');
      return const MainHomePage();
    } else {
      return const Toggle();
    }
    // return Toggle();
  }
}
