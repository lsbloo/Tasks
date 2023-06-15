import 'package:flutter/material.dart';

import '../color/colors_resource.dart';

class AddTaskHeaderComponent extends StatefulWidget {
  final Function() onCLick;

  const AddTaskHeaderComponent({super.key, required this.onCLick});

  @override
  State<AddTaskHeaderComponent> createState() => _AddTaskHeaderComponentState();
}

class _AddTaskHeaderComponentState extends State<AddTaskHeaderComponent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 65,
        width: MediaQuery.of(context).size.width,
        child: Container(
          color: Colors.transparent,
          margin: const EdgeInsets.fromLTRB(2, 8, 2, 8),
          child: GestureDetector(
            onTap: () => {widget.onCLick()},
            child: const Card(
                elevation: 10,
                color: Color(ColorResource.BLUE_BABY_SKY),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(3.0)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: Opacity(
                    opacity: 0.6,
                    child: Row(children: [
                      Icon(Icons.add, size: 28),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        "Adicionar Tarefa...",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      )
                    ]),
                  ),
                )),
          ),
        ));
  }
}
