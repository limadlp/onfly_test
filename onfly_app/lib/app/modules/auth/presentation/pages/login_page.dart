import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onfly_app/app/modules/auth/presentation/cubit/auth_cubit.dart';
import 'package:onfly_app/app/modules/auth/presentation/cubit/auth_state.dart';
import 'package:onfly_app/app/modules/auth/presentation/widgets/custom_input_field_widget.dart';
import 'package:onfly_app/app/modules/auth/presentation/widgets/password_field_widget.dart';
import 'package:onfly_design_system/onfly_design_system.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(child: _buildBackgroundImage()),
              const Expanded(child: SizedBox()),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.52,
            child: const LoginForm(),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/login_background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacementNamed(context, '/');
        }
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login inválido!'),
              backgroundColor: OnflyColors.alert,
            ),
          );
        }
      },
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/main-logo.png',
                  height: 80,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 20),
                CustomInputFieldWidget(
                  controller: _emailController,
                  label: 'Email',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                PasswordFieldWidget(controller: _passwordController),

                const SizedBox(height: 16),
                state is AuthLoading
                    ? const CircularProgressIndicator()
                    : OnflyButton(
                      onPressed: _validateAndLogin,
                      label: 'Vamos!',
                    ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _validateAndLogin() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || !email.contains('@')) {
      _showError('Por favor, insira um email válido');
      return;
    }

    if (password.isEmpty || password.length < 6) {
      _showError('A senha deve ter pelo menos 6 caracteres');
      return;
    }

    BlocProvider.of<AuthCubit>(
      context,
    ).signin(_emailController.text, _passwordController.text);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }
}
