import 'package:flutter/material.dart';
import 'package:q_bounce/constant/app_color.dart';

class OTPField extends StatefulWidget {
  const OTPField({Key? key}) : super(key: key);

  @override
  _OTPFieldState createState() => _OTPFieldState();
}

class _OTPFieldState extends State<OTPField> {
  List<TextEditingController> controllers = List.generate(6, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double fieldWidth = width / 8;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // OTP input fields
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(6, (index) {
            return Expanded(
              child: Container(
                width: fieldWidth,  // Use dynamic width based on screen size
                height: 60,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.textFBack
                  // border: Border.all(color: Colors.orange, width: 2),
                ),
                child: TextField(
                  controller: controllers[index],
                  maxLength: 1,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    counterText: '',
                    hintText: '',
                    hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty && index < controllers.length - 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                ),
              ),
            );
          }),
        ),

        // Button to print OTP value
        const SizedBox(height: 20),
        // ElevatedButton(
        //   onPressed: () {
        //     String otp = controllers.map((controller) => controller.text).join('');
        //     print('Entered OTP: $otp');
        //   },
        //   child: const Text('Print OTP'),
        // ),
      ],
    );
  }
}
