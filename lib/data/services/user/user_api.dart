import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:profile/constants/paths.dart';
import 'package:profile/constants/storage.dart';
import 'package:profile/data/models/user.dart';

class UserNetworkService {
  getUsers() async {
    try {
      String? t = await storage.read(key: 'token');
      String? token = t.toString();

      final response = await http.get(
        Uri.parse('$BASE_URL/users/'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $token'
        },
      );
      var rawUsers = jsonDecode(utf8.decode(response.bodyBytes));
      List<UserModel> users = rawUsers['results']
          .map<UserModel>((user) => UserModel.fromJson((user)))
          .toList();
      print(users);
      return users;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserModel.withError("Data not found / Connection issue");
    }
  }

  getUser(String username) async {
    try {
      String? t = await storage.read(key: 'token');
      String? token = t.toString();

      final response = await http.get(
        Uri.parse('$BASE_URL/users/$username'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $token'
        },
      );
      var rawUser= jsonDecode(utf8.decode(response.bodyBytes));
      UserModel user = UserModel.fromJson((rawUser));
      print(username);

      if (username == 'me' && response.statusCode == 200) {
          await storage.write(key: 'id', value: user.id.toString());
      }
      print(user.avatar);
      return user;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserModel.withError("Data not found / Connection issue");
    }
  }

  // getUsersForMatching() async {
  //   try {
  //     String? t = await storage.read(key: 'token');
  //     String? token = t.toString();
  //
  //     final response = await http.get(
  //       Uri.parse('$BASE_URL/recommend/'),
  //       headers: {
  //         "Content-Type": "application/json",
  //         "Authorization": 'Bearer $token'
  //       },
  //     );
  //     var rawUsers = jsonDecode(utf8.decode(response.bodyBytes));
  //     List<UserModel> users = rawUsers['results']
  //         .map<UserModel>((user) => UserModel.fromJson((user)))
  //         .toList();
  //     print(users);
  //     return users;
  //   } catch (error, stacktrace) {
  //     print("Exception occured: $error stackTrace: $stacktrace");
  //     return UserModel.withError("Data not found / Connection issue");
  //   }
  // }

  updateUser(UserModel user, File? image) async {
    String? t = await storage.read(key: 'token');
    String? token = t.toString();

    int? userId = user.id;

    // final response = await http.patch(Uri.parse('$BASE_URL/users/$userId/'),
    //   headers: {
    //     "Content-Type": "application/json",
    //     "Authorization": 'Bearer $token'
    //   },
    //   body: jsonEncode({
    //     "first_name": user.firstName,
    //     "last_name": user.lastName,
    //     // "avatar": user.avatar,
    //     "gender": user.gender
    //   })
    // );
    var request = await http.MultipartRequest('PATCH', Uri.parse('$BASE_URL/users/$userId/'));
    request.headers['Content-type'] = "application/json";
    request.headers['Authorization'] = 'Bearer $token';
    if (user.firstName != null) {
      request.fields['first_name'] =  user.firstName!;
    }
    if (user.lastName != null) {
      request.fields['last_name'] =  user.lastName!;
    }
    if (user.gender != null) {
      request.fields['gender'] =  user.gender!;
    }
    if (image != null) {
      request.files.add(http.MultipartFile.fromBytes('avatar', image.readAsBytesSync(), filename: image.path));
    }
    var res = await request.send();
    final response = await http.Response.fromStream(res);
    print(response.body);
    return response;
  }

  updateAvatar(File image, UserModel user) async {
    String? t = await storage.read(key: 'token');
    String? token = t.toString();

    int? userId = user.id;

    var request = await http.MultipartRequest('PATCH', Uri.parse('$BASE_URL/users/$userId/'));
    request.headers['Content-type'] = "application/json";
    request.headers['Authorization'] = 'Bearer $token';
    request.files.add(http.MultipartFile.fromBytes('avatar', image.readAsBytesSync(), filename: image.path));
    var res = await request.send();
    final response = await http.Response.fromStream(res);
    print(response.body);
    return response;
  }
  // getAllUserTweets()
}
