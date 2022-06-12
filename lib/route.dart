import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile/bloc/authentication/authentication_cubit.dart';
import 'package:profile/bloc/login/login_cubit.dart';
import 'package:profile/bloc/sign_up/signUp_cubit.dart';
import 'package:profile/bloc/user/user_cubit.dart';
import 'package:profile/constants/locator.dart';
import 'package:profile/constants/paths.dart';
import 'package:profile/data/models/user.dart';
import 'package:profile/data/services/authentication/auth_repository.dart';
import 'package:profile/data/services/login/login_repository.dart';
import 'package:profile/data/services/sign_up/sign_up_repository.dart';
import 'package:profile/data/services/user/user_repository.dart';
import 'package:profile/ui/screens/authentication_screen.dart';
import 'package:profile/ui/screens/home_screen.dart';
import 'package:profile/ui/screens/login_screen.dart';
import 'package:profile/ui/screens/profile_screen.dart';
import 'package:profile/ui/screens/signUp_screen.dart';
import 'package:profile/ui/screens/updateUser_screen.dart';
import 'package:profile/ui/widgets/profile_widget.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AUTH:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
            AuthenticationCubit(getIt<AuthenticationRepository>())..auth(),
            child: const AuthenticationScreen(),
          ),
        );
      case LOGIN:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LogInCubit(getIt<LoginRepository>()),
            // child: const LogInPage(),
            child: const LogInPage(),
          ),
        );
    // case HOME:
    //   getIt.unSignUp<TweetCubit>();
    //   getIt.SignUpSingleton(TweetCubit(getIt<TweetRepository>()));
    //   getIt.unSignUp<CommentCubit>();
    //   getIt.SignUpSingleton(CommentCubit(getIt<CommentRepository>()));
    //   return CupertinoPageRoute(
    //       builder: (_) => MultiBlocProvider(
    //         providers: [
    //           BlocProvider(
    //             create: (context) => getIt<TweetCubit>()..fetchTweets(),
    //           ),
    //           BlocProvider(
    //             create: (context) => getIt<CommentCubit>(),
    //           ),
    //         ],
    //         child: const HomePage(),
    //       )
    //   );
      case SIGNUP:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SignUpCubit(getIt<SignUpRepository>()),
            child: const SignUpPage(),
          ),
        );
      case HOME:
        getIt.unregister<UserCubit>();
        getIt.registerSingleton(UserCubit(getIt<UserRepository>()));
        return CupertinoPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<UserCubit>(),
            child: const MyProfileScreen(),
          ),
        );
      // case PROFILE:
      //   final UserModel args = settings.arguments as UserModel;
      //   return CupertinoPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (context) => getIt<UserCubit>(),
      //       child: ProfileScreen(user: args),
      //     ),
      //   );
      case UPDATE:
        if (getIt.isRegistered<UserCubit>()) {
          getIt.unregister<UserCubit>();
        }

        getIt.registerSingleton(UserCubit(getIt<UserRepository>()));
        final UserModel args = settings.arguments as UserModel;
        return CupertinoPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<UserCubit>(),
            child: UpdateUserScreen(user: args),
          ),
        );
      case ROOT:
        if (getIt.isRegistered<UserCubit>()) {
          getIt.unregister<UserCubit>();
        }

        getIt.registerSingleton(UserCubit(getIt<UserRepository>()));
        final UserModel args = settings.arguments as UserModel;
        return CupertinoPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<UserCubit>(),
            child: UpdateUserScreen(user: args),
          ),
        );
      default:
        return null;
    }
  }
}
