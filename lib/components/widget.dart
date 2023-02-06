import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget pictureSkeleton(double width, double height) {
  return Shimmer.fromColors(
    baseColor: Color(0xffd6d8da),
    highlightColor: Color(0xffF9F6EE),
    child: Container(
      width: width,
      height: height,
      color: Colors.grey,
    ),
  );
}
