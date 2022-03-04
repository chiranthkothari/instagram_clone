import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/screens/signup_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void signinUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signinUser(
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (res != 'success') {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 1,
              ),
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                height: 64,
                color: primaryColor,
              ),
              const SizedBox(
                height: 56,
              ),
              TextFieldInput(
                textEditingController: _emailController,
                hintText: "Enter your email",
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 16,
              ),
              TextFieldInput(
                textEditingController: _passwordController,
                hintText: "Enter your password",
                textInputType: TextInputType.text,
                isPass: true,
              ),
              const SizedBox(
                height: 24,
              ),
              _isLoading
                  ? const CircularProgressIndicator()
                  : InkWell(
                      onTap: signinUser,
                      child: Container(
                        child: const Text(
                          'LOG IN',
                          style: TextStyle(fontSize: 16),
                        ),
                        height: 40,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: blueColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                      ),
                    ),
              Flexible(
                child: Container(),
                flex: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text('Dont have an account?'),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  InkWell(
                    onTap: (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignupScreen()));
                    }),
                    child: Container(
                      child: const Text(
                        ' Sign up',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
