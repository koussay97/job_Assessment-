import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:mint_it_asses/viewModels/formState_view_model.dart';
import 'package:provider/provider.dart';

import '../core/brand/brand_guid.dart';
import '../core/shared/ui/app_bar_content_widget_main_screen.dart';
import '../core/shared/ui/circular_clipper.dart';
import '../core/shared/ui/driver_list_content.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> listBlockAnimation;
  late AnimationController _animationController;
  late ScrollController scrollController;
  late bool cardinRange;

  @override
  initState() {
    scrollController = ScrollController()
      ..addListener(scrollControllerListener);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..forward();
    listBlockAnimation = Tween<double>(begin: 1, end: 0.15).animate(
        CurvedAnimation(
            parent: _animationController, curve: Curves.elasticInOut));

    super.initState();
  }

  void scrollControllerListener() {}

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Color(0xffB61E1E),
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.dark, // For iOS (dark icons)
        ),
      ),
      body: SafeArea(
        child: Container(
          height: deviceHight,
          width: deviceWidth,
          decoration: BoxDecoration(
            gradient: Brand.customRedGradient,
          ),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: deviceWidth * 0.1,
                ),

                // first compartment

                child: AppBarContent(
                  blockSize: deviceWidth,
                  // edit this to edit the Avatar bloc "ideal value is deviceWidth"
                  firstTitle: 'Good morning',
                  secondTitle:
                      '${context.read<FormStateViewModel>().firstName} '
                      '${context.read<FormStateViewModel>().lastName}',
                ),
              ),

              // second compartment

              AnimatedBuilder(
                animation: listBlockAnimation,
                builder: (context, child) {
                  return Positioned(
                    right: 0,
                    bottom: -2 * listBlockAnimation.value * deviceWidth,
                    child: Container(
                      width: deviceWidth,
                      height: deviceWidth * 1.85,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.05),
                            blurRadius: 12,
                            spreadRadius: 2,
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(deviceWidth * 0.06),
                            topRight: Radius.circular(deviceWidth * 0.06)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: deviceWidth * 0.05),
                        child: Column(
                          children: [
                            // big red title

                            SizedBox(
                              height: deviceWidth * 0.08,
                            ),
                            Text(
                              'Top 10 ranking 2021',
                              style: TextStyle(
                                fontFamily: Brand.h1Font,
                                fontWeight: FontWeight.w700,
                                color: Brand.lightRed,
                                fontSize: deviceWidth * 0.055,
                              ),
                            ),
                            SizedBox(
                              height: deviceWidth * 0.08,
                            ),

                            // list of cards

                            Expanded(
                              child: SingleChildScrollView(
                                controller: scrollController,
                                physics: const AlwaysScrollableScrollPhysics(
                                    parent: BouncingScrollPhysics()),
                                child: Column(
                                  children: Brand.drivers.map((e) {
                                    return Column(
                                      children: [
                                        Container(
                                          width: deviceWidth,
                                          height: deviceWidth * 0.232,
                                          decoration: BoxDecoration(
                                              boxShadow: [Brand.customShadow],
                                              color: Colors.white),
                                          child: CardItemContent(
                                              deviceHeight: deviceHight,
                                              revealAnimation: () {},
                                              listItemDriverName: e['name'],
                                              listItemInnerPadding:
                                                  deviceWidth * 0.06,
                                              listItemNumber: e['rank'],
                                              deviceWidth: deviceWidth,
                                              listItemAvatar: CircularClipper(
                                                circleSize: deviceWidth,
                                                assetImage:
                                                    Brand.getDriverAvatar(
                                                        e['name']),
                                              ),
                                              listItemDriverCompany:
                                                  e['company_name']),
                                        ),
                                        SizedBox(
                                          height: deviceWidth * 0.07,
                                        ),
                                      ],
                                    );
                                  }).toList(growable: true),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: deviceWidth * 0.3,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}






