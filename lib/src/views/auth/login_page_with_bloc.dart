import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_kit/src/application/bloc/login_bloc.dart';
import 'package:starter_kit/src/application/states/login_state.dart';

import '../../application/events/login_event.dart';
import '../../application/usecases/login_user_app_use_case.dart';
import '../../domain/repositories/user_repository.dart';
import '../../infrastructure/repositories/UserRepository.dart';


class LoginTextField extends StatelessWidget {

  final TextEditingController controller;
  final String label;

  LoginTextField({
    required this.controller,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label, // Custom label above TextField
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
          ),
        )
      ],
    );
  }
}

class LoginPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String label;

  LoginPasswordField({
    required this.controller,
    required this.label,
    super.key
  });

  @override
  _LoginPasswordField createState() {
    return _LoginPasswordField(controller: this.controller, label: this.label);
  }
}

class _LoginPasswordField extends State<LoginPasswordField> {

  final TextEditingController controller;
  final String label;
  bool _isPasswordVisible = true;

  _LoginPasswordField({
    required this.controller,
    required this.label,
  });

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label, // Custom label above TextField
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: _isPasswordVisible,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: _togglePasswordVisibility,
              )
          ),
        )
      ],
    );
  }
}

class LoginActionBtn extends StatelessWidget {
  final void Function() onPressed;
  final String name;
  LoginActionBtn({required this.name, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(5)))),
        child: Text(name)
    );
  }

}

class LoginAction extends StatelessWidget {

  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginAction({required this.emailController, required this.passwordController, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          LoginActionBtn(name: 'Clear', onPressed: ()=>{}),
          const SizedBox(width: 16),
          LoginActionBtn(name: 'Login', onPressed: ()=>{
            context.read<LoginBLoC>().add(LoginRequested(emailController.text.toString(), passwordController.text.toString()))
          }),
        ]
    );
  }
}


class LoginPageWithBloc extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  UserRepository userRepository = UserRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
        create: (context) => LoginBLoC(LoginUserAppUseCase(userRepository)),
        child: BlocConsumer<LoginBLoC, LoginState>(
          listener: (context, state){
            if (state is LoginSuccess){
              Navigator.pushNamed(context, '/home');
            }
          },
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center( child: SizedBox( width: 100,  height: 120,  child: Image.asset('assets/logo.png')),),
                  const Center(child: Text('Login', style: TextStyle(fontSize: 24))),
                  const SizedBox(height: 16),
                  LoginTextField(controller: emailController, label: 'Email'),
                  const SizedBox(height: 16),
                  LoginPasswordField(controller: passwordController, label: 'Password'),
                  const SizedBox(height: 16),
                  Align( alignment: Alignment.topRight, child: LoginAction(emailController: emailController, passwordController: passwordController)),
                  const SizedBox(height: 16),
                  // Display login state and user info or error message
                  if (state is LoginInProgress)
                    const CircularProgressIndicator(), // Show loading
                  if (state is LoginFailure)
                    Text('Error: ${state.errorMessage}', style: const TextStyle(color: Colors.red)),
                  if (state is LoginSuccess)
                    Text('Welcome, ${state.user.email ?? 'No email'}'),  // Show user email
                ],
              ),
            );
          }),
    ));
  }
}
