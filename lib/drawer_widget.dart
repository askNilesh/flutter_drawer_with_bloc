import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdrawerwithbloc/bloc/drawer_event.dart';
import 'package:flutterdrawerwithbloc/bloc/nav_drawer_bloc.dart';
import 'package:flutterdrawerwithbloc/bloc/nav_drawer_state.dart';

class NavDrawerWidget extends StatelessWidget {
  final String accountName;
  final String accountEmail;
  final List<_NavigationItem> _listItems = [
    _NavigationItem(true, null, null, null),
    _NavigationItem(false, NavItem.homePage, "Home", Icons.home),
    _NavigationItem(false, NavItem.profilePage, "Profile Page", Icons.person),
    _NavigationItem(false, NavItem.orderPage, "My Orders", Icons.list),
    _NavigationItem(false, NavItem.myCart, "My Cart", Icons.shopping_cart),
  ];

  NavDrawerWidget(this.accountName, this.accountEmail);

  @override
  Widget build(BuildContext context) => Drawer(
          child: Container(
        child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: _listItems.length,
            itemBuilder: (BuildContext context, int index) =>
                BlocBuilder<NavDrawerBloc, NavDrawerState>(
                  builder: (BuildContext context, NavDrawerState state) =>
                      _buildItem(_listItems[index], state),
                )),
      ));

  Widget _buildItem(_NavigationItem data, NavDrawerState state) =>
      data.header ? _makeHeaderItem() : _makeListItem(data, state);

  Widget _makeHeaderItem() => UserAccountsDrawerHeader(
        accountName: Text(accountName, style: TextStyle(color: Colors.white)),
        accountEmail: Text(accountEmail, style: TextStyle(color: Colors.white)),
        decoration: BoxDecoration(color: Colors.indigo),
        currentAccountPicture: CircleAvatar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.amber,
          child: Icon(
            Icons.person,
            size: 54,
          ),
        ),
      );

  Widget _makeListItem(_NavigationItem data, NavDrawerState state) => Card(
        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.zero),
        borderOnForeground: true,
        elevation: 0,
        margin: EdgeInsets.zero,
        child: Builder(
          builder: (BuildContext context) => ListTile(
            title: Text(
              data.title,
              style: TextStyle(
                color: data.item == state.selectedItem ? Colors.green : Colors.blueGrey,
              ),
            ),
            leading: Icon(
              data.icon,
              color: data.item == state.selectedItem ? Colors.green : Colors.blueGrey,
            ),
            onTap: () => _handleItemClick(context, data.item),
          ),
        ),
      );

  void _handleItemClick(BuildContext context, NavItem item) {
    BlocProvider.of<NavDrawerBloc>(context).add(NavigateTo(item));
    Navigator.pop(context);
  }
}

class _NavigationItem {
  final bool header;
  final NavItem item;
  final String title;
  final IconData icon;

  _NavigationItem(this.header, this.item, this.title, this.icon);
}
