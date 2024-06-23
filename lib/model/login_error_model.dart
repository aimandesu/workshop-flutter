// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class LoginErrorModel {
  final int status;
  final Map<String, dynamic> error;
  LoginErrorModel({
    required this.status,
    required this.error,
  });

  LoginErrorModel copyWith({
    int? status,
    Map<String, dynamic>? error,
  }) {
    return LoginErrorModel(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'error': error,
    };
  }

  factory LoginErrorModel.fromMap(Map<String, dynamic> map) {
    return LoginErrorModel(
        status: map['status'] as int,
        error: Map<String, dynamic>.from(
          (map['error'] as Map<String, dynamic>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory LoginErrorModel.fromJson(String source) =>
      LoginErrorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LoginErrorModel(status: $status, error: $error)';

  @override
  bool operator ==(covariant LoginErrorModel other) {
    if (identical(this, other)) return true;

    return other.status == status && mapEquals(other.error, error);
  }

  @override
  int get hashCode => status.hashCode ^ error.hashCode;
}
