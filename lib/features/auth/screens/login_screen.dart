import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_tracker/core/constants/app_colors.dart';
import 'package:study_tracker/features/auth/providers/auth_provider.dart';
import 'package:study_tracker/routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Username
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.length < 3 ? 'Min 3 characters' : null,
              ),
              const SizedBox(height: 16),

              // Password
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
                obscureText: _obscurePassword,
                validator: (v) =>
                    v == null || v.length < 6 ? 'Min 6 characters' : null,
              ),
              const SizedBox(height: 24),

              // Login Button
              Consumer<AuthProvider>(
                builder: (context, auth, _) => ElevatedButton(
                  onPressed: auth.isLoading ? null : _handleLogin,
                  child: auth.isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final auth = context.read<AuthProvider>();
    final success = await auth.login(
      _usernameController.text,
      _passwordController.text,
    );

    if (!mounted) return;

    if (success) {
      Navigator.pushReplacementNamed(context, AppRoutes.taskList);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(auth.errorMessage ?? 'Login failed'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }
}
