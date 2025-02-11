import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double fieldWidth = width / 8;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(6, (index) {
            return Expanded(
              child: Container(
                width: fieldWidth,
                height: 60,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.textFBack,
                ),
                child: TextField(
                  controller: controllers[index],
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10.0),
                    hintText: '0',
                    hintStyle: AppTextStyles.getOpenSansGoogleFont(
                        14, AppColors.whiteColor.withOpacity(0.5), false),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    _updateOTPController();
                    if (value.isNotEmpty && index < controllers.length - 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
