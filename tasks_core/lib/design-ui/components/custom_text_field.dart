import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTaskTextField extends StatefulWidget {
  TextInputType textInputType;
  String hintText;
  Icon? suffixIcon;
  bool? isPassword;
  int maxLengthInput;
  Function onMaxLengthInputExceed;

  Function(String) onTextChanged;

  CustomTaskTextField(
      {required this.onTextChanged,
      required this.hintText,
      required this.textInputType,
      required this.maxLengthInput,
      required this.onMaxLengthInputExceed,
      this.isPassword,
      this.suffixIcon,
      Key? key})
      : super(key: key);

  @override
  State<CustomTaskTextField> createState() => _CustomTaskTextFieldState();
}

class _CustomTaskTextFieldState extends State<CustomTaskTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 350,
        child: Card(
          semanticContainer: true,
          elevation: 8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(18.0)),
          ),
          child: SizedBox(
            child: Material(
              color: Colors.transparent,
              child: TextField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(widget.maxLengthInput)
                ],
                obscureText: widget.isPassword == true ? true : false,
                maxLines: 1,
                onChanged: (text) {
                  if (text.length >= widget.maxLengthInput) {
                    widget.onMaxLengthInputExceed();
                  } else {
                    widget.onTextChanged(text);
                    _controller.text = text;
                  }
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintStyle: const TextStyle(fontSize: 18),
                  hintText: widget.hintText,
                  suffixIcon: widget.suffixIcon,
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18.0)),
                    borderSide: BorderSide(width: 2, color: Colors.greenAccent),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18.0)),
                    borderSide: BorderSide(width: 2, color: Colors.black),
                  ),
                  contentPadding: const EdgeInsets.all(14),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
