import 'package:dairy_products/data/models/apperror.dart';
import 'package:dairy_products/domain/repository/profile_trade_repo.dart';
import 'package:dairy_products/domain/use_case/use_case.dart';
import 'package:dartz/dartz.dart';

class GetTradeNatureUsecase extends UseCase<dynamic, String?> {
  final ProfileTradeRepository profileTradeRepository;
  GetTradeNatureUsecase(this.profileTradeRepository);

  @override
  Future<Either<AppError, dynamic>> call(String? params) async {
    return await profileTradeRepository.getTradeNature(params);
  }
}
