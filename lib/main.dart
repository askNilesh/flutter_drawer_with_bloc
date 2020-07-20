import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdrawerwithbloc/bloc/nav_drawer_bloc.dart';
import 'package:flutterdrawerwithbloc/bloc/nav_drawer_state.dart';
import 'package:flutterdrawerwithbloc/drawer_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navigation Drawer Demo',
      theme: ThemeData(primarySwatch: Colors.blue, scaffoldBackgroundColor: Colors.white),
      home: MyHomePage(),
    );
    ;
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  NavDrawerBloc _bloc;
  Widget _content;

  @override
  void initState() {
    super.initState();
    _bloc = NavDrawerBloc();
    _content = _getContentForState(_bloc.state.selectedItem);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider<NavDrawerBloc>(
      create: (BuildContext context) => _bloc,
      child: BlocListener<NavDrawerBloc, NavDrawerState>(
        listener: (BuildContext context, NavDrawerState state) {
          setState(() {
            _content = _getContentForState(state.selectedItem);
          });
        },
        child: BlocBuilder<NavDrawerBloc, NavDrawerState>(
          builder: (BuildContext context, NavDrawerState state) => Scaffold(
            drawer: NavDrawerWidget("AskNilesh", "rathodnilsrk@gmail.com"),
            appBar: AppBar(
              title: Text(_getAppbarTitle(state.selectedItem)),
              centerTitle: false,
              brightness: Brightness.light,
              backgroundColor: Colors.indigo,
            ),
            body: AnimatedSwitcher(
              switchInCurve: Curves.easeInExpo,
              switchOutCurve: Curves.easeOutExpo,
              duration: Duration(milliseconds: 300),
              child: _content,
            ),
          ),
        ),
      ));

  _getAppbarTitle(NavItem state) {
    switch (state) {
      case NavItem.homePage:
        return 'Home';
      case NavItem.profilePage:
        return 'Profile Page';
      case NavItem.orderPage:
        return 'My Orders';
      case NavItem.myCart:
        return 'My Cart';
      default:
        return '';
    }
  }

  _getContentForState(NavItem state) {
    switch (state) {
      case NavItem.homePage:
        return Center(
          child: Text(
            'Home Page',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      case NavItem.profilePage:
        return Center(
          child: Text(
            'Profile Page',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      case NavItem.orderPage:
        return Center(
          child: Text(
            'My Orders',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      case NavItem.myCart:
        return Center(
          child: Text(
            'My Cart',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      default:
        return Center(
          child: Text(
            'Home Page',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        );
    }
  }
}
