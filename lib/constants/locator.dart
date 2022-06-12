import 'package:get_it/get_it.dart';
import 'package:profile/bloc/authentication/authentication_cubit.dart';
import 'package:profile/bloc/login/login_cubit.dart';
import 'package:profile/bloc/sign_up/signUp_cubit.dart';
import 'package:profile/bloc/user/user_cubit.dart';
import 'package:profile/data/services/authentication/auth_api.dart';
import 'package:profile/data/services/authentication/auth_repository.dart';
import 'package:profile/data/services/login/login_api.dart';
import 'package:profile/data/services/login/login_repository.dart';
import 'package:profile/data/services/sign_up/sign_up_api.dart';
import 'package:profile/data/services/sign_up/sign_up_repository.dart';
import 'package:profile/data/services/user/user_api.dart';
import 'package:profile/data/services/user/user_repository.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // LogIn
  getIt.registerSingleton(LoginNetworkService());
  getIt.registerSingleton(LoginRepository(getIt<LoginNetworkService>()));
  getIt.registerSingleton(LogInCubit(getIt<LoginRepository>()));

  // Authentication
  getIt.registerSingleton(AuthenticationNetworkService());
  getIt.registerSingleton(
      AuthenticationRepository(getIt<AuthenticationNetworkService>()));
  getIt.registerSingleton(
      AuthenticationCubit(getIt<AuthenticationRepository>()));
  //
  // Registration
  getIt.registerSingleton(SignUpNetworkService());
  getIt.registerSingleton(
      SignUpRepository(getIt<SignUpNetworkService>()));
  getIt.registerSingleton(
      SignUpCubit(getIt<SignUpRepository>()));
  //
  // User
  getIt.registerSingleton(UserNetworkService());
  getIt.registerSingleton(UserRepository(getIt<UserNetworkService>()));
  getIt.registerSingleton(UserCubit(getIt<UserRepository>()));

}