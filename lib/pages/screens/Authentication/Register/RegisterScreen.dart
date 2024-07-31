import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formz/formz.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quadrant_app/blocs/register/bloc/register_bloc.dart';
import 'package:quadrant_app/repositories/AuthRepository/auth_repository.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static Route<void> route() {
    return CupertinoPageRoute<void>(builder: (_) => const RegisterScreen());
  }

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isButtonDisabled = false;

  void register() {
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
            return RegisterBloc(
              authenticationRepository:
                  RepositoryProvider.of<AuthenticationRepository>(context),
            );
          },
          child: const RegisterForm(),
        ),
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    double height = MediaQuery.of(context).size.height;
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Registration failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    "assets/logos/logo.svg", 
                    height: height / 13,
                    colorFilter: ColorFilter.mode(isDark ? Colors.white : Colors.black, BlendMode.srcIn)
                  ),
                  const Text("Quadrant.", style: TextStyle(
                    fontSize: 24,
                  )),
                ],
              ),
            ),
            const Text("Create your account.", style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            )),
            _UsernameInput(),
            _EmailInput(),
            _PasswordInput(),
            const SizedBox(height: 20),
            _RegisterButton(),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text("Already have an account?"),
                TextButton(
                  key: const Key('registerForm_login_raisedButton'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Sign In'),
                ),
              ],
            ),
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
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: state.username.displayError != null ? Colors.red : (isDark ? Colors.white : Colors.black87),
              )
            ),
            child: Row(
              children: [
                const SizedBox(width: 15),
                Expanded(
                  child: TextField(
                    key: const Key('registerForm_usernameInput_textField'),
                    onChanged: (username) => context.read<RegisterBloc>().add(RegisterUsernameChanged(username)),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: !isDark ? Colors.black54 : Colors.white54
                      ),
                      hintText: 'Username',
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

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return BlocBuilder<RegisterBloc, RegisterState>(
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
                    key: const Key('registerForm_emailInput_textField'),
                    onChanged: (email) => context.read<RegisterBloc>().add(RegisterEmailChanged(email)),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: !isDark ? Colors.black54 : Colors.white54
                      ),
                      hintText: 'johndoe@email.com',
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
    return BlocBuilder<RegisterBloc, RegisterState>(
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
                    key: const Key('registerForm_passwordInput_textField'),
                    onChanged: (password) => context.read<RegisterBloc>().add(RegisterPasswordChanged(password)),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: !isDark ? Colors.black54 : Colors.white54
                      ),
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

class _RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: isDark ? Colors.white : Colors.black87,
                size: 21,
              ),
            )
            : GestureDetector(
              key: const Key('registerForm_continue_raisedButton'),
              onTap: state.isValid ? () {
                context.read<RegisterBloc>().add(const RegisterSubmitted());
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
                      child: Text( "Register",
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
                    child: Text("Failed to register. Please try again.", style: TextStyle(
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