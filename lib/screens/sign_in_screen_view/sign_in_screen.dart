import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_bounce/app_services/app_preferences.dart';
import 'package:q_bounce/app_services/navigation_service.dart';
import 'package:q_bounce/common_widget/common_text_field.dart';
import 'package:q_bounce/constant/app_color.dart';
import 'package:q_bounce/constant/app_images.dart';
import 'package:q_bounce/constant/app_strings.dart';
import 'package:q_bounce/constant/app_text_style.dart';
import 'package:q_bounce/screens/sign_in_screen_view/confirm_otp_bloc/confirm_otp_bloc.dart';
import 'package:q_bounce/screens/sign_in_screen_view/confirm_otp_bloc/confirm_otp_event.dart';
import 'package:q_bounce/screens/sign_in_screen_view/confirm_otp_bloc/confirm_otp_state.dart';
import 'package:q_bounce/screens/sign_in_screen_view/send_otp_bloc/send_otp_bloc.dart';
import 'package:q_bounce/screens/sign_in_screen_view/send_otp_bloc/send_otp_event.dart';
import 'package:q_bounce/screens/sign_in_screen_view/send_otp_bloc/send_otp_state.dart';
import 'package:q_bounce/screens/sign_in_screen_view/sign_in_widget/common_otp.dart';

import '../../common_widget/common_button.dart';
import '../../common_widget/custom_snackbar.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool isOtpSent = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SendOTPBloc()),
        BlocProvider(create: (context) => ConfirmOTPBloc()),
      ],
      child: BlocListener<SendOTPBloc, SendOTPState>(
        listener: (context, state) {
          if (state is SendOTPLoaded) {
            setState(() {
              isOtpSent = true;
            });
          } else if (state is SendOTPError) {
            ScaffoldMessengerHelper.showMessage(state.errorMessage);

          }
        },
        child: BlocListener<ConfirmOTPBloc, ConfirmOTPState>(
          listener: (context, state) {
            if (state is ConfirmOTPLoading) {
            } else if (state is ConfirmOTPLoaded) {
              ScaffoldMessengerHelper.showMessage("OTP Confirmed Successfully");
              AppPreferences.saveToken(state.postConfirmOTPResponse.data!.sessionToken.toString());
              NavigationService.navigateTo(NavigationService.drawer);
            } else if (state is ConfirmOTPError) {
              ScaffoldMessengerHelper.showMessage(state.errorMessage);

            }
          },
          child: Container(
            decoration: AppImages.background(AppImages.appBackGround),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 68.0, bottom: 60),
                        child: Center(
                          child: AppImages.image(AppImages.logo, width: 200),
                        ),
                      ),
                      Text(
                        isOtpSent
                            ? AppStrings.otp.toUpperCase()
                            : AppStrings.welCome.toUpperCase(),
                        style: AppTextStyles.athleticStyle(
                          fontSize: 36,
                          fontFamily: AppTextStyles.athletic,
                          color: AppColors.whiteColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Text(
                          isOtpSent ? AppStrings.enterOtp : AppStrings.enterMail,
                          style: AppTextStyles.athleticStyle(
                            fontSize: 20,
                            fontFamily: AppTextStyles.sfPro500,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      isOtpSent
                          ? OTPField(controller: _otpController)
                          : CommonTextField(
                        controller: _emailController,
                        label: '',
                        hint: 'Email',
                        hintColor: true,
                      ),
                      SizedBox(height: 25),
                      isOtpSent
                          ? BlocBuilder<ConfirmOTPBloc, ConfirmOTPState>(
                        builder: (context, state) {
                          if (state is ConfirmOTPLoading) {
                            return Center(child: CircularProgressIndicator(color: AppColors.appColor,));
                          }
                          return InkWell(
                            onTap: () {
                              if (_otpController.text.isEmpty) {
                                ScaffoldMessengerHelper.showMessage("Please enter OTP");


                                return;
                              }


                              BlocProvider.of<ConfirmOTPBloc>(context).add(
                                FetchConfirmOTP({
                                  "otp": _otpController.text,
                                  "email": _emailController.text
                                }),
                              );
                            },
                            child: CommonButton(
                              title: AppStrings.confirm,
                              color: AppColors.appColor,
                            ),
                          );
                        },
                      )
                          : BlocBuilder<SendOTPBloc, SendOTPState>(
                        builder: (context, state) {
                          if (state is SendOTPLoading) {
                            return Center(child: CircularProgressIndicator(color: AppColors.appColor,));
                          }
                          return InkWell(
                            onTap: () {
                              String email = _emailController.text.trim();

                              // Check if email is empty
                              if (email.isEmpty) {
                                ScaffoldMessengerHelper.showMessage("Please enter an email");
                                return;
                              }

                              // General email validation regex
                              final RegExp emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
                              if (!emailRegex.hasMatch(email)) {
                                ScaffoldMessengerHelper.showMessage("Please enter a valid email address");
                                return;
                              }

                              // If valid, proceed with sending OTP
                              BlocProvider.of<SendOTPBloc>(context).add(FetchSendOTP({"email": email}));
                            },
                            child: CommonButton(
                              title: AppStrings.submit,
                              color:  AppColors.appColor,
                            ),
                          );
                        },
                      ),
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
