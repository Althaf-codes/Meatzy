import 'package:flutter/material.dart';

import '../Constants/Global_Variables.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> category = GlobalVariables.categoryImages;
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: category.length,
          itemBuilder: ((context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12, top: 10),
              child: InkWell(
                onTap: () {
                  //   selectedItem(context, index);
                },
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                category[index]['image']!,
                              ))),
                    ),
                    // CircleAvatar(
                    //   radius: 30,
                    //   backgroundColor: Colors.transparent,
                    //   backgroundImage:
                    //       AssetImage(category[index]['image'].toString()),
                    // ),
                    Expanded(
                      child: Text(
                        category[index]['title'].toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              ),
            );
          })),
    );
  }

  // void selectedItem(BuildContext context, int index) {
  //   switch (index) {
  //     case 0:
  //       Navigator.pushNamed(context, PetScreen.route);
  //       break;
  //     case 1:
  //       Navigator.pushNamed(context, CattleScreen.route);
  //       break;
  //     case 2:
  //       Navigator.pushNamed(context, MeatScreen.route);
  //       break;
  //     case 3:
  //       Navigator.pushNamed(context, FeedScreen.route);
  //       break;
  //     case 4:
  //       Navigator.pushNamed(context, AccessoryScreen.route);
  //       break;
  //     case 5:
  //       Navigator.pushNamed(context, MedicineScreen.route);
  //       break;

  //     default:
  //   }
  // }
}
