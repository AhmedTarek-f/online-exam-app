import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'nav_bar_state.dart';

@lazySingleton
class NavBarCubit extends Cubit<NavBarState> {
  NavBarCubit() : super(const NavBarInitial(0));

  void changeTab(int index) {
    if (!isClosed) {
      emit(NavBarInitial(index));
    }
  }
}
