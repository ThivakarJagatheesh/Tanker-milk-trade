import 'package:dairy_products/data/models/apperror.dart';
import 'package:dairy_products/data/models/post_buy_shell_model.dart';
import 'package:dairy_products/domain/repository/product_repo.dart';
import 'package:dairy_products/domain/use_case/use_case.dart';
import 'package:dartz/dartz.dart';

class AddProductUsecase extends UseCase<dynamic, ShellBuyBody> {
  final ProductRepository productRepository;
  AddProductUsecase(this.productRepository);

  @override
  Future<Either<AppError, dynamic>> call(ShellBuyBody params) async {
    return await productRepository.addProduct(params);
  }
}