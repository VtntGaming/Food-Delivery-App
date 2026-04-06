import 'package:flutter/material.dart';

import 'package:food_delivery_app/core/theme/app_colors.dart';
import 'package:food_delivery_app/core/theme/app_text_styles.dart';
import 'package:food_delivery_app/features/auth/presentation/widgets/app_logo.dart';
import 'package:food_delivery_app/features/auth/presentation/widgets/app_primary_button.dart';
import 'package:food_delivery_app/features/auth/presentation/widgets/app_text_field.dart';
import 'package:food_delivery_app/features/auth/presentation/widgets/social_login_section.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Thông tin đăng nhập không đúng!';
      });
      return;
    }

    // TODO: Implement actual login logic
    setState(() {
      _errorMessage = 'Thông tin đăng nhập không đúng!';
    });
  }

  void _navigateToRegister() {
    Navigator.of(context).pushNamed('/register');
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = MediaQuery.sizeOf(context).width * 0.107;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      const AppLogo(),
                      const SizedBox(height: 80),
                      if (_errorMessage != null) ...[
                        Text(
                          _errorMessage!,
                          style: AppTextStyles.errorText,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                      ],
                      AppTextField(
                        hintText: 'email hoặc sđt',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 15),
                      AppTextField(
                        hintText: 'mật khẩu',
                        controller: _passwordController,
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      AppPrimaryButton(
                        text: 'Đăng nhập',
                        onPressed: _handleLogin,
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: _navigateToRegister,
                        child: Text(
                          'Chưa có tài khoản? Đăng ký ngay!',
                          style: AppTextStyles.linkText,
                        ),
                      ),
                      const SizedBox(height: 60),
                      const SocialLoginSection(),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
