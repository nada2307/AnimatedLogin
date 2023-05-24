import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

import '../animation_enum.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(BuildContext context) => BlocProvider.of(context);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isPassword = false;

  String email = 'nadanabil@gmail.com';
  String password = '123456789';

  bool isLookingLeft = false;
  bool isLookingRight = false;
  Artboard? riveArtBoard;

  late RiveAnimationController controllerIdle;
  late RiveAnimationController controllerHandsDown;
  late RiveAnimationController controllerHandsUp;
  late RiveAnimationController controllerFail;
  late RiveAnimationController controllerSuccess;
  late RiveAnimationController controllerLookIdle;
  late RiveAnimationController controllerLookDownRight;
  late RiveAnimationController controllerLookDownLeft;

  void starFunction() {
    controllerIdle = SimpleAnimation(AnimationEnum.idle.name);
    controllerHandsDown = SimpleAnimation(AnimationEnum.hands_down.name);
    controllerHandsUp = SimpleAnimation(AnimationEnum.hands_up.name);
    controllerFail = SimpleAnimation(AnimationEnum.fail.name);
    controllerSuccess = SimpleAnimation(AnimationEnum.success.name);
    controllerLookIdle = SimpleAnimation(AnimationEnum.look_idel.name);
    controllerLookDownLeft = SimpleAnimation(AnimationEnum.Look_down_left.name);
    controllerLookDownRight =
        SimpleAnimation(AnimationEnum.Look_down_right.name);
    isLookingLeft = false;
    isLookingRight = false;
    rootBundle.load('assets/login_screen_character.riv').then((value) {
      emit(FileLoadingState());
      final file = RiveFile.import(value);
      final Artboard artboard = file.mainArtboard;
      artboard.addController(controllerIdle);
      riveArtBoard = artboard;
      emit(FileLoadSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(FileLoadErrorState());
    });
  }

  void removeAllControllers() {
    riveArtBoard!.artboard.removeController(controllerIdle);
    riveArtBoard!.artboard.removeController(controllerLookIdle);
    riveArtBoard!.artboard.removeController(controllerLookDownRight);
    riveArtBoard!.artboard.removeController(controllerLookDownLeft);
    riveArtBoard!.artboard.removeController(controllerHandsDown);
    riveArtBoard!.artboard.removeController(controllerHandsUp);
    riveArtBoard!.artboard.removeController(controllerFail);
    riveArtBoard!.artboard.removeController(controllerSuccess);
    isLookingLeft = false;
    isLookingRight = false;
    print('Removed All');
  }

  void addIdleController() {
    removeAllControllers();
    riveArtBoard!.artboard.addController(controllerIdle);
    print('Idle');
    emit(AddIdleController());
  }

  void addLookIdleController() {
    removeAllControllers();
    riveArtBoard!.artboard.addController(controllerLookIdle);
    print('Look Idle');
    emit(AddLookIdleController());
  }

  void addFailController() {
    removeAllControllers();
    riveArtBoard!.artboard.addController(controllerFail);
    print('Fail');
    emit(AddFailController());
  }

  void addSuccessController() {
    removeAllControllers();
    riveArtBoard!.artboard.addController(controllerSuccess);
    print('Success');
    emit(AddSuccessController());
  }

  void addHandsUpController() {
    removeAllControllers();
    riveArtBoard!.artboard.addController(controllerHandsUp);
    print('Hands Up');
    emit(AddHandsUpController());
  }

  void addHandsDownController() {
    removeAllControllers();
    riveArtBoard!.artboard.addController(controllerHandsDown);
    print('Hands Down');
    emit(AddHandsDownController());
  }

  void addLookDownLeftController() {
    removeAllControllers();
    isLookingLeft = true;
    riveArtBoard!.artboard.addController(controllerLookDownLeft);
    print('Look Down Left');
    emit(AddLookDownLeftController());
  }

  void addLookDownRightController() {
    removeAllControllers();
    isLookingRight = true;
    riveArtBoard!.artboard.addController(controllerLookDownRight);
    print('Look Down Right');
    emit(AddLookDownRightController());
  }

  void checkForPasswordFocusNodeToChangeAnimationState(passwordFocusNode) {
    passwordFocusNode.addListener(() {
      if (passwordFocusNode.hasFocus) {
        addHandsUpController();
      } else if (!passwordFocusNode.hasFocus) {
        addHandsDownController();
      }
    });
  }

  void checkValidData() {
    Future.delayed(const Duration(seconds: 1), () {
      if (password == passwordController.text &&
          email == emailController.text) {
        addSuccessController();
      } else {
        addFailController();
      }
    });
  }
}
