import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quadrant_app/pages/components/circle_action_button.dart';
import 'package:quadrant_app/pages/components/texts.dart';

class EwalletTransactionsScreen extends StatefulWidget {
  const EwalletTransactionsScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
        builder: (_) => const EwalletTransactionsScreen());
  }

  @override
  State<EwalletTransactionsScreen> createState() =>
      _EwalletTransactionsScreenState();
}

class _EwalletTransactionsScreenState extends State<EwalletTransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    double displayHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 19),
            child: ListView(
              children: <Widget>[
                Row(
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
                        text: 'Transactions',
                        size: 32.0,
                        bold: true),
                  ],
                ),
                // BlocProvider(
                //     create: (context) => CartBloc(cartRepository: _cartRepository)
                //       ..add(FetchCart()),
                //     child: BlocBuilder<CartBloc, CartState>(
                //       builder: (context, state) {
                //         switch (state) {
                //           case CartLoading():
                //             return const Center(
                //                 child: CircularProgressIndicator());
                //           case CartLoaded():
                //             return ListView.builder(
                //                 shrinkWrap: true,
                //                 physics: const ClampingScrollPhysics(),
                //                 itemCount: state.cart.length,
                //                 itemBuilder: (context, index) {
                //                   final cartItem = state.cart[index];
                //                   return Padding(
                //                     padding:
                //                         const EdgeInsets.symmetric(vertical: 8),
                //                     child: ShoppingCartItem(cartItem: cartItem),
                //                   );
                //                 });
                //           case CartError():
                //             return const Text('Something went wrong!');
                //           case CartInitial():
                //             return const Center(child: Text("Loading"));
                //           default:
                //             return const Placeholder();
                //         }
                //       },
                //     )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
