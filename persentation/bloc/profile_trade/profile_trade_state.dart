import 'package:dairy_products/data/models/district.dart';
import 'package:dairy_products/data/models/json_res_exception.dart';
import 'package:dairy_products/data/models/profile_model.dart';
import 'package:dairy_products/data/models/state.dart';
import 'package:dairy_products/data/models/trade_nature_model.dart';
import 'package:dairy_products/data/models/trade_type_model.dart';
import 'package:equatable/equatable.dart';

abstract class ProfileTradeState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProfileTradeInitial extends ProfileTradeState {}

class ProfileTradeLoading extends ProfileTradeState {}

class ProfileTradeSuccess extends ProfileTradeState {}

class StateListSuccess extends ProfileTradeState {
  final StateModel stateModel;
  StateListSuccess(this.stateModel);
  @override
  List<Object> get props => [stateModel];
}

class DistrictListSuccess extends ProfileTradeState {
   final DistrictModel districtModel;
  DistrictListSuccess(this.districtModel);
  @override
  List<Object> get props => [districtModel];
}

class ProfileListState extends ProfileTradeState {
  final ProfileModel profileModel;
  ProfileListState(this.profileModel);
  @override
  List<Object> get props => [profileModel];
}

class TradeNatureState extends ProfileTradeState {
  final TradeNatureModel tradeNatureModel;
  TradeNatureState(this.tradeNatureModel);
  @override
  List<Object> get props => [tradeNatureModel];
}

class TradeTypeState extends ProfileTradeState {
  final TradeTypeModel tradeTypeModel;
  TradeTypeState(this.tradeTypeModel);
  @override
  List<Object> get props => [tradeTypeModel];
}

class UpdateTradeState extends ProfileTradeState {
  final Body message;
  UpdateTradeState(this.message);
  @override
  List<Object> get props => [message];
}

class ProfileTradeFailure extends ProfileTradeState {
  final String errorMessage;

  ProfileTradeFailure(this.errorMessage);
}
