// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nhss_reign_forest_cafe/data/models/Order.dart';
import 'package:nhss_reign_forest_cafe/data/providers/order_provider.dart';
import 'package:nhss_reign_forest_cafe/data/repositories/order_repository.dart';

import 'package:cloud_firestore/cloud_firestore.dart' as FirebaseFirestore;

class SpecificOrder extends StatefulWidget {
  final String orderId;

  const SpecificOrder({super.key, required this.orderId});

  @override
  State<SpecificOrder> createState() => _SpecificOrderState();
}

class _SpecificOrderState extends State<SpecificOrder> {
  Future<OrderModel?> _getOrder(String orderID) async {
    OrderProvider orderProvider = OrderProvider();
    OrderRepository orderRepository = OrderRepository(orderProvider);

    List<OrderModel> allOrders = await orderRepository.getOrders();

    for (OrderModel order in allOrders) {
      if (order.orderID == orderID) {
        return order;
      }
    }

    return null;
  }

  Future<double?> _calculateTotalPrice() async {
    OrderModel? order = await _getOrder(widget.orderId);

    if (order == null) {
      return null;
    }

    double totalPrice = 0.0;

    List<Map<String, dynamic>> items =
        (order.items ?? []).cast<Map<String, dynamic>>();

    for (var item in items) {
      List<int> choiceSelection = List<int>.from(item['choiceSelection']);
      double price = double.parse(item['price'].toString());

      double itemTotal = 0.0;
      for (int selection in choiceSelection) {
        itemTotal += selection * price;
      }

      totalPrice += itemTotal;
    }

    return totalPrice;
  }

