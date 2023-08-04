import 'package:dairy_products/data/models/apperror.dart';
import 'package:dairy_products/domain/entity/no_params.dart';
import 'package:dairy_products/domain/repository/product_repo.dart';
import 'package:dairy_products/domain/use_case/use_case.dart';
import 'package:dartz/dartz.dart';

class GetProductListUsecase extends UseCase<dynamic, NoParams> {
  final ProductRepository productRepository;
  GetProductListUsecase(this.productRepository);

  @override
  Future<Either<AppError, dynamic>> call(NoParams params) async {
    return await productRepository.getProductList();
  }
}