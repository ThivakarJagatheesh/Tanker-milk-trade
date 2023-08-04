import 'package:dairy_products/data/models/profile_model.dart';
import 'package:dairy_products/domain/entity/no_params.dart';
import 'package:dairy_products/domain/use_case/add_trade_account_usecase.dart';
import 'package:dairy_products/domain/use_case/district_usecase.dart';
import 'package:dairy_products/domain/use_case/get_profile_list_usecase.dart';
import 'package:dairy_products/domain/use_case/get_trade_nature_usecase.dart';
import 'package:dairy_products/domain/use_case/get_trade_type_usecase.dart';
import 'package:dairy_products/domain/use_case/state_usecase.dart';
import 'package:dairy_products/domain/use_case/update_trade_usecase.dart';
import 'package:dairy_products/persentation/bloc/profile_trade/profile_trade_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileTradeBloc extends Cubit<ProfileTradeState> {
  ProfileTradeBloc(
      this.addTradeAccountUsecase,
      this.getProfileListUsecase,
      this.getTradeNatureUsecase,
      this.getTradeTypeUsecase,
      this.updateTradeAccountUsecase,this.districtUsecase,this.stateUsecase)
      : super(ProfileTradeInitial());

  final AddTradeAccountUsecase addTradeAccountUsecase;
  final GetProfileListUsecase getProfileListUsecase;
  final GetTradeNatureUsecase getTradeNatureUsecase;
  final GetTradeTypeUsecase getTradeTypeUsecase;
  final UpdateTradeAccountUsecase updateTradeAccountUsecase;
  final StateUsecase stateUsecase;
  final DistrictUsecase districtUsecase;

  void addTradeAccount(ProfileBody profileBody) async {
    // emit(ProfileTradeLoading());
    final response = await addTradeAccountUsecase(profileBody);
    emit(response.fold(
        (l) => ProfileTradeFailure(l.errorMsg), (r) => ProfileTradeSuccess()));
  }

  void getProfileList({int? userId}) async {
    emit(ProfileTradeLoading());
    final response = await getProfileListUsecase(userId);
    emit(response.fold(
        (l) => ProfileTradeFailure(l.errorMsg), (r) => ProfileListState(r)));
  }
    void getStateList({int? userId}) async {
    emit(ProfileTradeLoading());
    final response = await stateUsecase(NoParams());
    emit(response.fold(
        (l) => ProfileTradeFailure(l.errorMsg), (r) => StateListSuccess(r)));
  }

   void getDistrictList({int? userId}) async {
    emit(ProfileTradeLoading());
    final response = await districtUsecase(NoParams());
    emit(response.fold(
        (l) => ProfileTradeFailure(l.errorMsg), (r) => DistrictListSuccess(r)));
  }

  void getTradeNature({String? id}) async {
    // emit(AuthenticationLoading());
    emit(ProfileTradeLoading());
    final response = await getTradeNatureUsecase(id);
    emit(response.fold(
        (l) => ProfileTradeFailure(l.errorMsg), (r) => TradeNatureState(r)));
  }

  void getTradeType({String? id}) async {
    // emit(AuthenticationLoading());
    emit(ProfileTradeLoading());
    final response = await getTradeTypeUsecase(id);
    emit(response.fold(
        (l) => ProfileTradeFailure(l.errorMsg), (r) => TradeTypeState(r)));
  }

  void updateTradeAccount(ProfileBody profileBody) async {
    emit(ProfileTradeLoading());
    final response = await updateTradeAccountUsecase(profileBody);
    emit(response.fold(
        (l) => ProfileTradeFailure(l.errorMsg), (r) => UpdateTradeState(r)));
  }
}
