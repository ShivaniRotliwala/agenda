import 'package:flutter/material.dart';
import 'package:flutterfire_samples/res/custom_colors.dart';
import 'package:flutterfire_samples/screens/login_screen.dart';
import 'package:flutterfire_samples/utils/authExceptionHandler.dart';
import 'package:flutterfire_samples/utils/validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'custom_form_field.dart';

class RegisterForm extends StatefulWidget {
  final FocusNode emailFocus, passwordFocus, confirmPasswordFocus;

  const RegisterForm(
      {Key? key,
      required this.emailFocus,
      required this.passwordFocus,
      required this.confirmPasswordFocus})
      : super(key: key);
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _registrationInFormKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool showProgress = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _registrationInFormKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              bottom: 24.0,
            ),
            child: Column(
              children: [
                CustomFormField(
                  controller: _emailController,
                  focusNode: widget.emailFocus,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.done,
                  validator: (value) => Validator.validateEmail(
                    email: value,
                  ),
                  label: 'Email',
                  hint: 'Enter your email',
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              bottom: 24.0,
            ),
            child: Column(
              children: [
                CustomFormField(
                  controller: _passwordController,
                  focusNode: widget.passwordFocus,
                  keyboardType: TextInputType.text,
                  isObscure: true,
                  inputAction: TextInputAction.done,
                  validator: (value) => Validator.validatePassword(
                    password: value,
                  ),
                  label: 'Password',
                  hint: 'Enter your Password',
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              bottom: 24.0,
            ),
            child: Column(
              children: [
                CustomFormField(
                  controller: _confirmPasswordController,
                  focusNode: widget.confirmPasswordFocus,
                  keyboardType: TextInputType.text,
                  isObscure: true,
                  inputAction: TextInputAction.done,
                  validator: (
                    value,
                  ) =>
                      Validator.validateConfirmPassword(
                    confirmPassword: value,
                    password: _passwordController.text,
                  ),
                  label: 'Confirm Password',
                  hint: 'Enter Confirm Password',
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 0.0, right: 0.0),
            child: Container(
              width: double.maxFinite,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      CustomColors.firebaseOrange,
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    widget.emailFocus.unfocus();
                    widget.passwordFocus.unfocus();
                    widget.confirmPasswordFocus.unfocus();
                    setState(() {
                      showProgress = true;
                    });
                    if (_registrationInFormKey.currentState!.validate()) {
                      if (_registrationInFormKey.currentState!.validate()) {
                        try {
                          final newuser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text);
                          // ignore: unnecessary_null_comparison
                          if (newuser != null) {
                            Fluttertoast.showToast(
                                msg: "Registration Successful",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                            );
                            setState(() {
                              showProgress = false;
                            });
                          }
                        } catch (e) {
                          Fluttertoast.showToast(
                              msg: AuthExceptionHandler.handleException(e),
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      }
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 16.0),
                    child: Text(
                      'REGISTER',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.firebaseGrey,
                        letterSpacing: 2,
                      ),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
