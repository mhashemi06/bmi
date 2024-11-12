import 'package:bmi/constant/colors.dart';
import 'package:flutter/material.dart';

class LeftChartShapeWidget extends StatefulWidget {
  final double width;

  const LeftChartShapeWidget({super.key, required this.width});

  @override
  State<LeftChartShapeWidget> createState() => _LeftChartShapeWidgetState();
}

class _LeftChartShapeWidgetState extends State<LeftChartShapeWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

        Container(
          width: widget.width,
          height: 35,
          decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(topRight: Radius.circular(20))),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          'شاخص مثبت',
          style: TextStyle( color: Colors.green,),
        ),

      ],
    );
  }
}
