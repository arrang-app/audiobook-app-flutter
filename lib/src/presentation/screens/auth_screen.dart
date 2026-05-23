import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void _submit() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(const Duration(milliseconds: 900), () {
      setState(() {
        _isLoading = false;
      });
      context.go('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070707),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Welcome back',
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    fontSize: 34,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 12),
              const Text('Sign in to continue your listening journey.',
                  style: TextStyle(color: Color(0xFFC6C6C6), fontSize: 16)),
              const SizedBox(height: 32),
              _AuthField(label: 'Email', controller: _emailController),
              const SizedBox(height: 20),
              _AuthField(label: 'Password', controller: _passwordController, obscureText: true),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _isLoading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF47051),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  minimumSize: const Size.fromHeight(56),
                ),
                child: _isLoading
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                    : const Text('Continue', style: TextStyle(fontSize: 16)),
              ),
              const Spacer(),
              Center(
                child: TextButton(
                  onPressed: () => context.go('/home'),
                  child: const Text('Continue without login', style: TextStyle(color: Color(0xFFC6C6C6))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _AuthField extends StatelessWidget {
  const _AuthField({required this.label, required this.controller, this.obscureText = false});

  final String label;
  final TextEditingController controller;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFFC6C6C6)),
        filled: true,
        fillColor: const Color(0xFF121212),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
      ),
    );
  }
}
