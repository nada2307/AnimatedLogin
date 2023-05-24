part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitialState extends LoginState {}

class FileLoadingState extends LoginState {}

class FileLoadSuccessState extends LoginState {}

class FileLoadErrorState extends LoginState {}

class AddIdleController extends LoginState {}

class AddLookIdleController extends LoginState {}

class AddLookDownLeftController extends LoginState {}

class AddLookDownRightController extends LoginState {}

class AddFailController extends LoginState {}

class AddSuccessController extends LoginState {}

class AddHandsUpController extends LoginState {}

class AddHandsDownController extends LoginState {}
