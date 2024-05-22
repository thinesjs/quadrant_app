// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quadrant_app/blocs/product/bloc/product_bloc.dart';
import 'package:quadrant_app/pages/components/buttons.dart';
import 'package:quadrant_app/pages/components/circle_action_button.dart';
import 'package:quadrant_app/pages/components/texts.dart';
import 'package:quadrant_app/repositories/ProductRepository/product_repository.dart';
import 'package:quadrant_app/utils/custom_constants.dart';
import 'package:quadrant_app/utils/helpers/network/dio_manager.dart';

class ProductScreen extends StatelessWidget {
  final String productId;
  const ProductScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (_) => ProductBloc(productRepository: ProductRepository(DioManager.instance))
        ..add(FetchProduct(productId)),
      child: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
        switch (state) {
          case ProductLoading():
            return const Center(child: CircularProgressIndicator());
          case ProductLoaded():
            return Scaffold(
              body: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 330,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(state.product.images![0].url!),
                            fit: BoxFit.cover,
                          )
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: displayHeight / 14),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleActionButton(isDark: isDark, icon: Iconsax.arrow_left, onTap: () { Navigator.pop(context); },),
                              Row(
                                children: [
                                  CircleActionButton(isDark: isDark, icon: Iconsax.export, onTap: () { Navigator.pop(context); },),
                                  SizedBox(width: 14),
                                  CircleActionButton(isDark: isDark, icon: Iconsax.heart, onTap: () { Navigator.pop(context); },),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SectionText(isDark: isDark, text: state.product.name!, size: 20.0, bold: true),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Iconsax.star1, color: Colors.amber),
                                  NormalText(isDark: isDark, text: "2.4"),
                                ],
                              ),
                            ],
                          ),
                          SectionHelperText(isDark: isDark, text: 'Description', bold: true),
                          NormalText(isDark: isDark, text: state.product.desc!),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              bottomNavigationBar: Container(
                height: 100, 
                color: isDark? CustomColors.cardColorDark : CustomColors.cardColorLight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SectionText(isDark: isDark, text: "RM ${state.product.price.toString()}", size: 27.0, bold: true),
                      SizedBox(
                        height: 50,
                        width: 150,
                        child: AppFilledButton(isDark: isDark, text: "Buy", onTap: (){})
                      ),
                    ],
                  ),
                ),
              ),
            );
          case ProductError():
            return Scaffold(body: const Text('Something went wrong!'));
          case ProductInitial():
            return const Center(child: Text("Initial"));
          default:
            return const Placeholder();
        }
      })
    );
  }
}
