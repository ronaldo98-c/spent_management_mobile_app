import 'package:spent_mananagement_mobile/services/base/app_exceptions.dart';

import 'app_event.dart';
import 'app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spent_mananagement_mobile/models/token.dart';
import 'package:spent_mananagement_mobile/models/user_model.dart';
import 'package:spent_mananagement_mobile/constants/message.dart';
import 'package:spent_mananagement_mobile/controllers/login_controller.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final LoginController loginController;

  AppBloc({required this.loginController}) : super(UnauthenticatedState()) {
    on<AppStarted>((event, emit) async {
      final bool hasToken = await loginController.hasToken();
      if (hasToken) {
        emit(AuthenticatedState());
      } else {
        emit(UnauthenticatedState());
      }
    });

    on<LoginRequested>((event, emit) async {
      emit(LoginLoadingState());
      try {
        final result = await loginController.login(event.username, event.password);
        if (result != null) {
          var userData = User.fromJson(result["data"]["user"]);
          var token = Token.fromJson(result["data"]["token"]);
          await loginController.persistUserData(userData.name);
          await loginController.persistToken(token.token);
          emit(AuthenticatedState());
        } else {
          emit(const LoginErrorState(AppMessages.unAuthorize));
        }
      } on InvalidException catch (e) {
        // Gérer l'exception spécifique `InvalidException`
        emit(LoginErrorState(e.message ?? "An unexpected error occurred"));
      } catch (e) {
        // Gérer toutes les autres exceptions
        emit(LoginErrorState("An unexpected error occurred: ${e.toString()}"));
      }
    });


    on<LoggedOut>((event, emit) async {
      await loginController.deleteToken();
      emit(UnauthenticatedState());
    });

    on<SignInRequested>((event, emit) async {
      emit(LoginLoadingState());
      try {
        final result = await loginController.signIn(
            event.name, event.email, event.password);
        if (result != null) {
          var userData = User.fromJson(result["data"]["user"]);
          var token = Token.fromJson(result["data"]["token"]);
          await loginController.persistUserData(userData.name);
          await loginController.persistToken(token.token);
          emit(AuthenticatedState());
        } else {
          emit(const LoginErrorState(AppMessages.unAuthorize));
        }
      } on InvalidException catch (e) {
        // Gérer l'exception spécifique `InvalidException`
        emit(LoginErrorState(e.message ?? "An unexpected error occurred"));
      } catch (e) {
        emit(const LoginErrorState(AppMessages.unAuthorize));
      }
    });
  }
}
