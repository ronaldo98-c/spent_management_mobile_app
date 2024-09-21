import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spent_mananagement_mobile/blocs/app.dart';
import 'package:spent_mananagement_mobile/screens/home.dart';
import 'package:spent_mananagement_mobile/controllers/login_controller.dart';
import 'package:spent_mananagement_mobile/screens/authentication/signin_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final LoginController loginController = LoginController();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc(loginController: loginController)..add(AppStarted()), // Fournir le bloc ici
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            if (state is AuthenticatedState) {
              return const HomeScreen();
            } else {
              return const SignInScreen();
            }
          },
        ),
      ),
    );
  }
}
