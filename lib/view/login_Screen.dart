import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:testfirebase_1/controller/auth_controller.dart';

import 'package:testfirebase_1/view/auth.dart';
import 'package:testfirebase_1/view/forgot_password_page.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.white),
                ),
                Gap(13),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 6) {
                      return 'Password must be at  6 characters';
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.white),
                ),
                Gap(20),
                ElevatedButton(
                  onPressed: () {
                    login(context);
                  },
                  child: Text('Login'),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ));
                      },
                      child: Text('Create New Account'),
                    ),
                    InkWell(
                      onTap: () {
                        googleSignIn(context);
                      },
                      child: Container(
                        height: 50,
                        child: Image(
                            image: NetworkImage(
                                "https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png")),
                      ),
                    )
                  ],
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ForgotPasswordScreen(),
                      ));
                    },
                    child: Text("ForgotPassword"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login(context) async {
    final provider = Provider.of<AuthController>(context, listen: false);
    if (_formKey.currentState?.validate() ?? false) {
      provider.login(context, _emailController.text.trim(),
          _passwordController.text.trim());
    }
  }

  googleSignIn(context) async {
    final provider = Provider.of<AuthController>(context, listen: false);
    User? user = await provider.googleSignUp();
    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('SignIn Successful')),
      );
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => AuthPage(),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('SignIn Failed')),
      );
    }
  }
}
