// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoginSuccessModel {
  final int id;
  final String email;
  final String username;
  final String password;
  final int token;
  final DateTime lease;
  final String role;
  final int isActive;
  final String secret;
  LoginSuccessModel({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.token,
    required this.lease,
    required this.role,
    required this.isActive,
    required this.secret,
  });

  LoginSuccessModel copyWith({
    int? id,
    String? email,
    String? username,
    String? password,
    int? token,
    DateTime? lease,
    String? role,
    int? isActive,
    String? secret,
  }) {
    return LoginSuccessModel(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      password: password ?? this.password,
      token: token ?? this.token,
      lease: lease ?? this.lease,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      secret: secret ?? this.secret,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'username': username,
      'password': password,
      'token': token,
      'lease': lease.millisecondsSinceEpoch,
      'role': role,
      'is_active': isActive,
      'secret': secret,
    };
  }

  factory LoginSuccessModel.fromMap(Map<String, dynamic> map) {
    return LoginSuccessModel(
      id: map['id'] as int,
      email: map['email'] as String,
      username: map['username'] as String,
      password: map['password'] as String,
      token: map['token'] as int,
      lease: DateTime.parse(map['lease'] as String),
      role: map['role'] as String,
      isActive: map['is_active'] as int,
      secret: map['secret'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginSuccessModel.fromJson(String source) =>
      LoginSuccessModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LoginSuccessModel(id: $id, email: $email, username: $username, password: $password, token: $token, lease: $lease, role: $role, isActive: $isActive, secret: $secret)';
  }

  @override
  bool operator ==(covariant LoginSuccessModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.email == email &&
        other.username == username &&
        other.password == password &&
        other.token == token &&
        other.lease == lease &&
        other.role == role &&
        other.isActive == isActive &&
        other.secret == secret;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        username.hashCode ^
        password.hashCode ^
        token.hashCode ^
        lease.hashCode ^
        role.hashCode ^
        isActive.hashCode ^
        secret.hashCode;
  }
}
