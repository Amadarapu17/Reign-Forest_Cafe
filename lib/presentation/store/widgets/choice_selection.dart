import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nhss_reign_forest_cafe/data/models/Item.dart';

class ChoiceSelection extends StatefulWidget {
  final int count;
  final int index;
  final Item item;

  const ChoiceSelection(
      {super.key,
      required this.count,
      required this.index,
      required this.item});

  @override
  State<ChoiceSelection> createState() => _ChoiceSelectionState();
}

class _ChoiceSelectionState extends State<ChoiceSelection> {
  int newCount = 0;

  @override
  Widget build(BuildContext context) {
    setState(() {
      widget.item.choiceSelections[widget.index] = newCount;
    });
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  widget.item.choices[widget.index],
                  style: GoogleFonts.beVietnamPro(
                      fontSize: 20, color: Colors.white),
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (newCount > 0) {
                          newCount--;
                        }

                        widget.item.choiceSelections[widget.index] = newCount;
                      });
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        color: Color(0xff9747FF),
                      ),
                      child: Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.grey,
                      ),
                      child: Center(
                        child: Text(newCount.toString(),
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 23,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        newCount++;

                        widget.item.choiceSelections[widget.index] = newCount;
                      });
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        color: Color(0xff9747FF),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 5,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
