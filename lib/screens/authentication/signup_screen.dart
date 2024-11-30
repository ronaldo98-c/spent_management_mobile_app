import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spent_mananagement_mobile/blocs/app.dart';
import 'package:spent_mananagement_mobile/theme/theme.dart';
import 'package:spent_mananagement_mobile/screens/home.dart';
import 'package:spent_mananagement_mobile/screens/widgets/custom_scaffold.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AppBloc, AppState>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if(state is AuthenticatedState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (e) =>  const HomeScreen(),
              ),
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
                                'Créer un compte',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900,
                                  color: lightColorScheme.primary,
                                ),
                              ),
                              const SizedBox(height: 40),
                              TextFormField(
                                controller: _name,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez entrer votre nom';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  label: const Text('Nom'),
                                  hintText: 'Entrez votre nom',
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez entrer le mot de passe';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  label: const Text('Mot de passe'),
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
                              TextFormField(
                                controller: _confirmPassword,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez entrer votre e-mail';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  label: const Text('Confirmer le mot de passe'),
                                  hintText: 'Ressaisir le mot de passe',
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
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: isLoading
                                      ? null
                                      : () {
                                        if (_password.text != _confirmPassword.text) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text("Les mots de passe ne correspondent pas")),
                                          );
                                          return; // Exit if passwords do not match
                                        }
                                        BlocProvider.of<AppBloc>(context).add(
                                          SignInRequested(
                                            name: _name.text,
                                            email: _email.text,
                                            password: _password.text,
                                          ),
                                        );
                                      },
                                  child: isLoading
                                      ? const CircularProgressIndicator(color: Colors.white)
                                      : const Text('Enregistrer'),
                                ),
                              ),
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
