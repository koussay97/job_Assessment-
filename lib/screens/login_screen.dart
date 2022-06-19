import 'package:flutter/material.dart';
import 'package:mint_it_asses/viewModels/formState_view_model.dart';
import 'package:provider/provider.dart';

import '../core/brand/brand_guid.dart';
import '../core/shared/ui/custom_red_btn.dart';
import '../core/shared/ui/logo_compartment.dart';
import '../core/shared/ui/user_login_info.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ScrollController _scrollController;

  @override
  initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Brand.backgroundColor,
        body: GestureDetector(
          // --> remove soft keyboard when clicking outside.
          onTap: () {
            // enable the login btn when tap outside
            context.read<FormStateViewModel>().setLoginBtnEnabled(true);
            // unfocused current field

            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          onVerticalDragUpdate: (details) {
            // trigger the scroll controller from the gesture detector
            // why ,
            // - because we can not detect on tap from the scroll controller
            // - because we can not dismiss the keyboard from scroll controller
            // - and we would need to scroll the text fields because the keyboard
            // covers the focused areas
            _scrollController.animateTo(-details.delta.dy*15, duration:const  Duration(milliseconds:  300),curve: Curves.easeInOut );
          },
          // --> //
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const NeverScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: deviceWidth,
                minHeight: deviceHeight,
                maxHeight: deviceHeight*1.1,
                maxWidth: deviceWidth,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: deviceWidth * 0.1,
                    vertical: deviceWidth * 0.1,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // logo compartment
                      LogoCompartment(
                        logoSize: deviceWidth * 0.09,
                        // all inner sizes are dependent on logo size
                        deviceWidth: deviceWidth,
                        deviceHeight: deviceHeight,
                      ),

                      // user login_info compartment
                      UserLoginInfoCompartment(
                        tapOutSide: true,
                        fieldsPadding: deviceWidth *
                            0.02, // best value is 0.02*deviceWidth
                      ),

                      // btn compartment

                      CustomRedBtn(
                          btnIcon: Icons.chevron_right,
                          btnName: 'Next',
                          btnWidth: deviceWidth * 0.5,
                          deviceWidth: deviceWidth),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
