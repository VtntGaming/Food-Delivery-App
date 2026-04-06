import 'package:flutter/material.dart';

import 'package:food_delivery_app/core/theme/app_colors.dart';
import 'package:food_delivery_app/core/theme/app_text_styles.dart';
import 'package:food_delivery_app/features/auth/presentation/widgets/app_logo.dart';
import 'package:food_delivery_app/features/auth/presentation/widgets/app_primary_button.dart';
import 'package:food_delivery_app/features/auth/presentation/widgets/app_text_field.dart';
import 'package:food_delivery_app/features/auth/presentation/widgets/social_login_section.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _fullNameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool _validate() {
    bool isValid = true;

    setState(() {
      _fullNameError = null;
      _emailError = null;
      _passwordError = null;
      _confirmPasswordError = null;

      if (_fullNameController.text.trim().isEmpty) {
        _fullNameError = 'Vui lòng nhập họ tên';
        isValid = false;
      }

      if (_emailController.text.trim().isEmpty) {
        _emailError = 'Vui lòng nhập email hoặc sđt';
        isValid = false;
      }

      if (_passwordController.text.length < 6) {
        _passwordError = 'Mật khẩu phải bao gồm 6 chữ số';
        isValid = false;
      }

      if (_confirmPasswordController.text != _passwordController.text) {
        _confirmPasswordError = 'Mật khẩu nhập lại phải khớp với mật khẩu mới';
        isValid = false;
      }
    });

    return isValid;
  }

  void _handleRegister() {
    if (!_validate()) return;
    // TODO: Implement actual register logic
  }

  void _navigateToLogin() {
    Navigator.of(context).pop();
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
                      const SizedBox(height: 40),
                      AppTextField(
                        hintText: 'họ tên',
                        controller: _fullNameController,
                        errorText: _fullNameError,
                      ),
                      const SizedBox(height: 15),
                      AppTextField(
                        hintText: 'email hoặc sđt',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        errorText: _emailError,
                      ),
                      const SizedBox(height: 15),
                      AppTextField(
                        hintText: 'mật khẩu (6 chữ số)',
                        controller: _passwordController,
                        obscureText: true,
                        errorText: _passwordError,
                      ),
                      const SizedBox(height: 15),
                      AppTextField(
                        hintText: 'nhập lại mật khẩu',
                        controller: _confirmPasswordController,
                        obscureText: true,
                        errorText: _confirmPasswordError,
                      ),
                      const SizedBox(height: 20),
                      AppPrimaryButton(
                        text: 'Đăng ký',
                        onPressed: _handleRegister,
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: _navigateToLogin,
                        child: Text(
                          'Đã có tài khoản rồi? Đăng nhập!',
                          style: AppTextStyles.linkText,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 30),
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
