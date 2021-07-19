import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddButton extends StatefulWidget {
  Function onPressed;

  Map<Symbol, dynamic>? extraDataForFunction;
  String text;
  IconData icon;
  AddButton(
      {this.extraDataForFunction,
      required this.onPressed,
      required this.text,
      required this.icon});
  @override
  _AddButtonState createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  @override
  Widget build(BuildContext context) {
    widget.extraDataForFunction![#context] = context;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: DottedBorder(
        dashPattern: [2, 5, 10, 20],
        color: Colors.black26,
        strokeWidth: 2,
        borderType: BorderType.RRect,
        radius: Radius.circular(10),
        child: Container(
          width: double.infinity,
          child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              color: Colors.grey[50],
              height: 150,
              onPressed: (){
                Function.apply(
                  widget.onPressed, [], widget.extraDataForFunction);
              },
              
              child: Column(
                children: [
                  Icon(
                    widget.icon,
                    size: 40,
                  ),
                  Text(
                    widget.text,
                    style: TextStyle(fontSize: 20),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
