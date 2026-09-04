import 'package:flutter/material.dart';
import 'services/auth_service.dart';

class ResetPasswordPage extends StatefulWidget {

  final String email;
  final String otp;

  const ResetPasswordPage({
    super.key,
    required this.email,
    required this.otp,
  });

  @override
  State<ResetPasswordPage> createState() =>
      _ResetPasswordPageState();
}


class _ResetPasswordPageState
    extends State<ResetPasswordPage> {

  bool showPassword = false;
  bool showConfirmPassword = false;

  bool isLoading = false;


  final TextEditingController passwordController =
  TextEditingController();

  final TextEditingController confirmPasswordController =
  TextEditingController();


  @override
  void dispose() {

    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }


  // ================= RESET PASSWORD =================

  Future<void> resetPassword() async {

    final password =
    passwordController.text.trim();

    final confirmPassword =
    confirmPasswordController.text.trim();


    // Empty fields

    if (password.isEmpty ||
        confirmPassword.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please enter your password',
          ),
        ),
      );

      return;
    }


    // Passwords don't match

    if (password != confirmPassword) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Passwords do not match',
          ),
        ),
      );

      return;
    }


    setState(() {
      isLoading = true;
    });


    try {

      // ================= CALL API =================

      await AuthService.resetPassword(
        widget.email,
        widget.otp,
        password,
      );


      if (!mounted) return;


      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Password reset successfully',
          ),
        ),
      );


      // ================= BACK TO LOGIN =================

      Navigator.pop(context);


    } catch (e) {

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to reset password: $e',
          ),
        ),
      );


    } finally {

      if (mounted) {

        setState(() {
          isLoading = false;
        });

      }
    }
  }


  // ================= UI =================

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(

          image: DecorationImage(

            image: AssetImage(
              'assets/backgroundForLoginPage.png',
            ),

            fit: BoxFit.cover,

            colorFilter: ColorFilter.mode(
              Colors.black54,
              BlendMode.darken,
            ),
          ),
        ),


        child: SafeArea(

          child: Padding(

            padding:
            const EdgeInsets.symmetric(
              horizontal: 32,
            ),


            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                const SizedBox(height: 170),


                // ================= TITLE =================

                const Text(
                  'Reset\nPassword',

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),


                const SizedBox(height: 25),


                const Text(
                  'Create a strong new password',

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),


                const SizedBox(height: 55),


                // ================= NEW PASSWORD =================

                TextField(

                  controller:
                  passwordController,

                  obscureText:
                  !showPassword,

                  style: const TextStyle(
                    color: Colors.white,
                  ),

                  decoration: InputDecoration(

                    hintText:
                    'New Password',

                    hintStyle:
                    const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),


                    suffixIcon:
                    IconButton(

                      icon: Icon(

                        showPassword
                            ? Icons.visibility
                            : Icons.visibility_off,

                        color:
                        Colors.white,
                      ),


                      onPressed: () {

                        setState(() {

                          showPassword =
                          !showPassword;

                        });
                      },
                    ),


                    enabledBorder:
                    const UnderlineInputBorder(
                      borderSide:
                      BorderSide(
                        color: Colors.white,
                      ),
                    ),


                    focusedBorder:
                    const UnderlineInputBorder(
                      borderSide:
                      BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),


                const SizedBox(height: 45),


                // ================= CONFIRM PASSWORD =================

                TextField(

                  controller:
                  confirmPasswordController,

                  obscureText:
                  !showConfirmPassword,

                  style: const TextStyle(
                    color: Colors.white,
                  ),


                  decoration:
                  InputDecoration(

                    hintText:
                    'Confirm Password',

                    hintStyle:
                    const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),


                    suffixIcon:
                    IconButton(

                      icon: Icon(

                        showConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off,

                        color:
                        Colors.white,
                      ),


                      onPressed: () {

                        setState(() {

                          showConfirmPassword =
                          !showConfirmPassword;

                        });
                      },
                    ),


                    enabledBorder:
                    const UnderlineInputBorder(
                      borderSide:
                      BorderSide(
                        color: Colors.white,
                      ),
                    ),


                    focusedBorder:
                    const UnderlineInputBorder(
                      borderSide:
                      BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),


                const SizedBox(height: 75),


                // ================= RESET BUTTON =================

                Center(

                  child: SizedBox(

                    width: 450,
                    height: 70,

                    child: ElevatedButton(

                      onPressed:
                      isLoading
                          ? null
                          : resetPassword,


                      style:
                      ElevatedButton.styleFrom(

                        backgroundColor:
                        Colors.black87,


                        shape:
                        RoundedRectangleBorder(

                          borderRadius:
                          BorderRadius.circular(
                            40,
                          ),
                        ),
                      ),


                      child: isLoading

                          ? const CircularProgressIndicator(
                        color: Colors.white,
                      )

                          : const Text(
                        'Reset Password',

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}