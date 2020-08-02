import 'package:fastuserapp/src/bloc/dash_bloc.dart';
import 'package:fastuserapp/src/bloc/search_bloc.dart';
import 'package:fastuserapp/src/models/online_order.dart';
import 'package:fastuserapp/src/screens/cart_screen.dart';
import 'package:fastuserapp/src/screens/dash_screen.dart';
import 'package:fastuserapp/src/widgets/food_search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_menu_bloc.dart';
import '../bloc/login_bloc.dart';
import '../bloc/order_cart_bloc.dart';
import '../screens/profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

import './order_screen.dart';

class HomeScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  HomeScreen({Key key, @required this.user}) : super(key: key);

  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _currentPageIndex = 0;

  _changeCurrentPage(int page) {
    this.setState(() {
      _currentPageIndex = page;
    });
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  _configureFCM() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
      },
    );
  }

  PageController _pageController;

  CartMenuBloc _cartMenuBloc;
  @override
  void initState() {
    super.initState();
    _configureFCM();
    _pageController = PageController();
  }

  @override
  void didChangeDependencies() {
    _cartMenuBloc = Provider.of<CartMenuBloc>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    orderCartBloc.getCurrentLocation();
    orderCartBloc.getLocalOrder();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text(
              "FAST",
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              EvaIcons.search,
              color: Colors.orange[500],
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MultiProvider(
                    providers: [
                      Provider(
                        create: (_) => SearchBloc(),
                        dispose: (context, SearchBloc bloc) => bloc.dispose(),
                      ),
                      Provider(
                        create: (_) => CartMenuBloc(),
                        dispose: (context, CartMenuBloc bloc) => bloc.dispose(),
                      ),
                    ],
                    child: FoodSearchDelegate(
                      user: widget.user,
                    ),
                  ),
                ),
              );
            },
          ),
          Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.shopping_basket,
                  color: Colors.orange[500],
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CartScreen(
                      user: widget.user,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 5,
                right: 3,
                child: StreamBuilder<List<OnlineOrder>>(
                  stream: orderCartBloc.localOrder,
                  builder: (context, snapshot) {
                    if (snapshot.hasError)
                      return Text("Error: ${snapshot.error}");
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Text("AW");
                        break;
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                        break;
                      case ConnectionState.active:
                        return SizedBox(
                          width: 20,
                          height: 20,
                          child: Material(
                            elevation: 10,
                            color: Colors.white,
                            type: MaterialType.circle,
                            child: Center(
                              child: Text(
                                snapshot.data
                                    .map((order) => order.cartLength)
                                    .toList()
                                    .fold(
                                        0,
                                        (previousValue, element) =>
                                            previousValue + element)
                                    .toString(),
                                style: GoogleFonts.oswald(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        );
                        break;
                      case ConnectionState.done:
                        return Text("TC");
                        break;
                    }

                    return null;
                  },
                ),
              ),
            ],
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            _changeCurrentPage(value);
            _pageController.animateToPage(
              value,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          currentIndex: _currentPageIndex,
          selectedIconTheme: IconThemeData(
            color: Colors.orange,
          ),
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                EvaIcons.homeOutline,
              ),
              title: Text(
                "HOME",
                style: GoogleFonts.nunito(
                  color: Colors.orange,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                EvaIcons.shoppingBagOutline,
              ),
              title: Text(
                "ORDERS",
                style: GoogleFonts.nunito(
                  color: Colors.orange,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                EvaIcons.personOutline,
              ),
              title: Text(
                "PROFILE",
                style: GoogleFonts.nunito(
                  color: Colors.orange,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ]),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: [
                MultiProvider(
                  providers: [
                    Provider(
                      create: (_) => CartMenuBloc(),
                    ),
                    Provider(
                      create: (_) => DashBloc(),
                    )
                  ],
                  child: DashScreen(
                    user: widget.user,
                  ),
                ),
                Provider(
                  create: (_) => CartBloc(),
                  dispose: (context, CartBloc bloc) => bloc.dispose(),
                  child: OrderScreen(user: widget.user),
                ),
                Provider(
                  create: (_) => LoginBloc(),
                  dispose: (context, LoginBloc bloc) => bloc.dispose(),
                  child: ProfileScreen(
                    email: widget.user['email'],
                  ),
                )
              ],
            ),
          ),
          // Positioned(
          //   child:
          // ),
        ],
      ),
    );
  }
}
