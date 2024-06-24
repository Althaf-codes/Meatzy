import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meatzy_app/Constants/Utils.dart';
import 'package:meatzy_app/Service/firebase_auth_service.dart';
import 'package:meatzy_app/Service/user_firebase_service.dart';
import 'package:provider/provider.dart';

Widget sliverAppBar(BuildContext context,
    {String title = 'Meatzy',
    IconData icon2 = Icons.mic,
    bool isSecondIcon = false,
    required Widget icon1,
    required Widget flexibleChild}) {
  return SliverAppBar(
    expandedHeight: 110,
    // automaticallyImplyLeading: false,
    pinned: true,
    floating: true,
    titleSpacing: 1,
    backgroundColor: const Color.fromARGB(255, 29, 201, 192),
    elevation: 1.0,
    // centerTitle: true,
    title: Padding(
      padding: EdgeInsets.only(top: 1.0, left: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title.toString(),
          style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              letterSpacing: 1),
        ),
      ),
    ),

    actions: [
      icon1,
      isSecondIcon
          ? GestureDetector(
              onTap: () async {
                await UserFirebaseService(
                        user: Provider.of<User>(context, listen: false))
                    .addNewFeildTest(context)
                    .then((value) {
                  print("Value added ");
                  showSnackBar(context, "Added successfully");
                });
              },
              child: Container(
                  color: Colors.transparent,
                  height: 42,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(icon2, color: Colors.black, size: 25)),
            )
          : Container()
    ],

    flexibleSpace: FlexibleSpaceBar(background: flexibleChild),
  );
}

Widget sliverAppBarWithBackarrow(BuildContext context,
    {IconData icon2 = Icons.mic,
    bool isSecondIcon = false,
    required Widget icon1,
    required Widget flexibleChild}) {
  return SliverAppBar(
    expandedHeight: 80,
    // automaticallyImplyLeading: false,
    pinned: true,
    floating: true,
    titleSpacing: 1,
    backgroundColor: const Color.fromARGB(255, 29, 201, 192),
    elevation: 1.0,
    centerTitle: true,
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios_new_outlined,
          color: Colors.white,
          size: 18,
        )),
    actions: [
      icon1,
      isSecondIcon
          ? Container(
              color: Colors.transparent,
              height: 42,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(icon2, color: Colors.black, size: 25))
          : Container()
    ],

    flexibleSpace: FlexibleSpaceBar(
        background: Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: flexibleChild,
    )),
  );
}




//felixiblechild



// Padding(
//         padding: const EdgeInsets.only(bottom: 7),
//         child: Container(
//           alignment: Alignment.bottomCenter,
//           height: 20,
//           width: MediaQuery.of(context).size.width,
//           margin: EdgeInsets.only(left: 15, right: 15),
//           child: TextFormField(
//             onFieldSubmitted: (String text) {},
//             decoration: InputDecoration(
//               prefixIcon: InkWell(
//                 onTap: () {},
//                 child: const Padding(
//                   padding: EdgeInsets.only(
//                     left: 6,
//                   ),
//                   child: Icon(
//                     Icons.search,
//                     color: Colors.black,
//                     size: 23,
//                   ),
//                 ),
//               ),
//               filled: true,
//               fillColor: Colors.white,
//               contentPadding: const EdgeInsets.only(top: 10),
//               border: const OutlineInputBorder(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(10),
//                 ),
//                 borderSide: BorderSide.none,
//               ),
//               enabledBorder: const OutlineInputBorder(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(10),
//                 ),
//                 borderSide: BorderSide.none,
//               ),
//               hintText: 'Search...',
//               hintStyle: const TextStyle(
//                 fontWeight: FontWeight.w500,
//                 fontSize: 17,
//               ),
//             ),
//           ),
//         ),
//       ),

// import 'package:flutter/material.dart';
// import 'package:mq/widgets/notificationWidget.dart';

// Widget sliverAppBar(BuildContext context,
//     {String title = 'Mq',
//     IconData icon2 = Icons.mic,
//     required Widget icon1,
//     required Widget flexibleChild}) {
//   return SliverAppBar(
//     expandedHeight: 100,
//     // automaticallyImplyLeading: false,
//     pinned: true,
//     floating: true,
//     titleSpacing: 1,
//     backgroundColor: Color.fromARGB(255, 29, 201, 192),
//     elevation: 1.0,
//     centerTitle: true,
//     leading: Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Center(
//         child: Text(
//           'MQ',
//           style: TextStyle(
//               color: Colors.white,
//               fontSize: 15,
//               fontWeight: FontWeight.bold,
//               letterSpacing: 1),
//         ),
//       ),
//     ),
//     actions: [
//       InkWell(
//         onTap: () {},
//         child: Container(
//           width: 72,
//           padding: const EdgeInsets.symmetric(horizontal: 8),
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Icon(Icons.notifications_outlined,
//                       color: Colors.black, size: 25),
//                   // Text('2', overflow: TextOverflow.ellipsis),
//                 ],
//               ),
//               Positioned(
//                 top: 0,
//                 right: 0,
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
//                   decoration:
//                       BoxDecoration(shape: BoxShape.circle, color: Colors.red),
//                   alignment: Alignment.center,
//                   child: Text(
//                     '1',
//                     style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//       Container(
//         color: Colors.transparent,
//         height: 42,
//         margin: const EdgeInsets.symmetric(horizontal: 10),
//         child: const Icon(Icons.mic, color: Colors.black, size: 25),
//       ),
//     ],

//     flexibleSpace: FlexibleSpaceBar(
//       background: Padding(
//         padding: const EdgeInsets.only(bottom: 7),
//         child: Container(
//           alignment: Alignment.bottomCenter,
//           height: 20,
//           width: MediaQuery.of(context).size.width,
//           margin: EdgeInsets.only(left: 15, right: 15),
//           child: TextFormField(
//             onFieldSubmitted: (String text) {},
//             decoration: InputDecoration(
//               prefixIcon: InkWell(
//                 onTap: () {},
//                 child: const Padding(
//                   padding: EdgeInsets.only(
//                     left: 6,
//                   ),
//                   child: Icon(
//                     Icons.search,
//                     color: Colors.black,
//                     size: 23,
//                   ),
//                 ),
//               ),
//               filled: true,
//               fillColor: Colors.white,
//               contentPadding: const EdgeInsets.only(top: 10),
//               border: const OutlineInputBorder(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(10),
//                 ),
//                 borderSide: BorderSide.none,
//               ),
//               enabledBorder: const OutlineInputBorder(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(10),
//                 ),
//                 borderSide: BorderSide.none,
//               ),
//               hintText: 'Search...',
//               hintStyle: const TextStyle(
//                 fontWeight: FontWeight.w500,
//                 fontSize: 17,
//               ),
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }
