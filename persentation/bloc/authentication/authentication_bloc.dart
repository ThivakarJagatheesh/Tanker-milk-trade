import 'package:dairy_products/data/models/signup.dart';
import 'package:dairy_products/domain/entity/login_params.dart';
import 'package:dairy_products/domain/entity/no_params.dart';
import 'package:dairy_products/domain/use_case/gender_usecase.dart';
import 'package:dairy_products/domain/use_case/login_usecase.dart';
import 'package:dairy_products/domain/use_case/signup_usecase.dart';
import 'package:dairy_products/persentation/bloc/authentication/authentication_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc extends Cubit<AuthenticationState> {
  AuthenticationBloc(this.loginUsecase, this.signUpUsecase, this.genderUsecase)
      : super(AuthenticationInitial());
  final LoginUsecase loginUsecase;
  final SignUpUsecase signUpUsecase;
  final GenderUsecase genderUsecase;

  void loginCubit({required String email, password}) async {
    emit(AuthenticationLoading());
    final response = await loginUsecase(LoginParams(email, password));
    emit(response.fold((l) => AuthenticationFailure(errorMessage: l.errorMsg),
        (r) => AuthenticationLoginState()));
  }

  void signupCubit({required SignupModel signupModel}) async {
    emit(AuthenticationLoading());
    final response = await signUpUsecase(signupModel);
    emit(response.fold((l) => AuthenticationFailure(errorMessage: l.errorMsg),
        (r) => AuthenticationSignupState()));
  }

  void genderCubit() async {
    emit(AuthenticationLoading());
    final response = await genderUsecase(NoParams());
    emit(response.fold((l) => AuthenticationFailure(errorMessage: l.errorMsg),
        (r) => AuthenticationGenderState(r)));
  }
}
