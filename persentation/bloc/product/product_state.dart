import 'package:dairy_products/data/models/district.dart';
import 'package:dairy_products/data/models/post_buy_shell_model.dart';
import 'package:dairy_products/data/models/product_model.dart';
import 'package:dairy_products/data/models/state.dart';
import 'package:equatable/equatable.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductSuccess extends ProductState {}

class StateListSuccess extends ProductState {
  final StateModel stateModel;
  StateListSuccess(this.stateModel);
  @override
  List<Object> get props => [stateModel];
}

class DistrictListSuccess extends ProductState {
   final DistrictModel districtModel;
  DistrictListSuccess(this.districtModel);
  @override
  List<Object> get props => [districtModel];
}

class ProductListState extends ProductState {
  final ShellBuyModel shellBuyModel;
  ProductListState(this.shellBuyModel);
}

class ProductHistoryState extends ProductState {}

class ProductTypeState extends ProductState {
    final ProductModel productModel;
  ProductTypeState(this.productModel);
}

class SubProductTypeState extends ProductState {
   final ProductModel productModel;
  SubProductTypeState(this.productModel);
}

class ProductFailure extends ProductState {
  final String errorMessage;
  ProductFailure({required this.errorMessage});
}
