import 'package:equatable/equatable.dart';

class AppError extends Equatable {
  final AppErrorType appErrorType;
  final String errorMsg;

  const AppError(this.appErrorType,this.errorMsg);

  @override
  List<Object> get props => [appErrorType,errorMsg];
}

enum AppErrorType {
  api,
  network,
  database,
  unauthorised,
  sessionDenied,
  alreadyExist,
  notFound,
  dependencycontraint,
}