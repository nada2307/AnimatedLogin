import 'package:animated/core/resources/color_manager.dart';
import 'package:animated/core/resources/string_manager.dart';
import 'package:animated/login/login_screen.dart';
import 'package:animated/login/manager/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return BlocProvider(
      create: (context) => LoginCubit()..starFunction(),
      child: MaterialApp(
        title: StringManager.appName,
        theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            primary: ColorManager.mainColor,
          ),
          primaryColor: ColorManager.themeColor,
          scaffoldBackgroundColor: ColorManager.backGroundColor,
        ),
        debugShowCheckedModeBanner: false,
        home: const LoginScreen(),
      ),
    );
  }
}
