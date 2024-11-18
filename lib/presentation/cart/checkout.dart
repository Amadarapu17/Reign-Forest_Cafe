import 'package:flutter/material.dart';
import 'package:nhss_reign_forest_cafe/data/models/Cart.dart';
import 'package:nhss_reign_forest_cafe/logic/item/item_bloc.dart';
import 'package:nhss_reign_forest_cafe/logic/item/item_event.dart';
import 'package:nhss_reign_forest_cafe/presentation/cart/widgets/input_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:another_flushbar/flushbar.dart';

class Checkout extends StatefulWidget {
  final Cart cart;
  final double total;

  const Checkout({super.key, required this.cart, required this.total});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController roomNumController = new TextEditingController();
  int selectedOption = 0;

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: statusBarHeight + 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
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
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 24.0, top: 20, right: 24, bottom: 20),
                  child: Text(
                    "Checkout",
                    style: GoogleFonts.beVietnamPro(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ),
              ],
            ),
            InputField(
              label: "Name",
              hintText: "Name",
              controller: nameController,
              typeOfInput: InputType.Regular,
              icon: Icon(
                Icons.person_outline,
                color: Colors.purple,
              ),
            ),
            InputField(
              label: "Email",
              hintText: "Email",
              controller: emailController,
              typeOfInput: InputType.Regular,
              icon: Icon(
                Icons.email_outlined,
                color: Colors.purple,
              ),
            ),
            InputField(
              label: "Room Number",
              hintText: "Room Number",
              controller: roomNumController,
              typeOfInput: InputType.Regular,
              icon: Icon(
                Icons.tag_outlined,
                color: Colors.purple,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ToggleButtons(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    height: 60,
                    width: 140,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: selectedOption == 0
                          ? Color(0xff9747FF)
                          : Colors.transparent,
                      border: Border.all(
                        color: Color(0xff9747FF),
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        "Pick-up",
                        style: TextStyle(
                            color: selectedOption == 0
                                ? Colors.white
                                : Color(0xff9747FF),
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    height: 60,
                    width: 140,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: selectedOption == 1
                          ? Color(0xff9747FF)
                          : Colors.transparent,
                      border: Border.all(
                        color: Color(0xff9747FF),
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        "Delivery",
                        style: TextStyle(
                            color: selectedOption == 1
                                ? Colors.white
                                : Color(0xff9747FF),
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
              isSelected: [selectedOption == 0, selectedOption == 1],
              onPressed: (int index) {
                setState(() {
                  selectedOption = index;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Column(
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
                          r"$" + "${widget.total.toStringAsFixed(2)}",
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
                  MaterialButton(
                    onPressed: () {
                      if (nameController.text.isEmpty ||
                          emailController.text.isEmpty ||
                          roomNumController.text.isEmpty) {
                        Flushbar(
                          title: "Required Fields",
                          backgroundColor: Colors.red,
                          flushbarPosition: FlushbarPosition.TOP,
                          message: "Fill out the required fields",
                          icon: Icon(
                            Icons.close,
                            size: 28.0,
                            color: Colors.white,
                          ),
                          duration: Duration(seconds: 2),
                        )..show(context);
                      } else if (widget.total == 0) {
                        Flushbar(
                          title: "Zero Items",
                          backgroundColor: Colors.red,
                          flushbarPosition: FlushbarPosition.TOP,
                          message: "Add Items to Order",
                          icon: Icon(
                            Icons.close,
                            size: 28.0,
                            color: Colors.white,
                          ),
                          duration: Duration(seconds: 2),
                        )..show(context);
                      } else {
                        BlocProvider.of<ItemBloc>(context).add(AddOrder(
                            name: nameController.text,
                            email: emailController.text,
                            room: roomNumController.text,
                            status: "Pending",
                            cart: widget.cart,
                            style: selectedOption,
                            totalPrice: widget.total));
                        Navigator.popUntil(context,
                            (Route<dynamic> predicate) => predicate.isFirst);
                        Flushbar(
                          title: "Order Placed",
                          backgroundColor: Colors.green,
                          flushbarPosition: FlushbarPosition.TOP,
                          message: "Order Has Been Successfully Placed",
                          icon: Icon(
                            Icons.close,
                            size: 28.0,
                            color: Colors.white,
                          ),
                          duration: Duration(seconds: 2),
                        )..show(context);
                      }
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
                          "Place Order",
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
