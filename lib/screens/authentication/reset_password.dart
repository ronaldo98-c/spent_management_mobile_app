import 'package:flutter/material.dart';
import 'package:spent_mananagement_mobile/theme/theme.dart';
import 'package:spent_mananagement_mobile/controllers/api_controller.dart';
import 'package:spent_mananagement_mobile/screens/widgets/custom_scaffold.dart';
import 'package:spent_mananagement_mobile/screens/authentication/signin_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool isLoading = false;
  late ApiController apiController;
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    apiController = ApiController();
  }

  void resetPassword(obj) {
    setState(() => isLoading = true);
    apiController.postData('auth/change/password', obj).then((data) {
      setState(() => isLoading = false);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (e) => const SignInScreen()
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content:  Text("Password successfully reset")),
      );
    }).catchError((error) {
      setState(() => isLoading = false);
      debugPrint("Erreur lors de la récupération des données : ${error.toString()}");
    });
  }

  @override
  Widget build(BuildContext context) {
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
                        'Mot de passe oublié',
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer le nouveau mot de passe';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Nouveau mot de passe'),
                          hintText: 'Entrer le nouveau mot de passe',
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
                        controller: _confirmPassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez confirmer le mot de passe';
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
                      const SizedBox(height: 25),
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
                              resetPassword({
                                'email': _email.text,
                                'new_password': _password.text
                              });
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
  }
}
