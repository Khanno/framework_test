import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:framework_test/styles/button_styles.dart';
import 'package:framework_test/styles/text_styles.dart';
import 'package:framework_test/widgets/text_inputs/custom_text_input.dart';

class LoginPage extends StatelessWidget {

  final GlobalKey<FormState> loginFormKey = GlobalKey();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 65.0),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 30.0),
            child: Form(
              key: loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/shopping_cart.svg', height: 150.0, width: 150.0,),
                  SizedBox(
                    height: 15.0,
                  ),
                  CustomTextInput(
                    prefixIcon: Icon(Icons.person),
                    controller: usernameController,
                    label: 'Username',
                    isRequired: true,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  CustomTextInput(
                    prefixIcon: Icon(Icons.lock),
                    controller: passwordController,
                    label: 'Password',
                    keyboardType: TextInputType.number,
                    isRequired: true,
                    isPassword: true,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  InkWell(
                    child: ElevatedButton(
                      onPressed:  () {
                        if(loginFormKey.currentState!.validate()) {
                          Navigator.pushReplacementNamed(context, '/homescreen');
                        }
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Login', style: RobotoCustomStyle().style(context: context, color: Colors.white),),
                          SizedBox(width: 5.0,),
                          Icon(Icons.login, color: Colors.white,),
                        ],
                      ),
                      style: ElevatedButtonStyle().style(context: context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
