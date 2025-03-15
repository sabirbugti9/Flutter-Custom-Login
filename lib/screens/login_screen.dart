import 'package:flutter/material.dart';
import 'package:quicklogin/screens/forgot_screen.dart';
import 'package:quicklogin/screens/home_screen.dart';
import 'package:quicklogin/screens/signup_screen.dart';
import 'package:quicklogin/utils/auth_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quicklogin/widgets/custom_toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  void _login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty) {
      showCustomToast("Please enter email");
    } else if (password.isEmpty) {
      showCustomToast("Please enter password");
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false,
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Shape
          TopCircle(size: size),
          // Main Content
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.1),

                  // Login Heading
                  LoginText(size: size),
                  SizedBox(height: size.height * 0.02),

                  // Subtext
                  WelcomeText(size: size),
                  SizedBox(height: size.height * 0.08),

                  _inputText(size),

                  // Forgot Password
                  ForgetText(),
                  SizedBox(height: size.height * 0.01),

                  // Sign In Button
                  _loginButton(size),
                  SizedBox(height: size.height * 0.03),

                  // Create New Account
                  _signUpButton(context),
                  SizedBox(height: size.height * 0.02),

                  // OR Continue With
                  _continueText(),
                  SizedBox(height: size.height * 0.03),

                  // Social Media Buttons
                  _socialLogin(size),

                  SizedBox(width: size.width * 0.03),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _socialLogin(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _socialIcon(
          FontAwesomeIcons.google,
          Colors.red,
          () async {},
        ),
        SizedBox(width: size.width * 0.03),
        _socialIcon(
          FontAwesomeIcons.facebook,
          Colors.blue,
          () async {},
        ),
        SizedBox(width: size.width * 0.03),
        _socialIcon(
          FontAwesomeIcons.twitter,
          Colors.lightBlue,
          () async {},
        ),
      ],
    );
  }

  Text _continueText() {
    return Text(
      "Or continue with",
      style: TextStyle(fontSize: 14, color: Colors.purple),
    );
  }

  TextButton _signUpButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SignupScreen()),
          (route) => false,
        );
      },
      child: Text(
        "Create new account",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  SizedBox _loginButton(Size size) {
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.07,
      child: ElevatedButton(
        onPressed: _login,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          "Sign in",
          style: TextStyle(
            fontSize: size.width * 0.06,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Column _inputText(Size size) {
    return Column(
      children: [
        _customTextField(
          "Email",
          _emailController,
          TextInputType.emailAddress,
        ),
        SizedBox(height: size.height * 0.02),
        _customTextField("Password", _passwordController, TextInputType.text,
            isPassword: true),
        SizedBox(height: size.height * 0.02),
      ],
    );
  }

  // Custom TextField Widget
  Widget _customTextField(
    String label,
    TextEditingController controller,
    TextInputType inputType, {
    bool isPassword = false,
  }) {
    return TextField(
      keyboardType: inputType,
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.purple[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // Social Media Icon Widget
  Widget _socialIcon(IconData icon, Color color, VoidCallback tapFunction) {
    return GestureDetector(
      onTap: tapFunction,
      child: CircleAvatar(
        radius: 24,
        backgroundColor: Colors.grey[200],
        child: Icon(icon, color: color, size: 28),
      ),
    );
  }
}

class ForgetText extends StatelessWidget {
  const ForgetText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ForgotPasswordScreen(),
            ),
          );
        },
        child: Text(
          "Forgot your password?",
          style: TextStyle(color: Colors.purple),
        ),
      ),
    );
  }
}

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Text(
      "Welcome Back!\nSecure & Simple Login",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: size.width * 0.05,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class LoginText extends StatelessWidget {
  const LoginText({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Text(
      "Login here",
      style: TextStyle(
        fontSize: size.width * 0.1,
        fontWeight: FontWeight.bold,
        color: Colors.purple,
      ),
    );
  }
}

class TopCircle extends StatelessWidget {
  const TopCircle({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -100,
      left: -50,
      child: Container(
        width: size.width / 1.1,
        height: size.height / 1.8,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.purple.withOpacity(0.03),
        ),
      ),
    );
  }
}
