import 'package:flutter/material.dart';
import 'package:nhss_reign_forest_cafe/data/models/Item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nhss_reign_forest_cafe/logic/item/item_bloc.dart';
import 'package:nhss_reign_forest_cafe/logic/item/item_event.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nhss_reign_forest_cafe/presentation/store/widgets/choice_selection.dart';
import 'package:another_flushbar/flushbar.dart';

class ItemInfo extends StatefulWidget {
  final Item item;
  const ItemInfo({Key? key, required this.item});

  @override
  State<ItemInfo> createState() => _ItemInfoState();
}

class _ItemInfoState extends State<ItemInfo> {
  double total = 0;

  double getPrice() {
    for (int choices in widget.item.choiceSelections) {
      total += choices;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 70,
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
            Padding(
              padding: const EdgeInsets.only(
                  left: 24.0, top: 20, right: 24, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Item",
                    style: GoogleFonts.beVietnamPro(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Image.network(
                  widget.item.imageURL,
                  width: 200,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.item.title,
              style: GoogleFonts.beVietnamPro(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Choices:",
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 225,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.item.choices.length,
                itemBuilder: (context, index) {
                  return ChoiceSelection(
                    count: 0,
                    index: index,
                    item: widget.item,
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            MaterialButton(
              onPressed: () {
                BlocProvider.of<ItemBloc>(context)
                    .add(AddToCart(item: widget.item));
                Navigator.pop(context);
                Flushbar(
                  title: "Item added",
                  backgroundColor: Colors.green,
                  flushbarPosition: FlushbarPosition.TOP,
                  message: "Item Successfully Added to Cart",
                  icon: Icon(
                    Icons.close,
                    size: 28.0,
                    color: Colors.white,
                  ),
                  duration: Duration(seconds: 2),
                )..show(context);
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
                    "Add to Cart",
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
    );
  }
}
