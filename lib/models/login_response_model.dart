import 'package:jwt_decoder/jwt_decoder.dart';

class LoginResponse {
  final String accessToken;
  final String expiresAtUtc;
  final String refreshToken;
  final String name;

  LoginResponse({
    required this.accessToken,
    required this.expiresAtUtc,
    required this.refreshToken,
    required this.name,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final user = json['user'] is Map
        ? Map<String, dynamic>.from(json['user'] as Map)
        : <String, dynamic>{};

    final directName = (
            json['name'] ??
            json['fullName'] ??
            json['full_name'] ??
            user['name'] ??
            user['fullName'] ??
            user['full_name'] ??
            ''
        )
        .toString();

    final firstName = (
            user['firstName'] ??
            user['first_name'] ??
            json['firstName'] ??
            json['first_name'] ??
            ''
        )
        .toString();

    final lastName = (
            user['lastName'] ??
            user['last_name'] ??
            json['lastName'] ??
            json['last_name'] ??
            ''
        )
        .toString();

    final accessToken = (json['accessToken'] ?? json['token'] ?? '').toString();

    var fullName = directName.isNotEmpty
        ? directName
        : '$firstName $lastName'.trim();

    // لو لسه مفيش اسم، جرّبي تجيبيه من جوا الـ JWT accessToken
    // (بعض الـ APIs بترجع الاسم كـ claim جوا الـ token بس، مش في جسم الـ response)
    if (fullName.isEmpty && accessToken.isNotEmpty) {
      try {
        final decodedToken = JwtDecoder.decode(accessToken);
        final nameFromToken = (decodedToken['name'] ?? '').toString();
        if (nameFromToken.isNotEmpty) {
          fullName = nameFromToken;
        }
      } catch (_) {
        // لو الـ token مش قابل للـ decode، نتجاهل ونكمل بالـ fallback
      }
    }

    return LoginResponse(
      accessToken: accessToken,
      expiresAtUtc: (json['expiresAtUtc'] ?? '').toString(),
      refreshToken: (json['refreshToken'] ?? '').toString(),
      name: fullName.isNotEmpty ? fullName : 'user',
    );
  }
}