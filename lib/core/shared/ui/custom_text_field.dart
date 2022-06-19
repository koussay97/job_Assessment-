import 'package:flutter/material.dart';
import 'package:mint_it_asses/viewModels/formState_view_model.dart';
import 'package:provider/provider.dart';

import '../../brand/brand_guid.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final FocusNode focusNode;
  final TextEditingController controller;
  final VoidCallback validateField;
  final Color borderColor;

  const CustomTextField({
    Key? key,
    required this.borderColor,
    required this.hintText,
    required this.validateField,
    required this.focusNode,
    required this.controller,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool displayCloseBtn;

  @override
  initState() {
    displayCloseBtn = false;
    widget.focusNode.addListener(validateOnLostFocus);
    widget.controller.addListener(displayCloseBtnListener);
    super.initState();
  }
  void displayCloseBtnListener(){
    setState(() {
      displayCloseBtn = widget.controller.text.isNotEmpty;
    });
  }
  void validateOnLostFocus(){
    if (!widget.focusNode.hasPrimaryFocus) {
      widget.validateField.call();
      //debugPrint(widget.controller.text);
    }
  }
  @override
  dispose() {
    widget.focusNode.removeListener(validateOnLostFocus);
    widget.controller.removeListener(displayCloseBtnListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return TextField(
      onEditingComplete: (){
        widget.validateField.call();
        widget.focusNode.unfocus();
        widget.controller.removeListener(() { });
      },
      focusNode: widget.focusNode,
      textInputAction: TextInputAction.done,
      controller: widget.controller,
      onSubmitted: (value) {
        widget.validateField.call();
        widget.focusNode.unfocus();
        widget.controller.removeListener(() { });
        context.read<FormStateViewModel>().setLoginBtnEnabled(true);
      },
      onChanged: (val){
        context.read<FormStateViewModel>().setLoginBtnEnabled(false);
      },
      style: TextStyle(
        fontFamily: Brand.h3Font,
        fontWeight: FontWeight.w500,
        fontSize: deviceWidth * 0.04,
        color: Brand.customBlack,
      ),
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: displayCloseBtn
              ? const Icon(
            Icons.close,
          )
              : Container(
            width: 0,
          ),
          onPressed: () {
            setState(() {
              displayCloseBtn = !displayCloseBtn;
            });
            widget.controller.clear();
            widget.validateField.call();
          },
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontFamily: Brand.h3Font,
          fontWeight: FontWeight.w400,
          fontSize: deviceWidth * 0.04,
          color: Brand.customGrey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(deviceWidth * 0.02),
          borderSide: BorderSide(color: widget.borderColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(deviceWidth * 0.02),
          borderSide: BorderSide(color: Brand.customGrey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(deviceWidth * 0.02),
          borderSide: BorderSide(color: Brand.validGreen, width: 1),
        ),
        contentPadding: EdgeInsets.only(left: deviceWidth * 0.05),
      ),
    );
  }
}