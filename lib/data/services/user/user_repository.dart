import 'dart:io';

import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:profile/data/models/user.dart';
import 'package:profile/data/services/user/user_api.dart';

class UserRepository {
  final UserNetworkService networkService;
  UserRepository(this.networkService);

  // Future<Response> addUser(UserModel user) async {
  //   return await networkService.addUser(user);
  // }

  Future<List<UserModel>> getUsers() async {
    return await networkService.getUsers();
  }

  // Future<List<UserModel>> getUsersForMatching() async {
  //   return await networkService.getUsersForMatching();
  // }

  Future<UserModel> getUser(String username) async {
    return await networkService.getUser(username);
  }

  Future<Response> updateUser(UserModel user, File? image) async {
    return await networkService.updateUser(user, image);
  }

  Future<Response> updateAvatar(File image, UserModel user) async {
    return await networkService.updateAvatar(image, user);
  }
}
