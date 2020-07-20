import 'package:bloc/bloc.dart';

import 'drawer_event.dart';
import 'nav_drawer_state.dart';

class NavDrawerBloc extends Bloc<NavDrawerEvent, NavDrawerState> {

  @override
  NavDrawerState get initialState => NavDrawerState(NavItem.homePage);

  @override
  Stream<NavDrawerState> mapEventToState(NavDrawerEvent event) async* {
    if (event is NavigateTo) {
      if (event.destination != state.selectedItem) {
        yield NavDrawerState(event.destination);
      }
    }
  }
}
