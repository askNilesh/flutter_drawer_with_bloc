import 'nav_drawer_state.dart';
abstract class NavDrawerEvent {
const NavDrawerEvent();
}
class NavigateTo extends NavDrawerEvent {
final NavItem destination;
const NavigateTo(this.destination);
}