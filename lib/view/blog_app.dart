import 'package:blog_app/constants/colors.dart';
import 'package:blog_app/view/author/author_screen.dart';
import 'package:blog_app/view/blog/blog_screen.dart';
import 'package:blog_app/view_model/author_view_model.dart';
import 'package:blog_app/view_model/blog_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BlogApp extends StatefulWidget {
  const BlogApp({Key? key}) : super(key: key);

  @override
  State<BlogApp> createState() => _BlogAppState();
}

class _BlogAppState extends State<BlogApp> {
  bool useMaterial3 = true;
  bool useLightMode = true;
  int colorSelected = 0;

  late ThemeData themeData;

  @override
  initState() {
    super.initState();
    themeData = updateThemes(colorSelected, useMaterial3, useLightMode);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthorViewModel()),
        ChangeNotifierProvider(create: (context) => BlogViewModel())
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        themeMode: useLightMode ? ThemeMode.light : ThemeMode.dark,
        theme: themeData,
        routerConfig: router(),
      ),
    );
  }

  ThemeData updateThemes(int colorIndex, bool useMaterial3, bool useLightMode) {
    return ThemeData(
        colorSchemeSeed: colorOptions[colorSelected],
        useMaterial3: useMaterial3,
        brightness: useLightMode ? Brightness.light : Brightness.dark);
  }

  void handleDarkThemeChange() {
    setState(() {
      useLightMode = !useLightMode;
      themeData = updateThemes(colorSelected, useMaterial3, useLightMode);
    });
  }

  GoRouter router() {
    return GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const AuthorScreen(),
        ),
        GoRoute(
            path: '/blogs',
            builder: (context, state) => const BlogScreen()
        ),
      ],
    );
  }
}
