import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nhss_reign_forest_cafe/data/models/Order.dart';
import 'package:nhss_reign_forest_cafe/data/providers/order_provider.dart';
import 'package:nhss_reign_forest_cafe/data/repositories/order_repository.dart';
import 'package:nhss_reign_forest_cafe/presentation/redirects.dart';
import 'specific_order_screen.dart';
import 'order_card.dart';

class OrderHomeScreen extends StatefulWidget {
  const OrderHomeScreen({Key? key}) : super(key: key);

  @override
  State<OrderHomeScreen> createState() => _OrderHomeScreenState();
}

class _OrderHomeScreenState extends State<OrderHomeScreen> {
  String selectedButton = "Pending";

  Widget _buildNoOrdersWidget() {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 120),
          Image.asset(
            'assets/noOrders.png',
            width: 200,
            height: 200,
          ),
        ],
      ),
    );
  }

  Future<List<OrderModel>> _getOrders() async {
    OrderProvider orderProvider = OrderProvider();
    OrderRepository orderRepository = OrderRepository(orderProvider);

    List<OrderModel> allOrders = await orderRepository.getOrders();

    if (selectedButton.isNotEmpty) {
      print(" THE SELECTIOD BUTTON IS: " + selectedButton);
      List<OrderModel> filteredOrders =
          allOrders.where((order) => order.status == selectedButton).toList();
      return filteredOrders;
    } else {
      print("here");
      return allOrders;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        elevation: 0,
        title: Text(
          "Orders",
          style: GoogleFonts.beVietnamPro(
            textStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OrderSearchRedirect(),
                ),
              );
            },
            icon: Icon(
              Icons.search,
              size: 20,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.home,
              size: 20,
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          SliverToBoxAdapter(
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedButton = "Pending";
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedButton == "Pending"
                        ? Color.fromARGB(255, 151, 71, 255)
                        : Colors.grey[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: Container(
                    width: 60,
                    height: 15,
                    child: Text(
                      "Pending",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.beVietnamPro(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedButton = "Delivered";
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedButton == "Delivered"
                        ? Color.fromARGB(255, 151, 71, 255)
                        : Colors.grey[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: Container(
                    width: 60,
                    height: 15,
                    child: Text(
                      "Delivered",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.beVietnamPro(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedButton = "Canceled";
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedButton == "Canceled"
                        ? Color.fromARGB(255, 151, 71, 255)
                        : Colors.grey[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: Container(
                    width: 60,
                    height: 15,
                    child: Text(
                      "Canceled",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.beVietnamPro(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          SliverToBoxAdapter(
            child: FutureBuilder<List<OrderModel>>(
              future: _getOrders(),
              builder: (context, snapshot) {
                print(snapshot);
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<OrderModel> orders = snapshot.data ?? [];
                  if (orders.isEmpty) {
                    return _buildNoOrdersWidget();
                  } else {
                    return Column(
                      children: orders
                          .map((order) => Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SpecificOrder(
                                              orderId: order.orderID),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey[800],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: OrderCard(order: order),
                                  ),
                                  SizedBox(height: 15),
                                ],
                              ))
                          .toList(),
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
