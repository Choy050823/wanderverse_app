import 'package:flutter/material.dart';
import 'package:wanderverse_app/utils/widgets/loginImageSlider.dart';
import 'package:wanderverse_app/utils/widgets/textField.dart';

import '../../utils/widgets/socialIconsButton.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width > 800;

    return Scaffold(
      backgroundColor: const Color(0XFF24202F),
      body: SafeArea(
        child: Center(
          child: Container(
            width: isDesktop ? 900 : screenSize.width * 0.9,
            height: isDesktop ? 550 : null,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: const Color(0xFF1C1A24),
              borderRadius: BorderRadius.circular(16),
            ),
            child: isDesktop ? _buildDesktopLayOut() : _buildMobileLayout(),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayOut() {
    return Row(
      children: [
        // Images with tagline
        const LoginImageSlider(),

        // Right: Login Form
        Expanded(child: _buildSingUpForm()),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Banner
          Container(
            height: 180,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  "https://m.media-amazon.com/images/I/71eYCAMKcJL._AC_UF1000,1000_QL80_.jpg",
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        Colors.purple.withOpacity(0.2),
                        Colors.black.withOpacity(0.7)
                      ])),
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'WanderVerse',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),

          _buildSingUpForm()
        ],
      ),
    );
  }

  Widget _buildSingUpForm() {
    return Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Create an account',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(color: Colors.white70),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Log In',
                        style: TextStyle(color: Colors.purpleAccent),
                      ))
                ],
              ),
              const SizedBox(
                height: 32,
              ),

              // Username
              buildTextField(
                  controller: _usernameController,
                  labelText: 'Username',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username required';
                    }
                    return null;
                  }),
              const SizedBox(
                height: 16,
              ),

              // Email
              buildTextField(
                  controller: _emailController,
                  labelText: 'Email',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email required';
                    }

                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  }),
              const SizedBox(
                height: 16,
              ),

              // Password
              buildTextField(
                  controller: _passwordController,
                  labelText: 'Password',
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    icon: Icon(_obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    return null;
                  }),

              const SizedBox(
                height: 32,
              ),

              // Create account Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7E57C2),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Login function here
                      }
                    },
                    child: const Text(
                      'Create Account',
                      style: TextStyle(fontSize: 16),
                    )),
              ),
              const SizedBox(
                height: 24,
              ),

              // Divider
              const Row(
                children: [
                  Expanded(
                      child: Divider(
                    color: Colors.grey,
                  )),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Or sign in with',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Expanded(
                      child: Divider(
                    color: Colors.grey,
                  )),
                ],
              ),
              const SizedBox(
                height: 24,
              ),

              // Social buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildSocialIcon(
                      onPressed: () {},
                      iconUrl:
                          "https://cdn.iconscout.com/icon/free/png-256/free-google-logo-icon-download-in-svg-png-gif-file-formats--brands-pack-logos-icons-189824.png?f=webp&w=256",
                      label: 'Google'),
                  const SizedBox(
                    width: 16,
                  ),
                  buildSocialIcon(
                      onPressed: () {},
                      iconUrl:
                          "https://cdn-icons-png.flaticon.com/128/6033/6033716.png",
                      label: 'Meta')
                ],
              )
            ],
          ),
        ));
  }
}
