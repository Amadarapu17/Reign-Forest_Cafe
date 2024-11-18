import 'package:flutter/material.dart';
import 'package:nhss_reign_forest_cafe/logic/order/order_bloc.dart';
import 'package:nhss_reign_forest_cafe/logic/order/order_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nhss_reign_forest_cafe/data/models/Order.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nhss_reign_forest_cafe/presentation/order/order_card.dart';
import 'package:nhss_reign_forest_cafe/presentation/order/specific_order_screen.dart';

class OrderSearchPageBuild extends StatefulWidget {
  const OrderSearchPageBuild({super.key});

  @override
  State<OrderSearchPageBuild> createState() => _OrderSearchPageBuildState();
}

class _OrderSearchPageBuildState extends State<OrderSearchPageBuild> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderBloc, OrderState>(
      listener: (context, state) {},
      builder: (context, state) {
        print(state);
        if (state is OrderObtained) {
          List<OrderModel> orders = state.orders;

          List<OrderModel> pendingOrders =
              orders.where((order) => order.status == "Pending").toList();

          return OrderSearchPage(orders: pendingOrders);
        }

        if (state is OrderFailure) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class OrderSearchPage extends StatefulWidget {
  final List<OrderModel> orders;
  const OrderSearchPage({super.key, required this.orders});

  @override
  State<OrderSearchPage> createState() => _OrderSearchPageState();
}

class _OrderSearchPageState extends State<OrderSearchPage> {
  List<OrderModel> theOrders = [];

  @override
  void initState() {
    super.initState();
    theOrders = widget.orders;
  }

  TextEditingController searchController = new TextEditingController();

  String selectedFilter = "Room #";

  List<OrderModel> getFilteredOrders(
      List<OrderModel> orders, String search, String filterBy) {
    List<OrderModel> filteredOrderModels = [];

    String searchTerm = search.toLowerCase();

    for (OrderModel order in orders) {
      String fieldValue = '';

      if (filterBy == "Room #") {
        fieldValue = order.room.toLowerCase();
      } else if (filterBy == "Name") {
        fieldValue = order.name.toLowerCase();
      }

      if (fieldValue.startsWith(searchTerm)) {
        filteredOrderModels.add(order);
      }
    }

    return filteredOrderModels;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context);

    //final statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.only(top: 60, left: 24, right: 24),
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Search",
                    style: GoogleFonts.beVietnamPro(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
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
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.home,
                          size: 20,
                        ),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                height: 53,
                width: 345,
                decoration: BoxDecoration(
                    color: const Color(0xffF0F0F0),
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                      // hintText: widget.hintText,
                      hintStyle: GoogleFonts.beVietnamPro(
                          fontSize: 16,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w400),
                      contentPadding: EdgeInsets.only(left: 20),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedFilter = "Room #";
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedFilter == "Room #"
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
                            "Room #",
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
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedFilter = "Name";
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedFilter == "Name"
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
                            "Name",
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
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        theOrders = getFilteredOrders(widget.orders,
                            searchController.text, selectedFilter);
                      });
                    },
                    child: Container(
                      height: 33,
                      width: 80,
                      color: Color.fromARGB(255, 151, 71, 255),
                      child: Center(
                        child: Text(
                          "Filter",
                          style: GoogleFonts.beVietnamPro(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 2,
                width: 300,
                color: Colors.white,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Pending Orders",
                    style: GoogleFonts.beVietnamPro(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      theOrders.length,
                      (index) => Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SpecificOrder(
                                      orderId: theOrders[index].orderID),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[800],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: OrderCard(order: theOrders[index]),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
