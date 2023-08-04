import 'package:dairy_products/common/widgets/local_storage/shared_storage.dart';
import 'package:dairy_products/data/api_client/api_client.dart';
import 'package:dairy_products/data/remote_data_source/authentication_data_source.dart';
import 'package:dairy_products/data/remote_data_source/product_data_source.dart';
import 'package:dairy_products/data/remote_data_source/profile_trade_data_source.dart';
import 'package:dairy_products/data/repository_impl/authentication_repo_impl.dart';
import 'package:dairy_products/data/repository_impl/product_repo_impl.dart';
import 'package:dairy_products/data/repository_impl/profile_trade_repo_impl.dart';
import 'package:dairy_products/domain/repository/authentication.dart';
import 'package:dairy_products/domain/repository/product_repo.dart';
import 'package:dairy_products/domain/repository/profile_trade_repo.dart';
import 'package:dairy_products/domain/use_case/add_product_usecase.dart';
import 'package:dairy_products/domain/use_case/add_trade_account_usecase.dart';
import 'package:dairy_products/domain/use_case/district_usecase.dart';
import 'package:dairy_products/domain/use_case/gender_usecase.dart';
import 'package:dairy_products/domain/use_case/get_product_history_usecase.dart';
import 'package:dairy_products/domain/use_case/get_product_list_usecase.dart';
import 'package:dairy_products/domain/use_case/get_product_type_usecase.dart';
import 'package:dairy_products/domain/use_case/get_profile_list_usecase.dart';
import 'package:dairy_products/domain/use_case/get_sub_product_type_usecase.dart';
import 'package:dairy_products/domain/use_case/get_trade_nature_usecase.dart';
import 'package:dairy_products/domain/use_case/get_trade_type_usecase.dart';
import 'package:dairy_products/domain/use_case/login_usecase.dart';
import 'package:dairy_products/domain/use_case/signup_usecase.dart';
import 'package:dairy_products/domain/use_case/state_usecase.dart';
import 'package:dairy_products/domain/use_case/update_trade_usecase.dart';
import 'package:dairy_products/persentation/bloc/authentication/authentication_bloc.dart';
import 'package:dairy_products/persentation/bloc/dashboard/dashboard_cubit.dart';
import 'package:dairy_products/persentation/bloc/product/product_bloc.dart';
import 'package:dairy_products/persentation/bloc/profile_trade/profile_trade_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getItInstance = GetIt.instance;

Future<void> init() async {
  getItInstance.registerLazySingleton<Dio>(() => Dio(BaseOptions()));
  getItInstance.registerLazySingleton<SharedStorage>(() => SharedStorage());
  getItInstance
      .registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  getItInstance.registerLazySingleton<AuthenticationDataSource>(
      () => AuthenticationDataSourceImpl(getItInstance()));
  getItInstance.registerLazySingleton<ProductDataSource>(
      () => ProductDataSourceImpl(getItInstance()));
  getItInstance.registerLazySingleton<ProfileTradeDataSource>(
      () => ProfileTradeDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(getItInstance()));
  getItInstance.registerLazySingleton<ProductRepository>(
      () => ProductRepoImpl(getItInstance()));
  getItInstance.registerLazySingleton<ProfileTradeRepository>(
      () => ProfileTradeRepoImpl(getItInstance()));

  getItInstance
      .registerLazySingleton<LoginUsecase>(() => LoginUsecase(getItInstance()));
  getItInstance.registerLazySingleton<SignUpUsecase>(
      () => SignUpUsecase(getItInstance()));
  getItInstance.registerLazySingleton<GenderUsecase>(
      () => GenderUsecase(getItInstance()));

      getItInstance.registerLazySingleton<StateUsecase>(
      () => StateUsecase(getItInstance()));

      getItInstance.registerLazySingleton<DistrictUsecase>(
      () => DistrictUsecase(getItInstance()));

  getItInstance.registerLazySingleton<AddProductUsecase>(
      () => AddProductUsecase(getItInstance()));
  getItInstance.registerLazySingleton<GetProductListUsecase>(
      () => GetProductListUsecase(getItInstance()));
  getItInstance.registerLazySingleton<GetProductHistoryUsecase>(
      () => GetProductHistoryUsecase(getItInstance()));
  getItInstance.registerLazySingleton<GetProductTypeUsecase>(
      () => GetProductTypeUsecase(getItInstance()));
  getItInstance.registerLazySingleton<GetSubProductTypeUsecase>(
      () => GetSubProductTypeUsecase(getItInstance()));

  getItInstance.registerLazySingleton<AddTradeAccountUsecase>(
      () => AddTradeAccountUsecase(getItInstance()));
  getItInstance.registerLazySingleton<GetProfileListUsecase>(
      () => GetProfileListUsecase(getItInstance()));
  getItInstance.registerLazySingleton<GetTradeNatureUsecase>(
      () => GetTradeNatureUsecase(getItInstance()));
  getItInstance.registerLazySingleton<GetTradeTypeUsecase>(
      () => GetTradeTypeUsecase(getItInstance()));
  getItInstance.registerLazySingleton<UpdateTradeAccountUsecase>(
      () => UpdateTradeAccountUsecase(getItInstance()));

  getItInstance.registerFactory<AuthenticationBloc>(() => AuthenticationBloc(
        getItInstance(),
        getItInstance(),
        getItInstance(),
      ));

  getItInstance.registerFactory(() => ProductBloc(
        getItInstance(),
        getItInstance(),
        getItInstance(),
        getItInstance(),
        getItInstance(),getItInstance(),getItInstance()
      ));

  getItInstance.registerFactory(() => ProfileTradeBloc(
        getItInstance(),
        getItInstance(),
        getItInstance(),
        getItInstance(),
        getItInstance(),getItInstance(),getItInstance()
      ));

  getItInstance.registerFactory(() => DashboardBloc());
}
