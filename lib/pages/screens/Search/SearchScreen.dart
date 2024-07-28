import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quadrant_app/blocs/product/bloc/product_bloc.dart';
import 'package:quadrant_app/pages/components/custom_textfield.dart';
import 'package:quadrant_app/pages/components/product_card.dart';
import 'package:quadrant_app/pages/components/texts.dart';
import 'package:quadrant_app/pages/screens/Product/ProductScreen.dart';
import 'package:quadrant_app/repositories/ProductRepository/product_repository.dart';
import 'package:quadrant_app/utils/custom_constants.dart';
import 'package:quadrant_app/utils/helpers/network/dio_manager.dart';
import 'package:sticky_headers/sticky_headers.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
        builder: (_) => const Scaffold(body: SearchScreen()));
  }

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with WidgetsBindingObserver {
  final ScrollController _scrollController = ScrollController();
  late final ProductRepository _productRepository;
  var searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _productRepository = ProductRepository(DioManager.instance);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return BlocProvider<ProductBloc>(
      create: (_) => ProductBloc(productRepository: _productRepository)
        ..add(FetchProducts()),
      child: ListView(controller: _scrollController, physics: const ClampingScrollPhysics(), children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 19),
          child: SectionText(
              isDark: isDark, text: 'Browse', size: 32.0, bold: true),
        ),
        StickyHeader(
          controller: _scrollController,
          headerSpacing: 60.0,
          header: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Builder(builder: (context) {
              return CustomTextFieldComponent(
                hint: 'Search for groceries, and more...',
                txtController: searchController,
                isLoading: false,
                onChange: (String val) {
                  if (val.length > 3) {
                    BlocProvider.of<ProductBloc>(context)
                        .add(SearchProducts(val));
                  } else {
                    BlocProvider.of<ProductBloc>(context).add(FetchProducts());
                  }
                },
              );
            }),
          ),
          content: ProductsGrid(isDark: isDark),
        ),
      ]),
    );
  }
}

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({
    super.key,
    required this.isDark,
  });
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
        switch (state) {
          case ProductLoading():
            return Center(child: LoadingAnimationWidget.waveDots(color: isDark ? CustomColors.primaryLight : CustomColors.textColorLight, size: 24));
          case ProductsLoaded():
            return GridView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 columns
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.675,
              ),
              itemCount: state.products?.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  isDark: isDark,
                  name: state.products?[index].name ?? "",
                  price: state.products?[index].price ?? 0.0,
                  rating: 0.0,
                  image: state.products?[index].images?[0].url ?? "", 
                  onTap: () { 
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => ProductScreen(productId: state.products?[index].id ?? ''),
                      ),
                    );
                    },
                ).animate().fade();
              },
            );
          case ProductError():
            return const Text('Something went wrong!');
          case ProductInitial():
            return const Center(child: Text("Initial"));
          default:
            return const Placeholder();
        }
      }),
    );
  }
}

