import 'package:dairy_products/persentation/bloc/dashboard/dashboard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardBloc extends Cubit<DashboardState> {
  DashboardBloc() : super(DashboardInitial());

  void selectedItems(int index) {
    if (index == 0) {
      emit(HomeState());
    } else if (index == 1) {
      emit(ServicesState());
    } else if (index == 2) {
      emit(SupportState());
    } else if (index == 3) {
      emit(SettingState());
    }
  }
}
