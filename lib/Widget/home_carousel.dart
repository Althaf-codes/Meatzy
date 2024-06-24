import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Constants/Global_Variables.dart';

class HomeCarousel extends StatefulWidget {
  const HomeCarousel({Key? key}) : super(key: key);

  @override
  State<HomeCarousel> createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel> {
  // final List<String> imgList = [
  //   "assets/images/carousel1.jpg",
  //   "assets/images/carousel2.jpg",
  //   "assets/images/carousel3.jpg",
  // ];

  CarouselController carouselController = CarouselController();
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.24,
            width: MediaQuery.of(context).size.width,
            child: CarouselSlider.builder(
              itemCount: GlobalVariables.carouselImages.length,
              itemBuilder: ((context, index, realIndex) {
                final urlImage = GlobalVariables.carouselImages[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.24,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        // boxShadow: [
                        //   BoxShadow(
                        //       color: Colors.grey.shade300,
                        //       spreadRadius: 0.0,
                        //       blurRadius: elevation,
                        //       offset: Offset(3.0, 3.0)),
                        //   BoxShadow(
                        //       color: Colors.grey.shade400,
                        //       spreadRadius: 0.0,
                        //       blurRadius: elevation / 2.0,
                        //       offset: Offset(3.0, 3.0)),
                        //   BoxShadow(
                        //       color: Colors.white,
                        //       spreadRadius: 2.0,
                        //       blurRadius: elevation,
                        //       offset: Offset(-3.0, -3.0)),
                        //   BoxShadow(
                        //       color: Colors.white,
                        //       spreadRadius: 2.0,
                        //       blurRadius: elevation / 2,
                        //       offset: Offset(-3.0, -3.0)),
                        // ],
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(urlImage),
                          fit: BoxFit.cover,
                        )),
                  ),
                );
              }),
              carouselController: carouselController,
              options: CarouselOptions(
                  aspectRatio: 1 / 1,
                  viewportFraction: 1,
                  autoPlayInterval: const Duration(seconds: 2),
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  autoPlay: true,
                  autoPlayCurve: Curves.easeInOut,
                  onPageChanged: (index, reason) {
                    setState(() {
                      activeIndex = index;
                    });
                  }),
            )),
        Center(
            child: AnimatedSmoothIndicator(
          onDotClicked: (index) {
            setState(() {
              activeIndex = index;
              carouselController.jumpToPage(index);
            });
          },
          activeIndex: activeIndex,
          count: GlobalVariables.carouselImages.length,
          effect: const WormEffect(
              activeDotColor: Color.fromARGB(255, 6, 81, 143),
              dotColor: Colors.black12,
              dotHeight: 8,
              dotWidth: 8),
        ))
      ],
    );
  }
}