  Future<void> _updateOrderStatus(String orderId, String status) async {
    FirebaseFirestore.FirebaseFirestore firestore =
        FirebaseFirestore.FirebaseFirestore.instance;

    try {
      await firestore.collection('orders').doc(orderId).update({
        'status': status,
      });
    } catch (e) {
      print('Error updating order status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[800],
                                  shape: CircleBorder()),
                              child: Container(
                                width: 50,
                                height: 50,
                                child: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  color: Colors.white,
                                ),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FutureBuilder<OrderModel?>(
                        future: _getOrder(widget.orderId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            OrderModel? order = snapshot.data;
                            if (order == null) {
                              return Text('Order not found.');
                            }
                            return Text((order.name),
                                style: GoogleFonts.beVietnamPro(
                                    textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                )));
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FutureBuilder<OrderModel?>(
                        future: _getOrder(widget.orderId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            OrderModel? order = snapshot.data;
                            if (order == null) {
                              return Text('Order not found.');
                            }
                            return Row(
                              children: [
                                Text("Order Style:",
                                    style: GoogleFonts.beVietnamPro(
                                        textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ))),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(order.style,
                                    style: GoogleFonts.beVietnamPro(
                                        textStyle: TextStyle(
                                      color: Color.fromARGB(255, 112, 45, 255),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ))),
                              ],
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 11,
                            backgroundColor: Color.fromARGB(255, 112, 45, 255),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          FutureBuilder<OrderModel?>(
                            future: _getOrder(widget.orderId),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                OrderModel? order = snapshot.data;
                                if (order == null) {
                                  return Text('Order not found.');
                                }
                                return Text(("Order ${order.status}"),
                                    style: GoogleFonts.beVietnamPro(
                                        textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    )));
                              }
                            },
                          ),
                          SizedBox(
                            width: 130,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25.0,
                            backgroundColor: Color.fromARGB(255, 229, 216, 246),
                            child: Icon(
                              Icons.fastfood_outlined,
                              size: 30,
                              color: Color.fromARGB(255, 151, 71, 255),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text("Order Items",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.beVietnamPro(
                                  textStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ))),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      FutureBuilder<OrderModel?>(
                        future: _getOrder(widget.orderId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            OrderModel? order = snapshot.data;
                            if (order == null) {
                              return Text('Order not found.');
                            }
                            return Text("${order.items.length} Item(s)",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.beVietnamPro(
                                    textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 20,
                                )));
                          }
                        },
                      ),
                      FutureBuilder<OrderModel?>(
                        future: _getOrder(widget.orderId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            OrderModel? order = snapshot.data;
                            if (order == null) {
                              return Text('Order not found.');
                            }

                            List<Map<String, dynamic>> items =
                                (order.items ?? [])
                                    .cast<Map<String, dynamic>>();

                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                Map<String, dynamic> item = items[index];
                                List<String> choices =
                                    List<String>.from(item['choices']);
                                List<int> choiceSelection =
                                    List<int>.from(item['choiceSelection']);

                                double itemTotal = 0.0;

                                for (int i = 0; i < choices.length; i++) {
                                  itemTotal += choiceSelection[i] *
                                      double.parse(item['price'].toString());
                                }

                                int orderedFlavorsCount = choices
                                    .where((choice) =>
                                        choiceSelection[
                                            choices.indexOf(choice)] >
                                        0)
                                    .length;

                                double additionalHeight =
                                    (orderedFlavorsCount >= 3)
                                        ? (orderedFlavorsCount - 2) * 20.0
                                        : 0.0;

                                return Column(
                                  children: [
                                    Container(
                                      width: 342,
                                      height: 100 + additionalHeight,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color:
                                              Color.fromARGB(255, 158, 0, 255),
                                          width: 1.5,
                                        ),
                                        color: Colors.grey[800],
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width: 60,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: Colors.white,
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.network(
                                                  item['imageURL'],
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 20),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  item['title'],
                                                  textAlign: TextAlign.start,
                                                  style:
                                                      GoogleFonts.beVietnamPro(
                                                    textStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 2),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    for (int i = 0;
                                                        i < choices.length;
                                                        i++)
                                                      if (choiceSelection[i] >
                                                          0)
                                                        Text(
                                                          "${choices[i]} x ${choiceSelection[i]}",
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: GoogleFonts
                                                              .beVietnamPro(
                                                            textStyle:
                                                                TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      184,
                                                                      182,
                                                                      182),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ),
                                                  ],
                                                ),
                                                SizedBox(height: 2),
                                                Text(
                                                  "Price: \$${itemTotal.toStringAsFixed(2)}",
                                                  textAlign: TextAlign.start,
                                                  style:
                                                      GoogleFonts.beVietnamPro(
                                                    textStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                  ],
                                );
                              },
                            );
                          }
                        },
                      ),
                      Text(
                        "Shipping Details",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.beVietnamPro(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 342,
                        height: 80,
                        decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                          child: FutureBuilder<OrderModel?>(
                            future: _getOrder(widget.orderId),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                OrderModel? order = snapshot.data;
                                if (order == null) {
                                  return Text('Order not found.');
                                }
                                return Text(
                                  ("Room Number: ${order.room}"),
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.beVietnamPro(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          Text(
                            "Total",
                            textAlign: TextAlign.start,
                            style: GoogleFonts.beVietnamPro(
                              textStyle: TextStyle(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Expanded(
                            // Use Expanded to take up all available space
                            child: FutureBuilder<double?>(
                              future: _calculateTotalPrice(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  double? totalPrice = snapshot.data;
                                  if (totalPrice == null) {
                                    return Text('Total price not available.');
                                  }
                                  return Text(
                                    "\$${totalPrice.toStringAsFixed(2)}",
                                    textAlign: TextAlign
                                        .end, // Align the price to the end of the available space
                                    style: GoogleFonts.beVietnamPro(
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 112, 45, 255),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor: Colors.black,
                                    title: Text(
                                      "Are you sure?",
                                      style: GoogleFonts.beVietnamPro(
                                          color: Colors.white),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          _updateOrderStatus(
                                              widget.orderId, "Delivered");
                                          int count = 0;
                                          Navigator.of(context)
                                              .popUntil((_) => count++ >= 2);
                                        },
                                        style: TextButton.styleFrom(
                                          backgroundColor:
                                              Color.fromARGB(255, 112, 45, 255),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                        ),
                                        child: Container(
                                          child: Text(
                                            "Yes",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                        ),
                                        child: Container(
                                          child: Text(
                                            "No",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Container(
                                width: 125,
                                height: 33,
                                alignment: Alignment.center,
                                child: Text(
                                  "Delivered?",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.beVietnamPro(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor: Colors.black,
                                    title: Text(
                                      "Are you sure?",
                                      style: GoogleFonts.beVietnamPro(
                                          color: Colors.white),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          _updateOrderStatus(
                                              widget.orderId, "Canceled");
                                          int count = 0;
                                          Navigator.of(context)
                                              .popUntil((_) => count++ >= 2);
                                        },
                                        style: TextButton.styleFrom(
                                          backgroundColor:
                                              Color.fromARGB(255, 112, 45, 255),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                        ),
                                        child: Container(
                                          child: Text(
                                            "Yes",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                        ),
                                        child: Container(
                                          child: Text(
                                            "No",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Container(
                                width: 125,
                                height: 33,
                                alignment: Alignment.center,
                                child: Text(
                                  "Canceled?",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.beVietnamPro(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ]))));
  }
}
