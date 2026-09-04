import 'package:flutter/material.dart';
import 'package:foryou/constants/app_colors.dart';
import 'package:foryou/services/auth_service.dart';

import 'dart:ui';
class OtpScreen extends StatefulWidget {

  final String email;

  const OtpScreen({
    super.key,
    required this.email,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}


class _OtpScreenState extends State<OtpScreen> {

  final List<TextEditingController> otpControllers =
  List.generate(
    6,
        (index) => TextEditingController(),
  );

  final List<FocusNode> focusNodes =
  List.generate(
    6,
        (index) => FocusNode(),
  );

  bool isLoading = false;
  bool isResending = false;


  //VERIFY OTP-------------------------------------------------------------------

  Future<void> verifyOtp() async {

    final otp = otpControllers.map((controller) => controller.text).join();
    if (otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the complete OTP'),),);
      return;
    }
    setState(() {
      isLoading = true;
    });
    try {
      await AuthService.validateOtp(widget.email, otp,);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('OTP verified successfully'),),);


      // بعد نجاح OTP نروح Reset Password

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResetPassward(
            email: widget.email,
            otp: otp,
          ),
        ),
      );

    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid OTP: $e',),),);
    }
    finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }


  //RESEND OTP

  Future<void> resendOtp() async {

    setState(() {
      isResending = true;
    });

    try {
      await AuthService.resendOtp(
        widget.email,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('OTP sent again successfully'),
        ),
      );

    }
    catch (e) {

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to resend OTP: $e',),),);

    }
    finally {

      if (mounted) {
        setState(() {
          isResending = false;
        });
      }
    }
  }


  @override
  void dispose() {

    for (var controller in otpControllers) {
      controller.dispose();
    }

    for (var node in focusNodes) {
      node.dispose();
    }

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [

          //BACKGROUND---------------------------------------------------

          Image.asset(
            'assets/backgroundForLoginPage.jpeg',
            fit: BoxFit.cover,
          ),

          //CONTENT------------------------------------------------------------

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [

                      //TITLE---------------------------------------------
                      Text(
                        'Enter OTP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),


                      //SUBTITLE------------------------------------------------

                      Text(
                        'Enter the OTP sent to your email',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                        ),
                      ),

                      SizedBox(height: 45),


                      //OTP BOXES------------------------------------------------

                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                        children: List.generate(6,(index) {
                          return SizedBox(
                              width: 45,
                              height: 55,
                            child: TextField(
                              controller: otpControllers[index],
                              focusNode: focusNodes[index],
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight:
                                  FontWeight.bold,
                                ),

                                decoration:
                                InputDecoration(counterText: '',
                                  enabledBorder:
                                  OutlineInputBorder(borderRadius:
                                    BorderRadius
                                        .circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 1.5,
                                    ),
                                  ),
                                  focusedBorder:
                                  OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius
                                        .circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                ),

                                onChanged: (value) {

                                  if (value.isNotEmpty && index < 5) {

                                    focusNodes[index + 1]
                                        .requestFocus();
                                  }

                                  if (value.isEmpty && index > 0) {

                                    focusNodes[index - 1]
                                        .requestFocus();
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      ),


                      SizedBox(height: 45),


                      //VERIFY---------------------------------------------------------

                      SizedBox(
                        width: double.infinity,
                        height: 76,

                        child: ElevatedButton(
                          onPressed:
                          isLoading ? null : verifyOtp,
                          style:
                          ElevatedButton.styleFrom(
                            backgroundColor:AppColors.dark,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40),),
                          ),

                          child: isLoading ?  CircularProgressIndicator(color: Colors.white,)
                              : Text(
                            'Verify OTP',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),


                       SizedBox(height: 30),


                      // RESEND--------------------------------------------

                      Row(
                        mainAxisAlignment:MainAxisAlignment.center,

                        children: [

                           Text(
                            "Didn't receive the code? ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),

                          GestureDetector(

                            onTap:
                            isResending? null : resendOtp,

                            child: Text(
                              isResending? 'Sending...': 'Resend',

                              style:  TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                decoration:
                                TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),


                       SizedBox(height: 25),


                      //BACK----------------------------------------------------------------

                      GestureDetector(

                        onTap: () {
                          Navigator.pop(context);
                        },

                        child: Text(
                          'Back to Log in', style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            decoration:
                            TextDecoration.underline,
                          ),
                        ),
                      ),

                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}