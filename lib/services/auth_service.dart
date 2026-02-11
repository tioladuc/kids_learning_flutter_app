import '../core/api_client.dart';
import '../models/user.dart';

class AuthService {
  static Future<User> login(String role, String login, String pwd) async {
    print({'role': role, 'login': login,  'pwd': pwd});
    /*final res = await ApiClient.dio.post(
      '/login',
      data: {'role': role, 'login': login,  'pwd': pwd},
    );*/
    
    return User(
      id: 'id',
      role: 'role',
      token: 'token',
      /*id: res.data['id'],
      role: res.data['role'],
      token: res.data['token'],*/
    );
  }
}
