class NavDrawerState {
  final NavItem selectedItem;

  const NavDrawerState(this.selectedItem);
}

enum NavItem {
  homePage,
  profilePage,
  orderPage,
  myCart,
}
