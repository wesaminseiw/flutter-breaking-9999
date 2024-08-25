import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

Widget myCircularProgressIndicator({
  required bool isCenter,
  required Color color,
  double stroke = 1.5,
  double height = 30,
  double width = 30,
}) =>
    ConditionalBuilder(
      condition: isCenter == true,
      builder: (context) => Center(
        child: SizedBox(
          width: width,
          height: height,
          child: CircularProgressIndicator(
            strokeWidth: stroke,
            color: color,
          ),
        ),
      ),
      fallback: (context) => SizedBox(
        width: width,
        height: height,
        child: CircularProgressIndicator(
          strokeWidth: stroke,
          color: color,
        ),
      ),
    );
