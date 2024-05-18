import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quadrant_app/blocs/product/bloc/product_bloc.dart';
import 'package:quadrant_app/pages/components/custom_textfield.dart';
import 'package:quadrant_app/pages/components/section_text.dart';
import 'package:quadrant_app/repositories/ProductRepository/product_repository.dart';
import 'package:quadrant_app/utils/custom_constants.dart';
import 'package:quadrant_app/utils/helpers/network/dio_manager.dart';
import 'package:sticky_headers/sticky_headers.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with WidgetsBindingObserver {
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
    return ListView(
      controller: _scrollController,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 19),
          child: SectionText(isDark: isDark, text: 'Browse', size: 32.0, bold: true),
        ),
        StickyHeader(
          controller: _scrollController,
          headerSpacing: 60.0,
          header: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomTextFieldComponent(
              hint: 'Search for groceries, and more...',
              txtController: searchController,
              isLoading: false,
              onChange: (String val) {},
            ),
          ),
          content: ProductsGrid(productRepository: _productRepository, isDark: isDark),
        ),
      ]
    );
  }
}

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({
    super.key,
    required ProductRepository productRepository,
    required this.isDark,
  }) : _productRepository = productRepository;

  final ProductRepository _productRepository;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(productRepository: _productRepository)..add(FetchProduct()),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
          switch (state) {
            case ProductLoading():
              return const Center(child: CircularProgressIndicator());
            case ProductLoaded():
            return GridView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 columns
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.75,
              ),
              itemCount: state.products?.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  isDark: isDark,
                  name: state.products?[index].name ?? "",
                  price: state.products?[index].price ?? 0.0,
                  rating: 0.0,
                  image: state.products?[index].images?[0].url ?? "",
                );
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
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  bool isDark;
  final String name;
  final double price;
  final double rating;
  final String image;

  ProductCard({super.key, 
    required this.isDark,
    required this.name,
    required this.price,
    required this.rating,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: isDark ? CustomColors.secondaryDark : CustomColors.secondaryLight,
        borderRadius: BorderRadius.circular(CustomSize.md),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(CustomSize.md),
            child: (image != "") ? Image.network(image) : Image.asset('assets/placeholders/placeholder-user.jpg')
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'RM ${price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 20,
                  ),
                  SizedBox(width: 2),
                  Text(
                    '0.0',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),

            ],
          ),
        ],
      ),
    );
  }
}
