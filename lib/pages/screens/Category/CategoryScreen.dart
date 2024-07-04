import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quadrant_app/blocs/product/bloc/product_bloc.dart';
import 'package:quadrant_app/pages/components/circle_action_button.dart';
import 'package:quadrant_app/pages/components/product_card.dart';
import 'package:quadrant_app/pages/components/texts.dart';
import 'package:quadrant_app/pages/screens/Product/ProductScreen.dart';
import 'package:quadrant_app/repositories/ProductRepository/product_repository.dart';
import 'package:quadrant_app/utils/custom_constants.dart';
import 'package:quadrant_app/utils/helpers/network/dio_manager.dart';

class CategoryScreen extends StatelessWidget {
  final String categoryName;
  const CategoryScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 78),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleActionButton(
                    isDark: isDark,
                    icon: Iconsax.arrow_left,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SectionText(
                      isDark: isDark,
                      text: categoryName,
                      size: 32.0,
                      bold: true),
                ],
              ),
            ),
            const SizedBox(height: 10),
            BlocProvider(
                create: (context) => ProductBloc(
                    productRepository: ProductRepository(DioManager.instance))
                  ..add(FetchProductByCategory(categoryName)),
                child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    switch (state) {
                      case ProductLoading():
                        return Center(
                            child: LoadingAnimationWidget.waveDots(
                                color: isDark
                                    ? CustomColors.primaryLight
                                    : CustomColors.textColorLight,
                                size: 24));
                      case ProductsLoaded():
                        return Expanded(
                          child: FadingEdgeScrollView.fromScrollView(
                            child: GridView.builder(
                              controller: ScrollController(),
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
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
                                  image:
                                      state.products?[index].images?[0].url ??
                                          "",
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductScreen(
                                            productId:
                                                state.products?[index].id ??
                                                    ''),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        );
                      case ProductError():
                        return const Text('Something went wrong!');
                      case ProductInitial():
                        return const Center(child: Text("Loading"));
                      default:
                        return const Placeholder();
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }
}
