import 'package:flutter/material.dart';

@immutable
class User {
  final String uid;
  final String email;

  const User({
    @required this.uid,
    this.email,
  });
}
