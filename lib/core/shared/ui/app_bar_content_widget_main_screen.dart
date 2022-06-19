import 'package:flutter/material.dart';

import '../../brand/brand_guid.dart';
import 'circular_clipper.dart';

class AppBarContent extends StatelessWidget {
  final double blockSize;
  final String firstTitle;
  final String secondTitle;

  const AppBarContent({
    Key? key,
    required this.blockSize,
    required this.firstTitle,
    required this.secondTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: blockSize * 0.3,
      width: blockSize,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircularClipper(
            circleSize: blockSize,
            assetImage: Brand.avatar,
          ),
          SizedBox(
            width: blockSize * 0.1,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  firstTitle, //Good morning
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: blockSize * 0.055,
                    color: Colors.white,
                    fontFamily: Brand.h1Font,
                  ),
                ),
                SizedBox(
                  height: blockSize * 0.01,
                ),
                Text(
                  secondTitle, // Jonah Flinn
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: blockSize * 0.038,
                    color: Colors.white,
                    fontFamily: Brand.h3Font,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: blockSize * 0.01,
          )
        ],
      ),
    );
  }
}