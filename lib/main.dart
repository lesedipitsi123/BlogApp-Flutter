import 'package:blog_app/view/blog_app.dart';
import 'package:flutter/material.dart';
import 'setup_locator.dart';

void main() {
  configureDependencies();
  runApp(const BlogApp());
}