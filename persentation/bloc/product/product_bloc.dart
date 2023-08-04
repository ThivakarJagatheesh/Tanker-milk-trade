import 'package:dairy_products/data/models/post_buy_shell_model.dart';
import 'package:dairy_products/domain/entity/no_params.dart';
import 'package:dairy_products/domain/use_case/add_product_usecase.dart';
import 'package:dairy_products/domain/use_case/district_usecase.dart';
import 'package:dairy_products/domain/use_case/get_product_history_usecase.dart';
import 'package:dairy_products/domain/use_case/get_product_list_usecase.dart';
import 'package:dairy_products/domain/use_case/get_product_type_usecase.dart';
import 'package:dairy_products/domain/use_case/get_sub_product_type_usecase.dart';
import 'package:dairy_products/domain/use_case/state_usecase.dart';
import 'package:dairy_products/persentation/bloc/product/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Cubit<ProductState> {
  ProductBloc(
      this.productUsecase,
      this.getProductListUsecase,
      this.getProductHistoryUsecase,
      this.getProductTypeUsecase,
      this.getSubProductTypeUsecase,this.districtUsecase,this.stateUsecase)
      : super(ProductInitial());
  final AddProductUsecase productUsecase;
  final GetProductListUsecase getProductListUsecase;
  final GetProductHistoryUsecase getProductHistoryUsecase;
  final GetProductTypeUsecase getProductTypeUsecase;
  final GetSubProductTypeUsecase getSubProductTypeUsecase;
    final StateUsecase stateUsecase;
  final DistrictUsecase districtUsecase;

    void addProduct(ShellBuyBody postShellBuyModel) async {
    emit(ProductLoading());
    final response = await productUsecase(postShellBuyModel);
    emit(response.fold((l) => ProductFailure(errorMessage: l.errorMsg),
        (r) => ProductSuccess()));
  }

      void getProductList() async {
    emit(ProductLoading());
    final response = await getProductListUsecase(NoParams());
    emit(response.fold((l) => ProductFailure(errorMessage: l.errorMsg),
        (r) => ProductListState(r)));
  }
    void getStateList({int? userId}) async {
    emit(ProductLoading());
    final response = await stateUsecase(NoParams());
    emit(response.fold(
        (l) => ProductFailure(errorMessage:l.errorMsg), (r) => StateListSuccess(r)));
  }

   void getDistrictList({int? userId}) async {
    emit(ProductLoading());
    final response = await districtUsecase(NoParams());
    emit(response.fold(
        (l) => ProductFailure(errorMessage:l.errorMsg), (r) => DistrictListSuccess(r)));
  }
      void getProductHistory(int? userId) async {
   // emit(AuthenticationLoading());
    final response = await getProductHistoryUsecase(userId);
    emit(response.fold((l) => ProductFailure(errorMessage: l.errorMsg),
        (r) => ProductHistoryState()));
  }

      void getProductType(int? id) async {
   // emit(AuthenticationLoading());
    final response = await getProductTypeUsecase(id);
    emit(response.fold((l) => ProductFailure(errorMessage: l.errorMsg),
        (r) => ProductTypeState(r)));
  }

      void getSubProductType(int? id) async {
   // emit(AuthenticationLoading());
    final response = await getSubProductTypeUsecase(id);
    emit(response.fold((l) => ProductFailure(errorMessage: l.errorMsg),
        (r) => SubProductTypeState(r)));
  }

}
