import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:q_bounce/constant/app_color.dart';
import 'package:q_bounce/constant/app_text_style.dart';

class OTPField extends StatefulWidget {
  final TextEditingController controller;

  const OTPField({Key? key, required this.controller}) : super(key: key);

  @override
  _OTPFieldState createState() => _OTPFieldState();
}

class _OTPFieldState extends State<OTPField> {
  late List<TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(6, (_) => TextEditingController());
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _updateOTPController() {
    String otpValue = controllers.map((c) => c.text).join();
    widget.controller.text = otpValue;
  }

  void _handleChange(String value, int index) {
    // Update OTP controller when text changes
    _updateOTPController();
    if (value.isNotEmpty && index < controllers.length - 1) {
      // Move to next field when a character is typed
      FocusScope.of(context).nextFocus();
    } else if (value.isEmpty && index > 0) {
      // Move to previous field when text is deleted
      FocusScope.of(context).previousFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double fieldWidth = width / 8;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 25),

        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: List.generate(6, (index) {
        //     return Expanded(
        //       child: Container(
        //         width: fieldWidth,
        //         height: 60,
        //         margin: const EdgeInsets.symmetric(horizontal: 5),
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(10),
        //           color: AppColors.textFBack,
        //         ),
        //         child: TextField(
        //           controller: controllers[index],
        //           keyboardType: TextInputType.number,
        //           style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        //           textAlign: TextAlign.center,
        //           maxLength: 1, // Ensures only one character is entered
        //           inputFormatters: [
        //             FilteringTextInputFormatter.digitsOnly, // Ensures only digits are entered
        //           ],
        //           decoration: InputDecoration(
        //             counterText: "", // Hides the counter
        //             contentPadding: const EdgeInsets.all(10.0),
        //             hintText: '0',
        //             hintStyle: AppTextStyles.getOpenSansGoogleFont(
        //                 14, AppColors.whiteColor.withOpacity(0.5), false),
        //             border: InputBorder.none,
        //           ),
        //           onChanged: (value) => _handleChange(value, index),
        //         ),
        //       ),
        //     );
        //   }),
        // ),
    PinCodeTextField(
    appContext: context,
    pastedTextStyle: TextStyle(
    color: Colors.green.shade600,
    fontWeight: FontWeight.bold,
    ),
    length: 6,
    obscureText: false,

    animationType: AnimationType.fade,
    hintCharacter: 'O',
    hintStyle:  AppTextStyles.getOpenSansGoogleFont(
        14, AppColors.whiteColor.withOpacity(0.5), false),
    textStyle: TextStyle(
    color: AppColors.whiteColor.withOpacity(0.5),
    fontSize: 20,
    fontWeight: FontWeight.w700),

    pinTheme: PinTheme(
    shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(10), // Add border radius
    fieldHeight: 60,
    fieldWidth: 50,
    inactiveFillColor: AppColors.textFBack,
    inactiveColor: AppColors.textFBack,
    selectedColor: AppColors.textFBack,
    activeFillColor: AppColors.textFBack,
    activeColor: AppColors.textFBack,
    selectedFillColor: AppColors.textFBack,
    activeBorderWidth: 1,
    inactiveBorderWidth: 1
    ),
    cursorColor: Colors.black,
    animationDuration: const Duration(milliseconds: 300),
    enableActiveFill: true,
    controller: widget.controller,
    keyboardType: TextInputType.number,
    animationCurve: Curves.easeInOutCubic,

    onChanged: (value) {
    },
    ),


    ],
    );
  }
}
