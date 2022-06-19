import 'package:flutter/cupertino.dart';

import '../../brand/brand_guid.dart';

class CardItemContent extends StatelessWidget {
  final double deviceWidth;
  final double deviceHeight;
  final Widget listItemAvatar;
  final String listItemNumber;
  final String listItemDriverName;
  final String listItemDriverCompany;
  final double listItemInnerPadding;
  final VoidCallback revealAnimation;

  const CardItemContent({
    Key? key,
    required this.deviceWidth,
    required this.deviceHeight,
    required this.listItemAvatar,
    required this.listItemDriverCompany,
    required this.listItemDriverName,
    required this.listItemInnerPadding,
    required this.listItemNumber,
    required this.revealAnimation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // reveal animation purpose - not yet ready
    /*final RenderBox? renderListElement =
        context.findRenderObject() as RenderBox?;
    final currentItemPosition =
        renderListElement?.localToGlobal(Offset.zero).dy ?? 0;
    final widgetPercentageShown =
        (currentItemPosition / deviceHeight).clamp(0.0, 1.0);
    if (widgetPercentageShown == 1) {
      debugPrint('fully Shown ${listItemNumber}');
    } else {
      debugPrint('item Shown by ${widgetPercentageShown}---');
    }*/
    /// reveal animation purpose not yet ready
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: deviceWidth * 0.08, vertical: deviceWidth * 0.045),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            listItemNumber,
            style: TextStyle(
              fontFamily: Brand.h1Font,
              fontWeight: FontWeight.w700,
              color: Brand.lightRed,
              fontSize: deviceWidth * 0.045,
            ),
          ),
          SizedBox(
            width: listItemInnerPadding, //deviceWidth * 0.08
          ),
          listItemAvatar,
          SizedBox(
            width: listItemInnerPadding, //deviceWidth * 0.08,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                listItemDriverName,
                style: TextStyle(
                  fontFamily: Brand.h2Font,
                  fontWeight: FontWeight.w500,
                  color: Brand.customDarkBlue,
                  fontSize: deviceWidth * 0.041,
                ),
              ),
              SizedBox(
                height: deviceWidth * 0.02,
              ),
              Text(
                listItemDriverCompany,
                style: TextStyle(
                  fontFamily: Brand.h3Font,
                  fontWeight: FontWeight.w400,
                  color: Brand.customDarkBlue,
                  fontSize: deviceWidth * 0.035,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}