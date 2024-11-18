import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nhss_reign_forest_cafe/data/models/Item.dart';
import 'package:nhss_reign_forest_cafe/logic/item/item_bloc.dart';
import 'package:nhss_reign_forest_cafe/logic/item/item_state.dart';
import 'package:nhss_reign_forest_cafe/presentation/redirects.dart';
import 'package:nhss_reign_forest_cafe/presentation/store/widgets/store_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreBuild extends StatefulWidget {
  const StoreBuild({Key? key});

  @override
  State<StoreBuild> createState() => _StoreBuildState();
}

class _StoreBuildState extends State<StoreBuild> {
  //bool isLoading = true;

  @override
  void initState() {
    super.initState();

    // Future.delayed(Duration(seconds: 2), () {
    //   setState(() {
    //     isLoading = false;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ItemBloc, ItemState>(
      listener: (context, state) {},
      builder: (context, state) {
        print(state);

        if (state is ItemsObtained) {
          List<Item> items = state.items;
          print(state.items);
          return Store(items: items);
        }

        if (state is ItemFailure) {
          return customLoadingScreen();
        }

        return Center(child: customLoadingScreen());
      },
    );
  }

  Widget customLoadingScreen() {
    return Center(
        child: Container(
      width: double.infinity,
      height: double.infinity,
      //color: Color(0xff9747FF),
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/purple.png',
              width: 150,
              height: 150,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Loading",
                style: GoogleFonts.beVietnamPro(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              CircularProgressIndicator()
            ],
          ),
        ],
      ),
    ));
  }

  // Widget customStart() {
  //   return Center(
  //     child: Container(
  //       width: double.infinity,
  //       height: double.infinity,
  //       color: Colors.black,
  //       child: TweenAnimationBuilder(
  //         duration: Duration(seconds: 0),
  //         tween: Tween<double>(begin: 0.2, end: 1.0),
  //         curve: Curves.easeInOut,
  //         builder: (context, value, child) {
  //           return Opacity(
  //             opacity: value,
  //             child: child,
  //           );
  //         },
  //         child: Center(
  //           child: Image.asset(
  //             'assets/purple.png',
  //             width: 150,
  //             height: 150,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

class Store extends StatefulWidget {
  final List<Item> items;
  const Store({Key? key, required this.items});

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  bool showFood = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          color: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Color(0xff9747FF),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CartRedirect(),
                            ),
                          );
                        },
                        icon: Icon(Icons.shopping_bag_outlined),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Text(
                  "Hello, welcome to",
                  style: GoogleFonts.beVietnamPro(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Text(
                  "The Reign Forest Cafe",
                  style: GoogleFonts.beVietnamPro(
                    color: const Color(0xff9747FF),
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                ),
              ),
              const SizedBox(
                height: 31,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Text(
                  "Item of the Week!",
                  style: GoogleFonts.beVietnamPro(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              MediaQuery.removePadding(
                context: context,
                removeTop: true,
                removeBottom: true,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return StoreItem(
                      item: widget.items[
                          index], //change this to chnge item just find index in friebase
                    );
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Text(
                  "Menu",
                  style: GoogleFonts.beVietnamPro(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          showFood = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: showFood == true
                            ? Color.fromARGB(255, 151, 71, 255)
                            : Colors.grey[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.fastfood,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Food",
                              style: GoogleFonts.beVietnamPro(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          showFood = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: showFood == false
                            ? Color.fromARGB(255, 151, 71, 255)
                            : Colors.grey[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.local_cafe,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Drinks",
                              style: GoogleFonts.beVietnamPro(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              if (showFood)
                MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: Column(
                    children: [
                      GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 11,
                        itemBuilder: (context, index) {
                          return StoreItem(
                            item: widget.items[index],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              if (!showFood)
                MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: Column(
                    children: [
                      GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 14,
                        itemBuilder: (context, index) {
                          return StoreItem(
                            item: widget.items[index + 11],
                          );
                        },
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
