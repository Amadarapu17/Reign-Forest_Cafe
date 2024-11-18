
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nhss_reign_forest_cafe/presentation/cart/widgets/input_field.dart';
import 'package:nhss_reign_forest_cafe/presentation/order/order_home_screen.dart';

class OrderLogin extends StatefulWidget {
  const OrderLogin({super.key});

  @override
  State<OrderLogin> createState() => _OrderLoginState();
}

class _OrderLoginState extends State<OrderLogin> {
  String password = '';
  String incorrect = '';
  TextEditingController loginController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
        body: Column(
          children: [
            SizedBox(height: 150),
            Text(
              "Employee Login",
              style: GoogleFonts.beVietnamPro(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 100),
            Center(
              child: InputField(
                  label: "Password",
                  hintText: "Password",
                  typeOfInput: InputType.Regular,
                  icon: Icon(
                    Icons.key,
                    color: Colors.purple,
                  ),
                  controller: loginController),
            ),
            Text(
              incorrect,
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                password = loginController.text;
                print(password);
                check(password);
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Color(0xff9747FF)),
              ),
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ));
  }

  @override
  void check(String p) {
    if (p == r'cafe') {
      setState(() {
        incorrect = '';
      });
      loginController.text = '';
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OrderHomeScreen()),
      );
    } else {
      setState(() {
        incorrect = 'Incorrect password. Try again.';
      });
    }
  }
}
