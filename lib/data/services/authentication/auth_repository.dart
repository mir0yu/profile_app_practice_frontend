import 'package:profile/data/services/authentication/auth_api.dart';

class AuthenticationRepository {
  final AuthenticationNetworkService networkService;
  AuthenticationRepository(this.networkService);

  Future<bool> auth() async {
    return await networkService.auth();
  }
}