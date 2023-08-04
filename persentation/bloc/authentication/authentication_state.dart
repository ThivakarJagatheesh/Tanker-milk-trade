import 'package:dairy_products/data/models/gender.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationFailure extends AuthenticationState {
  final String errorMessage;
  AuthenticationFailure({required this.errorMessage});
}

class AuthenticationLoginState extends AuthenticationState {}

class AuthenticationSignupState extends AuthenticationState {}

class AuthenticationGenderState extends AuthenticationState {
  final GenderModel genderModel;
  AuthenticationGenderState(this.genderModel);
}
