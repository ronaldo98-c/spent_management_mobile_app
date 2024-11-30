import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spent_mananagement_mobile/blocs/app.dart';
import 'package:spent_mananagement_mobile/theme/theme.dart';
import 'package:spent_mananagement_mobile/screens/widgets/custom_scaffold.dart';
import 'package:spent_mananagement_mobile/screens/authentication/signup_screen.dart';
import 'package:spent_mananagement_mobile/screens/authentication/reset_password.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  bool _eyeClosed = false;
  final _email = TextEditingController();
  final _password = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AppBloc, AppState>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            bool isLoading = state is LoginLoadingState;
            return CustomScaffold(
              child: Column(
                children: [
                  const Expanded(
                    flex: 1,
                    child: SizedBox(height: 10),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Form(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Se connecter',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900,
                                  color: lightColorScheme.primary,
                                ),
                              ),
                              const SizedBox(height: 40),
                              TextFormField(
                                controller: _email,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez entrer votre e-mail';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  label: const Text('E-mail'),
                                  hintText: 'Entrez votre e-mail',
                                  hintStyle: const TextStyle(color: Colors.black26),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.black12),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.black12),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 25),
                              TextFormField(
                                controller: _password,
                                obscureText: _eyeClosed,
                                obscuringCharacter: '*',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez entrer le mot de passe';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  label: const Text('Mot de passe'),
                                  suffixIcon: IconButton(
                                    icon: _eyeClosed ? const Icon(Icons.visibility_off) : const Icon(Icons.remove_red_eye),
                                    onPressed: () => setState(() => _eyeClosed = !_eyeClosed),
                                  ),
                                  hintText: 'Entrer le mot de passe',
                                  hintStyle: const TextStyle(color: Colors.black26),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.black12),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.black12),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 25.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(width: 50),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (e) => const ResetPasswordScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Mot de passe oublié?',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: lightColorScheme.primary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: isLoading
                                      ? null
                                      : () {
                                          BlocProvider.of<AppBloc>(context).add(
                                            LoginRequested(
                                              username: _email.text,
                                              password: _password.text,
                                            ),
                                          );
                                        },
                                  child: isLoading
                                      ? const CircularProgressIndicator(color: Colors.white)
                                      : const Text('Se connecter'),
                                ),
                              ),
                              const SizedBox(height: 25),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Je n\'ai pas de compte? ',
                                    style: TextStyle(color: Colors.black45),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (e) => const SignUpScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'S\'inscrire',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: lightColorScheme.primary,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
