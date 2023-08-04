import 'package:dairy_products/data/models/apperror.dart';
import 'package:dairy_products/data/models/state.dart';
import 'package:dairy_products/domain/entity/no_params.dart';
import 'package:dairy_products/domain/repository/profile_trade_repo.dart';
import 'package:dairy_products/domain/use_case/use_case.dart';
import 'package:dartz/dartz.dart';

class StateUsecase extends UseCase<StateModel, NoParams> {
  final ProfileTradeRepository profileTradeRepository;
  StateUsecase(this.profileTradeRepository);
  @override
  Future<Either<AppError, StateModel>> call(NoParams params) async {
    return await profileTradeRepository.stateList();
  }
}
