import 'package:flutter/material.dart';

import '../../brand/brand_guid.dart';

class LogoCompartment extends StatelessWidget {
  final double deviceHeight;
  final double deviceWidth;
  final double logoSize;

  const LogoCompartment(
      {Key? key,
        required this.logoSize,
        required this.deviceWidth,
        required this.deviceHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:logoSize>0.2*deviceWidth?deviceWidth*0.6 :logoSize*4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(
                maxHeight: deviceWidth * 0.2
            ),
            height: logoSize,
            child: Brand.fullRedLogo,
          ),
          Container(
              constraints: BoxConstraints(maxHeight: deviceWidth * 0.2),
              height: logoSize),
          Center(
            child: Text(
              'Let’s Get Familiar',
              style: TextStyle(
                fontFamily: Brand.h1Font,
                fontWeight: FontWeight.w700,
                fontSize:logoSize>0.2*deviceWidth?deviceWidth * 0.07: logoSize*0.777,//,
                color: Brand.customBlack,
              ),
            ),
          ),
          Center(
            child:
            Text(
              'Introduce Yourself',
              style: TextStyle(
                fontFamily: Brand.h3Font,
                fontWeight: FontWeight.w400,
                fontSize: logoSize>0.2*deviceWidth?deviceWidth * 0.04:logoSize*0.444,
                color: Brand.customDarkBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}