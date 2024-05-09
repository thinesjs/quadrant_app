// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quadrant_app/pages/components/custom_textfield.dart';
import 'package:quadrant_app/pages/components/promo_image.dart';
import 'package:quadrant_app/utils/custom_constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomeScreen());
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var usernameController = TextEditingController();
  CustomCarouselController sliderController = CustomCarouselController();

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 65.0),
            height: displayWidth / 1.5,
            // decoration: BoxDecoration(color: Colors.blue.shade800),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://live.staticflickr.com/4475/37095348433_626859af3c_b.jpg'),
                fit: BoxFit.fill,
                opacity: .5
              ),
              color: Colors.black
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => {},
                          child: CircleAvatar(
                            backgroundImage: NetworkImage('https://i.pravatar.cc/150'),
                          ),
                        ),
                        Container(
                          height: 42,
                          width: 42,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(42)),
                            color: Colors.black.withOpacity(.4),
                          ),
                          child: Icon(Iconsax.notification, color: isDark ? CustomColors.componentColorDark : CustomColors.componentColorLight),
                        )
                      ],
                    ),
                  ),
                  Text("Hey, Adam Brooke 👋🏽",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: CustomColors.textColorDark
                    ),
                  ),
                  Text("Discover what's happening around you",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: CustomColors.textColorDark
                    ),
                  ),
                  CustomTextFieldComponent(hint: 'Search restaurants, salon…', txtController: usernameController, isLoading: false, onChange: (String val) {  },)
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(19),
            child: CarouselSlider(
              items: [
                PromoImageComponent(imageUrl: 'https://i.ibb.co/x851dXt/banner-1.jpg', margin: EdgeInsets.all(5), onTap: () {  },),
                PromoImageComponent(imageUrl: 'https://i.ibb.co/nz5RpPZ/banner-2.jpg', margin: EdgeInsets.all(5), onTap: () {  },),
                PromoImageComponent(imageUrl: 'https://i.ibb.co/x1BQyNm/banner-3.jpg', margin: EdgeInsets.all(5), onTap: () {  },),
                PromoImageComponent(imageUrl: 'https://i.ibb.co/KKdnPpk/banner-4.jpg', margin: EdgeInsets.all(5), onTap: () {  },),
                PromoImageComponent(imageUrl: 'https://i.ibb.co/p1sS22g/banner-6.jpg', margin: EdgeInsets.all(5), onTap: () {  },),
              ], 
              options: CarouselOptions(
                autoPlay: true,
                viewportFraction: 1
              ),
              carouselController: sliderController,
            ),
          ),
          FutureBuilder(
            future: sliderController.onReady,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SmoothPageIndicator(
                      controller: sliderController.state!.pageController!,
                      count: sliderController.state!.itemCount!,
                      onDotClicked: (val) {
                        sliderController.animateToPage(val);
                      },
                      effect: const WormEffect(
                        dotHeight: 7,
                        dotWidth: 16,
                        activeDotColor: Color(0xFF34AC7F)
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
          },
        ),
          
        ],
      ),
    );
  }
}

class CustomCarouselController extends CarouselControllerImpl {
  CarouselState? _state;
  CarouselState? get state => _state;

  @override
  set state(CarouselState? state) {
    _state = state;
    super.state = state;
  }
}
