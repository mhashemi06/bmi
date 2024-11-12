import 'package:bmi/constant/colors.dart';
import 'package:flutter/material.dart';

class RightChartShapeWidget extends StatefulWidget {
  final double width;

  const RightChartShapeWidget({super.key, required this.width});

  @override
  State<RightChartShapeWidget> createState() => _RightChartShapeWidgetState();
}

class _RightChartShapeWidgetState extends State<RightChartShapeWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,

      children: [
        Text(
          'شاخص منفی',
          style: TextStyle(color: orangeColor),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          width: widget.width,
          height: 35,
          decoration: BoxDecoration(
              color: orangeColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20))),
        ),
      ],
    );
  }
}
