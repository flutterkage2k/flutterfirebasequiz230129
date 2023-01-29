import 'package:flutter/material.dart';
import 'package:flutterfirebasequiz230129/auth/auth_service.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  Future<void> _loginGoogle() async {
    setState(() {
      _isLoading = true;
    });
    await AuthService().signInWithGoogle();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    return Scaffold(
      backgroundColor: Colors.redAccent[200],
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "로그인페이지",
            ),
            const SizedBox(height: 30),
            FractionallySizedBox(
              widthFactor: 0.9,
              child: SocialLoginButton(
                buttonType: SocialLoginButtonType.google,
                onPressed: () async {
                  _loginGoogle();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
