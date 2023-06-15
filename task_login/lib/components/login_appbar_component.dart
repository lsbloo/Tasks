import 'package:flutter/material.dart';
import 'package:tasks_core/design-ui/color/colors_resource.dart';

class LoginAppBarComponent extends StatefulWidget {
  Function onClosedClickListener;
  Function onTextClickListener;

  LoginAppBarComponent(
      {required this.onClosedClickListener,
      required this.onTextClickListener,
      Key? key})
      : super(key: key);

  @override
  State<LoginAppBarComponent> createState() => _LoginAppBarComponentState();
}

class _LoginAppBarComponentState extends State<LoginAppBarComponent> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: IconButton(
              color: const Color(ColorResource.WHITE_BABY_SKY),
              onPressed: () {
                widget.onClosedClickListener();
              },
              icon: const Icon(Icons.close)),
        ),
        Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () {
                widget.onTextClickListener();
              },
              child: const Text(
                "Log in",
                style: TextStyle(color: Color(ColorResource.WHITE_BABY_SKY)),
              ),
            ))
      ],
    );
  }
}
