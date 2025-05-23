import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanderverse_app/providers/authentication/authService.dart';
import 'package:wanderverse_app/router/appState.dart';
import 'package:wanderverse_app/utils/widgets/loginImageSlider.dart';
import 'package:wanderverse_app/utils/widgets/socialIconsButton.dart';
import 'package:wanderverse_app/utils/widgets/textField.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  // login form
  final _loginFormKey = GlobalKey<FormState>();
  final _loginEmailController = TextEditingController();
  final _loginPasswordController = TextEditingController();

  // signup form
  final _signupFormKey = GlobalKey<FormState>();
  final _signupUsernameController = TextEditingController();
  final _signupEmailController = TextEditingController();
  final _signupPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoginMode = true;

  @override
  void initState() {
    super.initState();

    // Check if already authenticated and redirect if needed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ref.read(authServiceProvider).isAuthenticated) {
        ref.read(appstateProvider.notifier).changeAppRoute('/');
      }
    });
  }

  @override
  void dispose() {
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _signupEmailController.dispose();
    _signupUsernameController.dispose();
    _signupPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    print('login');
    if (_loginFormKey.currentState!.validate()) {
      final success = await ref
          .read(authServiceProvider.notifier)
          .loginWithEmailAndPassword(_loginEmailController.text.trim(),
              _loginPasswordController.text.trim());

      if (!success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Login Failed'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  Future<void> _handleSignUp() async {
    if (_signupFormKey.currentState!.validate()) {
      final success = await ref.read(authServiceProvider.notifier).signUp(
          _signupUsernameController.text.trim(),
          _signupEmailController.text.trim(),
          _signupPasswordController.text.trim());

      if (!success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Sign Up Failed'),
          backgroundColor: Colors.red,
        ));
      }
    }
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
        Expanded(child: _isLoginMode ? _buildLoginForm() : _buildSingUpForm()),
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

          _isLoginMode ? _buildLoginForm() : _buildSingUpForm()
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _loginFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Log in to your account',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.white70),
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          _isLoginMode = false;
                        });
                        // widget.onNavigate(AppState('/signup', false));
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const SignUpScreen()));
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.purpleAccent),
                      ))
                ],
              ),
              const SizedBox(
                height: 32,
              ),

              // Email
              buildTextField(
                  controller: _loginEmailController,
                  labelText: 'Email',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
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
                  controller: _loginPasswordController,
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
                    return null;
                  }),

              const SizedBox(
                height: 8,
              ),

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.purpleAccent),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),

              // Login Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7E57C2),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    onPressed: _handleLogin,
                    child: const Text(
                      'Log In',
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

  Widget _buildSingUpForm() {
    return Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _signupFormKey,
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
                        setState(() {
                          _isLoginMode = true;
                        });
                        // Navigator.pop(context);
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
                  controller: _signupUsernameController,
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
                  controller: _signupEmailController,
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
                  controller: _signupPasswordController,
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
                    onPressed: _handleSignUp,
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
