// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Constants/Global_Variables.dart';

class CarouselWidget extends StatefulWidget {
  List<String> imgUrls;
  CarouselWidget({
    Key? key,
    required this.imgUrls,
  }) : super(key: key);

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
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
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            child: CarouselSlider.builder(
              itemCount: widget.imgUrls.length,
              itemBuilder: ((context, index, realIndex) {
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
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: widget.imgUrls[index],
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(
                            color: GlobalVariables.secondaryColor,
                          ),
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          color: Colors.grey,
                        ),
                      ),
                    ),
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
