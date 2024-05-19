import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formz/formz.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quadrant_app/blocs/login/bloc/login_bloc.dart';
import 'package:quadrant_app/pages/screens/Authentication/Register/RegisterScreen.dart';
import 'package:quadrant_app/repositories/AuthRepository/auth_repository.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginScreen());
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isButtonDisabled = false;

  void login() {
    setState(() {
      _isButtonDisabled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: BlocProvider(
          create: (context) {
            return LoginBloc(
              authenticationRepository:
                  RepositoryProvider.of<AuthenticationRepository>(context),
            );
          },
          child: const LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        // if (state.status.isFailure) {
        //   ScaffoldMessenger.of(context)
        //     ..hideCurrentSnackBar()
        //     ..showSnackBar(
        //       const SnackBar(content: Text('authentication failure')),
        //     );
        // }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Welcome back", style: TextStyle(
              fontSize: 24,
            )),
            const Text("Let's sign you in.", style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            )),
            _UsernameInput(),
            _PasswordInput(),
            const SizedBox(height: 20),
            _LoginButton(),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text("Don't have an account?"),
                TextButton(
                  key: const Key('loginForm_createAccount_raisedButton'),
                  onPressed: () {
                    Navigator.of(context).push<void>(RegisterScreen.route());
                  },
                  child: const Text('Sign Up'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: state.email.displayError != null ? Colors.red : (isDark ? Colors.white : Colors.black87),
              )
            ),
            child: Row(
              children: [
                const SizedBox(width: 15),
                Expanded(
                  child: TextField(
                    key: const Key('loginForm_usernameInput_textField'),
                    onChanged: (username) => context.read<LoginBloc>().add(LoginUsernameChanged(username)),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email',
                    ),
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: state.password.displayError != null ? Colors.red : (isDark ? Colors.white : Colors.black87),
              )
            ),
            child: Row(
              children: [
                const SizedBox(width: 15),
                Expanded(
                  child: TextField(
                    key: const Key('loginForm_passwordInput_textField'),
                    onChanged: (password) => context.read<LoginBloc>().add(LoginPasswordChanged(password)),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                    ),
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14
                    ),
                    obscureText: true,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: isDark ? Colors.white : Colors.black87,
                size: 21,
              ),
            )
            : GestureDetector(
              key: const Key('loginForm_continue_raisedButton'),
              onTap: state.isValid ? () {
                context.read<LoginBloc>().add(const LoginSubmitted());
              } : null,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white : (state.isValid ? Colors.black87 : Colors.black54),
                      borderRadius: BorderRadius.circular(15),
                    ),
                        child: Center(
                          child: Text( "Sign In",
                          style: TextStyle(
                            color: isDark ? Colors.black87 : Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          ),
                        ),
                  ),
                  (state.status.isFailure) ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("You have entered an invalid email or password.", style: TextStyle(
                      color: Colors.red,
                    )),
                  ) : Container()
                ],
              ),
            );
      },
    );
  }
}
