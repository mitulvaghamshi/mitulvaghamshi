import 'package:flutter/material.dart';

@immutable
class const Product({
  required final int id,
  required final String image,
  required final String title,
  required final (String, Color) line1,
  required final (String, Color) line2,
});
