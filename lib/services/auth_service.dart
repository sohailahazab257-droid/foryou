
import '../models/login_response_model.dart';
import 'api_services.dart';

class AuthService {


  static Future<LoginResponse> login(
      String email,
      String password,
      ) async {
    final response = await ApiServices.dio.post(
      '/api/auth/login',
      data: {
        'email': email,
        'password': password,
      },
    );
    return LoginResponse.fromJson(response.data);
  }


  static Future<void> register(
      String email,
      String firstName,
      String lastName,
      String password,
      ) async {
    await ApiServices.dio.post(
      '/api/auth/register',
      data: {
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'password': password,
      },
    );
  }

  

  static Future<void> forgotPassword(String email) async {
    await ApiServices.dio.post(
      '/api/auth/forgot-password',
      data: {
        'email': email,
      },
    );
  }

 

  static Future<void> validateOtp(
      String email,
      String otp,
      ) async {
    await ApiServices.dio.post(
      '/api/auth/validate-otp',
      data: {
        'email': email,
        'otp': otp,
      },
    );
  }

  static Future<void> verifyEmail(
      String email,
      String otp,
      ) async {
    await ApiServices.dio.post(
      '/api/auth/verify-email',
      data: {
        'email': email,
        'otp': otp,
      },
    );
  }


  static Future<void> resendOtp(String email) async {
    await ApiServices.dio.post(
      '/api/auth/resend-otp',
      data: {
        'email': email,
      },
    );
  }



  static Future<void> resetPassword(
      String email,
      String otp,
      String newPassword,
      ) async {
    await ApiServices.dio.post(
      '/api/auth/reset-password',
      data: {
        'email': email,
        'otp': otp,
        'newPassword': newPassword,
      },
    );
  }
}