import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum InputType { Regular, Password }

class InputField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final InputType typeOfInput;
  final Icon icon;
  const InputField(
      {Key? key,
      required this.label,
      this.hintText = "",
      required this.controller,
      required this.typeOfInput,
      this.keyboardType = TextInputType.text,
      required this.icon})
      : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool _passwordVisible = true;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            widget.label,
            style: GoogleFonts.beVietnamPro(
                fontSize: 16,
                color: Color.fromARGB(255, 158, 158, 158),
                fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          height: 53,
          width: 345,
          decoration: BoxDecoration(
              color: const Color(0xffF0F0F0),
              borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                prefixIcon: widget.icon,
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
          height: 20,
        ),
      ],
    );
  }
}
