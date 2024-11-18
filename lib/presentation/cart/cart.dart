import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nhss_reign_forest_cafe/data/models/Cart.dart';
import 'package:nhss_reign_forest_cafe/logic/item/item_bloc.dart';
import 'package:nhss_reign_forest_cafe/logic/item/item_event.dart';
import 'package:nhss_reign_forest_cafe/logic/item/item_state.dart';
import 'package:nhss_reign_forest_cafe/presentation/cart/widgets/cart_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nhss_reign_forest_cafe/presentation/redirects.dart';

class CartBuild extends StatefulWidget {
  const CartBuild({super.key});

  @override
  State<CartBuild> createState() => _CartBuildState();
}

class _CartBuildState extends State<CartBuild> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ItemBloc, ItemState>(
        listener: (context, state) {},
        builder: (context, state) {
          print(state);
          if (state is CartObtained) {
            Cart cart = state.cart;
            print(state.cart);
            return CartPage(
              cart: cart,
              cartPrice: state.totalPrice,
            );
          }

          if (state is ItemFailure) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

class CartPage extends StatelessWidget {
  final Cart cart;
  final double cartPrice;
  const CartPage({super.key, required this.cart, required this.cartPrice});

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: statusBarHeight,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20.0),
            //padding:
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.grey,
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back),
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 24.0, top: 20, right: 24, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.ideographic,
              children: [
                Text(
                  "Cart",
                  style: GoogleFonts.beVietnamPro(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                MaterialButton(
                  onPressed: () {
                    BlocProvider.of<ItemBloc>(context).add(RemoveAllFromCart());
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CartRedirect()),
                    );
                  },
                  child: Text(
                    "Remove all",
                    style: GoogleFonts.beVietnamPro(
                        color: Colors.white, fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Expanded(
              child: Container(
                //height: 500,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          CartItem(
                            item: cart.items[index],
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      );
                    }),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total: ",
                      style: GoogleFonts.beVietnamPro(
                          fontSize: 16,
                          color: const Color.fromARGB(255, 85, 85, 85)),
                    ),
                    Text(
                      r"$" + cartPrice.toStringAsFixed(2),
                      style: GoogleFonts.beVietnamPro(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CheckoutRedirect(
                                  cart: cart,
                                  total: cartPrice,
                                )),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Color(0xff9747FF),
                      ),
                      height: 55,
                      width: 342,
                      child: Center(
                        child: Text(
                          "Proceed to Checkout",
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40)
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
