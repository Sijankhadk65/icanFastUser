import 'package:fastuserapp/src/bloc/dash_bloc.dart';
import 'package:fastuserapp/src/models/vendor.dart';
import 'package:fastuserapp/src/screens/dash_screen.dart';
import 'package:fastuserapp/src/widgets/food_search_delegate.dart';
import 'package:fastuserapp/src/widgets/source_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_menu_bloc.dart';
import '../bloc/login_bloc.dart';
import '../bloc/order_cart_bloc.dart';
import '../screens/profile_screen.dart';
import 'package:provider/provider.dart';

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
  PageController _pageController;

  CartMenuBloc _cartMenuBloc;

  @override
  void initState() {
    super.initState();
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
    return Scaffold(
      appBar: AppBar(
        // bottom: PreferredSize(
        //   child: Container(
        //     margin: EdgeInsets.only(
        //       left: 15,
        //     ),
        //     child: Column(
        //       children: <Widget>[
        //         Row(
        //           children: <Widget>[
        //             StreamBuilder<Address>(
        //               builder: (context, snapshot) {
        //                 if (snapshot.hasError)
        //                   return Text("Error: ${snapshot.error}");
        //                 switch (snapshot.connectionState) {
        //                   case ConnectionState.none:
        //                     return Text("Awaiting bids....");
        //                     break;
        //                   case ConnectionState.waiting:
        //                     return Center(
        //                       child: CircularProgressIndicator(),
        //                     );
        //                     break;
        //                   case ConnectionState.active:
        //                     return Text(
        //                       snapshot.data.addressLine,
        //                       style: GoogleFonts.montserrat(
        //                         fontSize: 12,
        //                         fontWeight: FontWeight.bold,
        //                         fontStyle: FontStyle.italic,
        //                       ),
        //                     );
        //                     break;
        //                   case ConnectionState.done:
        //                     return Text("The task has completed....");
        //                     break;
        //                 }
        //                 return null;
        //               },
        //               stream: orderCartBloc.physicalLocation,
        //             ),
        //             Expanded(
        //               child: Icon(
        //                 EvaIcons.pin,
        //                 size: 18,
        //                 color: Colors.red,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ],
        //     ),
        //   ),
        //   preferredSize: Size.fromHeight(10),
        // ),
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
              showSearch(
                context: context,
                delegate: FoodSearchDelegate(),
              );
            },
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
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
          Positioned(
            child: Container(
              height: 50,
              width: 200,
              margin: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(50),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: IconButton(
                          icon: Icon(
                            EvaIcons.home,
                            color: Colors.orange[500],
                          ),
                          onPressed: () {
                            _pageController.animateToPage(
                              0,
                              duration: Duration(
                                milliseconds: 300,
                              ),
                              curve: Curves.easeIn,
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          icon: Icon(
                            Icons.shopping_cart,
                            color: Colors.orange[500],
                          ),
                          onPressed: () {
                            _pageController.animateToPage(
                              1,
                              duration: Duration(
                                milliseconds: 300,
                              ),
                              curve: Curves.easeIn,
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          icon: Icon(
                            EvaIcons.person,
                            color: Colors.orange[500],
                          ),
                          onPressed: () {
                            _pageController.animateToPage(
                              2,
                              duration: Duration(
                                milliseconds: 300,
                              ),
                              curve: Curves.easeIn,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
