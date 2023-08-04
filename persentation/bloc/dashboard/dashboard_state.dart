import 'package:equatable/equatable.dart';

abstract class DashboardState extends Equatable {
  @override
  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class HomeState extends DashboardState {}
class ServicesState extends DashboardState {}
class SupportState extends DashboardState {}
class SettingState extends DashboardState {}
class DashboardFailure extends DashboardState {
  final String errorMessage;
  DashboardFailure({required this.errorMessage});
}

