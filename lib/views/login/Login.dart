import 'package:firebase_auth/firebase_auth.dart';
import 'package:gkvk/constants/auth.dart'; // Ensure this path is correct for your project structure
import 'package:flutter/material.dart';
import 'package:gkvk/shared/components/CustomAlertDialog.dart';
import 'package:gkvk/shared/components/CustomTextButton.dart';
import 'package:gkvk/views/home/home_view.dart';
// import 'package:gkvk/views/login/Forgotpassword_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  String? errorMessage = '';
  bool isLogin = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
      showDialog(
        context: context,
        builder: (context) => CustomAlertDialog(
          title: 'Login Error',
          content: e.message ?? 'An unknown error occurred',
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      );
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    // Start the fade animation
    _controller.forward();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _controller.dispose();
    super.dispose();
  }

  Future<void> preloadImage(BuildContext context) async {
    await precacheImage(const AssetImage('assets/images/bg2.png'), context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: preloadImage(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: Stack(
                children: [
                  // Background Image
                  Image.asset(
                    'assets/images/bg2.png', // Replace with your image asset path
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  // Content
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: IntrinsicHeight(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF8E0),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/CoE-WM.png',
                                width: 100,
                                height: 100,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF8DB600),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                  labelText: 'Email ID',
                                  border: OutlineInputBorder(),
                                  fillColor: Colors.white,
                                  filled: true,
                                ),
                                validator: validateEmail,
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: passwordController,
                                decoration: const InputDecoration(
                                  labelText: 'Password',
                                  border: OutlineInputBorder(),
                                  fillColor: Colors.white,
                                  filled: true,
                                ),
                                obscureText: true,
                                validator: validatePassword,
                              ),
                              // Align(
                              //     alignment: Alignment.centerRight,
                              //     child: InkWell(
                              //       onTap: () => Navigator.push(
                              //           context,
                              //           MaterialPageRoute(
                              //               builder: (context) =>
                              //                   const ForgotpasswordPage())),
                              //       child: const Text("Forgot Password?"),
                              //     )),
                              const SizedBox(height: 20),
                              CustomTextButton(
                                text: "Sign In",
                                buttonColor: const Color(0xFFFB812C),
                                onPressed: () async {
                                  if (validateEmail(emailController.text) == null &&
                                      validatePassword(passwordController.text) == null) {
                                    await signInWithEmailAndPassword();
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) => CustomAlertDialog(
                                        title: 'Login Error',
                                        content: 'Please enter valid email and password.',
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    );
                                  }
                                },
                              ),
                              if (errorMessage != null && errorMessage!.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    errorMessage!,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Scaffold(
              backgroundColor: Color(0xFFFEF8E0), // Background color
              body: Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFFB812C), // Progress indicator color
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: LoginPage(),
  ));
}
