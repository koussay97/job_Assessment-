import 'package:flutter/material.dart';
import 'package:mint_it_asses/core/settings/app_settings.dart';
import 'package:provider/provider.dart';

import '../../../viewModels/formState_view_model.dart';
import '../../brand/brand_guid.dart';
import 'custom_snack_bar.dart';

class CustomRedBtn extends StatelessWidget {
  final double deviceWidth;
  final double btnWidth;
  final String btnName;
  final IconData btnIcon;
  const CustomRedBtn({Key? key,
    required this.btnName,
    required this.btnIcon,
    required this.deviceWidth,required this.btnWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FormStateViewModel>(
        builder: (context,FormStateViewModel view,child) {
          return GestureDetector(

            onTap:view.loginBtnEnabled?(){
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }

              if (view.isFormValid()) {
                // can route
                context.read<FormStateViewModel>().setRouteToMain(true);
                context.read<FormStateViewModel>().setShowSnackBar(false);
                Navigator.pushNamed(context, AppSettings.mainRouteName);
              } else {
                // show snack bar
                context.read<FormStateViewModel>().setRouteToMain(false);
                context.read<FormStateViewModel>().setShowSnackBar(true);
                if(!view.firstNameResult["result"]){
                  ScaffoldMessenger.of(context).showSnackBar(
                      customSnackBar(deviceWidth: deviceWidth,context: context,errorMessage: 'First Name: '+view.firstNameResult["message"].toString(),)
                  );
                }else if(!view.lastNameResult["result"]){
                  ScaffoldMessenger.of(context).showSnackBar(
                      customSnackBar(deviceWidth: deviceWidth,context: context,errorMessage: 'Last Name: '+view.lastNameResult["message"].toString(),)
                  );
                }
              }
            }:null,
            child: Container(
              width: btnWidth,// deviceWidth*0.5 is the best value
              padding: EdgeInsets.symmetric(vertical: deviceWidth*0.03,horizontal: deviceWidth*0.03),
              decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.all(Radius.circular(deviceWidth * 0.02)),
                  gradient: Brand.customRedGradient),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    btnName,//'Next'
                    style: TextStyle(
                      fontFamily: Brand.h2Font,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: deviceWidth * 0.05,
                    ),
                  ),
                  SizedBox(width: deviceWidth * 0.02,),
                   Icon(
                    btnIcon,// Icons.chevron_right
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}
