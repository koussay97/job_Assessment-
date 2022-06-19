import 'package:flutter/material.dart';
import 'package:mint_it_asses/viewModels/formState_view_model.dart';
import 'package:provider/provider.dart';

import '../../brand/brand_guid.dart';


import '../../utils/fuction/input_validation.dart';
import 'custom_text_field.dart';

class UserLoginInfoCompartment extends StatefulWidget {
  bool tapOutSide;
  double fieldsPadding;

  UserLoginInfoCompartment({
    Key? key,
    required this.tapOutSide,
    required this.fieldsPadding,
  }) : super(key: key);

  @override
  State<UserLoginInfoCompartment> createState() =>
      _UserLoginInfoCompartmentState();
}

class _UserLoginInfoCompartmentState extends State<UserLoginInfoCompartment> {
  late FocusNode firstNameFocusNode;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late FocusNode lastNameFocusNode;

  @override
  initState() {
    firstNameFocusNode = FocusNode(canRequestFocus: true);
    lastNameFocusNode = FocusNode(canRequestFocus: true);
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      validateInitialFields.call();
    });
  }

  void validateInitialFields() {
    var validation1 = CustomValidator.isNameValid(firstNameController.text);
    var validation2 = CustomValidator.isNameValid(lastNameController.text);
    Provider.of<FormStateViewModel>(context, listen: false)
        .setFirstNameResult(validationResult: validation1);
    Provider.of<FormStateViewModel>(context, listen: false)
        .setLastNameResult(validationResult: validation2);
  }

  @override
  dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    firstNameFocusNode.dispose();
    lastNameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    final Color firstNameBorderColor =
        context.select((FormStateViewModel form) => form.firstNameErrorColor);
    final Color lastNameBorderColor =
        context.select((FormStateViewModel form) => form.lastNameErrorColor);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'First Name',
          style: TextStyle(
            fontFamily: Brand.h3Font,
            fontWeight: FontWeight.w400,
            fontSize: deviceWidth * 0.04,
            color: Brand.customBlack,
          ),
        ),
        SizedBox(
          height: deviceWidth * 0.02,
        ),
        CustomTextField(
          validateField: () {
            // check for field validation
            final validation =
                CustomValidator.isNameValid(firstNameController.text);
            // set the name field in provider
            if (validation['result'] as bool) {
              context
                  .read<FormStateViewModel>()
                  .setFirstName(firstNameController.text);
            }

            // set the validation result in provider for routing control in the btn

            context
                .read<FormStateViewModel>()
                .setFirstNameResult(validationResult: validation);
          },
          borderColor: firstNameBorderColor,
          focusNode: firstNameFocusNode,
          hintText: 'Type in your first name',
          controller: firstNameController,
        ),
        SizedBox(
          height: widget.fieldsPadding,
        ),
        Text(
          'Last Name',
          style: TextStyle(
            fontFamily: Brand.h3Font,
            fontWeight: FontWeight.w400,
            fontSize: deviceWidth * 0.04,
            color: Brand.customBlack,
          ),
        ),
        SizedBox(
          height: deviceWidth * 0.02,
        ),
        CustomTextField(
          validateField: () {
            // check for field validation
            final validation =
                CustomValidator.isNameValid(lastNameController.text);
            // set the name field in provider
            if (validation['result'] as bool) {
              context
                  .read<FormStateViewModel>()
                  .setLastName(lastNameController.text);
            }
            // set the validation result in provider for routing control in the btn
            context
                .read<FormStateViewModel>()
                .setLastNameResult(validationResult: validation);
          },
          borderColor: lastNameBorderColor,
          focusNode: lastNameFocusNode,
          hintText: 'Type in your last name',
          controller: lastNameController,
        ),
      ],
    );
  }
}
