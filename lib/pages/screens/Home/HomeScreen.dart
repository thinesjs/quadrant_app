// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quadrant_app/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:quadrant_app/blocs/billboard/bloc/billboard_bloc.dart';
import 'package:quadrant_app/blocs/product/bloc/product_bloc.dart';
import 'package:quadrant_app/pages/components/category_button.dart';
import 'package:quadrant_app/pages/components/circle_action_button.dart';
import 'package:quadrant_app/pages/components/custom_textfield.dart';
import 'package:quadrant_app/pages/components/product_card.dart';
import 'package:quadrant_app/pages/components/promo_image.dart';
import 'package:quadrant_app/pages/components/texts.dart';
import 'package:quadrant_app/pages/main_page.dart';
import 'package:quadrant_app/pages/screens/Category/CategoryScreen.dart';
import 'package:quadrant_app/pages/screens/Product/ProductScreen.dart';
import 'package:quadrant_app/pages/screens/Search/SearchScreen.dart';
import 'package:quadrant_app/repositories/BillboardRepository/billboard_repository.dart';
import 'package:quadrant_app/repositories/ProductRepository/product_repository.dart';
import 'package:quadrant_app/repositories/UserRepository/models/user.dart';
import 'package:quadrant_app/utils/custom_constants.dart';
import 'package:quadrant_app/utils/helpers/network/dio_manager.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Category {
      final String name;
      final IconData icon;

      Category({required this.name, required this.icon});
    }

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

  late final BillboardRepository _billboardRepository;
  late final ProductRepository _productRepository;

  @override
  void initState() {
    super.initState();
    _billboardRepository = BillboardRepository(DioManager.instance);
    _productRepository = ProductRepository(DioManager.instance);
  }

  final List<Category> categories = [
    Category(name: 'Grocery', icon: Iconsax.tree),
    Category(name: 'Household', icon: Iconsax.lamp),
    Category(name: 'Health & Beauty', icon: Iconsax.health),
    Category(name: 'Appliances', icon: Iconsax.mobile),
    Category(name: 'Pets', icon: Iconsax.pet),
    Category(name: 'Bakery', icon: Iconsax.cake),
    Category(name: 'Fresh Produce', icon: Iconsax.milk),
    Category(name: 'More', icon: Iconsax.more),
  ];
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    User user = context.select<AuthenticationBloc, User>((bloc) => bloc.state.user);
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        controller: _controller,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: displayHeight / 14),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://live.staticflickr.com/4475/37095348433_626859af3c_b.jpg'),
                      fit: BoxFit.fill,
                      opacity: .5),
                  color: Colors.black87),
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
                            onTap: ()=> mainPageKey.currentState?.switchToScreen(4),
                            child: CircleAvatar(
                              backgroundImage: (user.avatar != "")
                                  ? NetworkImage(user.avatar)
                                  : AssetImage(
                                          'assets/placeholders/placeholder-user.jpg')
                                      as ImageProvider<Object>,
                            ),
                          ),
                          CircleActionButton(isDark: isDark, icon: Iconsax.notification, onTap: () {  },)
                        ],
                      ),
                    ),
                    Text(
                      "Hey, ${context.select<AuthenticationBloc, String?>((bloc) => bloc.state.user.name)} 👋🏽",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.textColorDark),
                    ),
                    Text(
                      "Discover what's happening around you",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: CustomColors.textColorDark
                      ),
                    ),
                    CustomTextFieldComponent(
                      hint: 'Search for groceries, and more...',
                      txtController: usernameController,
                      isLoading: false,
                      onChange: (String val) {},
                    )
                  ],
                ),
              ),
            ),
            BlocProvider(
              create: (context) => BillboardBloc(billboardRepository: _billboardRepository)..add(FetchBillboard()),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: BlocBuilder<BillboardBloc, BillboardState>(builder: (context, state) {
                  switch (state) {
                    case BillboardLoading():
                      return Column(
                        children: [
                          Shimmer.fromColors(
                            baseColor: isDark ? CustomColors.cardColorDark : CustomColors.cardColorLight,
                            highlightColor: isDark ? CustomColors.cardColorDarkLoading : CustomColors.cardColorLightLoading,
                            child: CarouselSlider(
                              items: [
                                PromoImageComponent(
                                  imageUrl: "",
                                  margin: EdgeInsets.all(10),
                                  onTap: () {},
                                )
                              ],
                              options: CarouselOptions(autoPlay: true, viewportFraction: 1, height: 134, enableInfiniteScroll: false),
                              carouselController: sliderController,
                            )
                          ),
                          FutureBuilder(
                            future: sliderController.onReady,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.done) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: SmoothPageIndicator(
                                      controller: sliderController.state!.pageController!,
                                      count: sliderController.state!.itemCount!,
                                      onDotClicked: (val) {
                                        sliderController.animateToPage(val);
                                      },
                                      effect: const WormEffect(
                                          dotHeight: 5,
                                          dotWidth: 16,
                                          activeDotColor: CustomColors.primaryDark),
                                    ),
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          )
                        ],
                      );
                    case BillboardLoaded():
                      return Column(
                        children: [
                          CarouselSlider(
                            items: state.billboards?.map((billboard) {
                              return PromoImageComponent(
                                imageUrl: billboard.imageUrl ?? "",
                                margin: EdgeInsets.all(10),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(billboard.title ?? ""),
                                        content: Text(billboard.description ?? ""),
                                        actions: [
                                          TextButton(
                                            onPressed: () {Navigator.of(context, rootNavigator: true).pop('dialog');},
                                            child: Text('Close'),
                                          )
                                        ],
                                      );
                                    },
                                  );
                                },
                              );
                            }).toList(), 
                            options: CarouselOptions(autoPlay: true, viewportFraction: 1, height: 134),
                            carouselController: sliderController,
                          ),
                          FutureBuilder(
                            future: sliderController.onReady,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.done) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: SmoothPageIndicator(
                                      controller: sliderController.state!.pageController!,
                                      count: sliderController.state!.itemCount!,
                                      onDotClicked: (val) {
                                        sliderController.animateToPage(val);
                                      },
                                      effect: const WormEffect(
                                        dotHeight: 5,
                                        dotWidth: 16,
                                        activeDotColor: CustomColors.primaryDark
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          )
                        ],
                      );
                    case BillboardError():
                      return const Text('Something went wrong!');
                    case BillboardInitial():
                      return const Center(child: Text("Initial"));
                    default:
                      return const Placeholder();
                  }
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(19),
              child: GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                  childAspectRatio: 0.7,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return CategoryButton(category: categories[index], isDark: isDark, onTap: () { 
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryScreen(categoryName: categories[index].name),
                      ),
                    );
                   },);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SectionText(isDark: isDark, text: "Featured", size: 20.0, bold: true),
                  SideSectionText(isDark: isDark, text: "See all", size: 16.0, onTap: ()=> mainPageKey.currentState?.switchToScreen(1)),
                ],
              ),
            ),
            BlocProvider(
              create: (context) => ProductBloc(productRepository: _productRepository)..add(FetchFeaturedProduct()),
              child: Padding(
                padding: const EdgeInsets.all(19),
                child: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
                  switch (state) {
                    case ProductLoading():
                      return Center(child: LoadingAnimationWidget.waveDots(color: isDark ? CustomColors.primaryLight : CustomColors.textColorLight, size: 24));
                    case ProductsLoaded():
                      return SizedBox(
                        height: 270.0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.zero,
                          itemCount: state.products?.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: ProductCard(
                                isDark: isDark,
                                name: state.products?[index].name ?? "",
                                price: state.products?[index].price ?? 0.0,
                                rating: 0.0,
                                image: state.products?[index].images?[0].url ?? "",
                                onTap: () { 
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductScreen(productId: state.products?[index].id ?? ''),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      );
                    case ProductError():
                      return const Text('Something went wrong!');
                    case ProductInitial():
                      return const Center(child: Text("Initial"));
                    default:
                      return const Placeholder();
                  }
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SectionText(isDark: isDark, text: "New Arrivals", size: 20.0, bold: true),
                  SideSectionText(isDark: isDark, text: "See all", size: 16.0, onTap: ()=> mainPageKey.currentState?.switchToScreen(1)),
                ],
              ),
            ),
            BlocProvider(
              create: (context) => ProductBloc(productRepository: _productRepository)..add(FetchNewArrivalsProduct()),
              child: Padding(
                padding: const EdgeInsets.all(19),
                child: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
                  switch (state) {
                    case ProductLoading():
                      return Center(child: LoadingAnimationWidget.waveDots(color: isDark ? CustomColors.primaryLight : CustomColors.textColorLight, size: 24));
                    case ProductsLoaded():
                      return SizedBox(
                        height: 270.0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.zero,
                          itemCount: state.products?.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: ProductCard(
                                isDark: isDark,
                                name: state.products?[index].name ?? "",
                                price: state.products?[index].price ?? 0.0,
                                rating: 0.0,
                                image: state.products?[index].images?[0].url ?? "",
                                onTap: () { 
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductScreen(productId: state.products?[index].id ?? ''),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      );
                    case ProductError():
                      return const Text('Something went wrong!');
                    case ProductInitial():
                      return const Center(child: Text("Initial"));
                    default:
                      return const Placeholder();
                  }
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SectionText(isDark: isDark, text: "For You", size: 20.0, bold: true),
                  SideSectionText(isDark: isDark, text: "See all", size: 16.0, onTap: ()=> mainPageKey.currentState?.switchToScreen(1)),
                ],
              ),
            ),
            BlocProvider(
              create: (context) => ProductBloc(productRepository: _productRepository)..add(FetchForYouProduct()),
              child: Padding(
                padding: const EdgeInsets.all(19),
                child: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
                  switch (state) {
                    case ProductLoading():
                      return Center(child: LoadingAnimationWidget.waveDots(color: isDark ? CustomColors.primaryLight : CustomColors.textColorLight, size: 24));
                    case ProductsLoaded():
                      return SizedBox(
                        height: 270.0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.zero,
                          itemCount: state.products?.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: ProductCard(
                                isDark: isDark,
                                name: state.products?[index].name ?? "",
                                price: state.products?[index].price ?? 0.0,
                                rating: 0.0,
                                image: state.products?[index].images?[0].url ?? "",
                                onTap: () { 
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductScreen(productId: state.products?[index].id ?? ''),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      );
                    case ProductError():
                      return const Text('Something went wrong!');
                    case ProductInitial():
                      return const Center(child: Text("Initial"));
                    default:
                      return const Placeholder();
                  }
                }),
              ),
            ),

            SizedBox(height: displayHeight / 7),
          ],
        ),
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