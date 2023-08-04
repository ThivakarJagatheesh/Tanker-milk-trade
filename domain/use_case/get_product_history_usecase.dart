import 'package:dairy_products/data/models/apperror.dart';

import 'package:dairy_products/domain/repository/product_repo.dart';
import 'package:dairy_products/domain/use_case/use_case.dart';
import 'package:dartz/dartz.dart';

class GetProductHistoryUsecase extends UseCase<dynamic, int?> {
  final ProductRepository productRepository;
  GetProductHistoryUsecase(this.productRepository);

  @override
  Future<Either<AppError, dynamic>> call( params) async {
    return await productRepository.getProductHistoryBuyShell(params);
  }
}