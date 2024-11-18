import 'package:flutter/material.dart';
import 'package:nhss_reign_forest_cafe/data/models/Item.dart';

class CartItem extends StatefulWidget {
  final Item item;
  const CartItem({super.key, required this.item});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Color.fromARGB(255, 55, 54, 54),
      ),
      height: 150,
      width: 375,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.item.imageURL,
                    scale: 2.0,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Text(
                      widget.item.title,
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 5),
                    Container(
                      height: 90,
                      width: 150,
                      child: ListView.builder(
                          itemCount: widget.item.choices.length,
                          itemBuilder: (context, index) {
                            return Text(
                              "${widget.item.choices[index]}: ${widget.item.choiceSelections[index]}",
                              style: TextStyle(color: Colors.white),
                            );
                          }),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Positioned(
          //   bottom: 0,
          //   right: 0,
          //   child: TextButton(
          //     onPressed: () {
          //       BlocProvider.of<ItemBloc>(context).add(RemoveItemFromCart());
          //       Navigator.pop(context);
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => const CartRedirect()),
          //       );
          //     },
          //     child: Text(
          //       "Remove",
          //       style: TextStyle(
          //         color: Colors.red,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
