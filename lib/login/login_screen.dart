import 'package:animated/core/helper.dart';
import 'package:animated/core/resources/color_manager.dart';
import 'package:animated/core/resources/string_manager.dart';
import 'package:animated/login/widgets/button_item_widget.dart';
import 'package:animated/login/widgets/defult_text_form_field_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

import 'manager/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final passwordFocusNode = FocusNode();

  @override
  void initState() {
    passwordFocusNode.addListener(() {
      if (passwordFocusNode.hasFocus) {
        print(passwordFocusNode.hasFocus);
        LoginCubit.get(context).addHandsUpController();
      } else if (!passwordFocusNode.hasFocus) {
        print(passwordFocusNode.hasFocus);

        LoginCubit.get(context).addHandsDownController();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = LoginCubit.get(context);
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: ColorManager.backGroundColor,
            title: Text(
              StringManager.appName,
              style: const TextStyle(color: ColorManager.mainColor),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: context.screenHeight / 3.5,
                    child: cubit.riveArtBoard != null
                        ? Rive(artboard: cubit.riveArtBoard!)
                        : const CupertinoActivityIndicator.partiallyRevealed(),
                  ),
                  SizedBox(
                    height: context.screenHeight * 0.03,
                  ),
                  Form(
                    key: cubit.formKey,
                    child: Column(
                      children: [
                        DefaultTextFormField(
                          controller: cubit.emailController,
                          label: StringManager.email,
                          keyboardType: TextInputType.emailAddress,
                          icon: Icons.email_outlined,
                          onChanged: (value) {
                            if (value.isNotEmpty &&
                                value.length < 15 &&
                                !cubit.isLookingLeft) {
                              cubit.addLookDownLeftController();
                            } else if (value.isNotEmpty &&
                                value.length >= 15 &&
                                !cubit.isLookingRight) {
                              cubit.addLookDownRightController();
                            } else if (value.isEmpty) {
                              cubit.addLookIdleController();
                            }
                          },
                          validation: (value) {
                            if (value!.isEmpty) {
                              return 'Email is Required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: context.screenHeight * 0.03,
                        ),
                        DefaultTextFormField(
                          focusNode: passwordFocusNode,
                          controller: cubit.passwordController,
                          label: StringManager.password,
                          keyboardType: TextInputType.visiblePassword,
                          icon: Icons.lock_outline_rounded,
                          isPassword: true,
                          isObscure: true,
                          validation: (value) {
                            if (value!.isEmpty) {
                              return 'Password is Required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: context.screenHeight * 0.03,
                        ),
                        ButtonItemWidget(
                          onPressed: () {
                            passwordFocusNode.unfocus();
                            if (cubit.formKey.currentState!.validate()) {
                              cubit.checkValidData();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
