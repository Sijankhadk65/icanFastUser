import 'package:fastuserapp/src/models/user.dart';
import 'package:fastuserapp/src/models/user_location.dart';
import 'package:fastuserapp/src/screens/user_info_screen.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import './bloc/cart_menu_bloc.dart';
import './bloc/login_bloc.dart';
import './screens/home_screen.dart';
import './screens/login_screen.dart';

import 'package:provider/provider.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  LoginBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = Provider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User>(
        stream: _bloc.currentUserStateStream,
        builder: (context, userSnapshot) {
          if (userSnapshot.hasError)
            return Text('Error: ${userSnapshot.error}');
          switch (userSnapshot.connectionState) {
            case ConnectionState.none:
              return Text('Select lot');
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            case ConnectionState.active:
              return MultiProvider(
                providers: [
                  Provider(
                    create: (_) => LoginBloc(),
                    dispose: (context, LoginBloc bloc) => bloc.dispose(),
                  ),
                  Provider(
                    create: (_) => CartMenuBloc(),
                    dispose: (context, CartMenuBloc bloc) => bloc.dispose(),
                  ),
                ],
                child: userSnapshot.hasData
                    ? StreamBuilder<bool>(
                        stream: _bloc.getUserStatus(userSnapshot.data.email),
                        builder: (context, snapshot) {
                          if (snapshot.hasError)
                            return Text("Error: ${snapshot.error}");
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return Text("Awaitng Bids....");
                              break;
                            case ConnectionState.waiting:
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                              break;
                            case ConnectionState.active:
                              return snapshot.data == true
                                  ? StreamBuilder<FastUser>(
                                      stream: _bloc
                                          .getUser(userSnapshot.data.email),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasError)
                                          return Text(
                                              "Error: ${snapshot.error}");
                                        switch (snapshot.connectionState) {
                                          case ConnectionState.none:
                                            return Text("Awaiting bids....");
                                            break;
                                          case ConnectionState.waiting:
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                            break;
                                          case ConnectionState.active:
                                            return HomeScreen(
                                              user: {
                                                "name": snapshot.data.name,
                                                "email": snapshot.data.email,
                                                "phoneNumber":
                                                    snapshot.data.phoneNumber,
                                                "home":
                                                    convertUserLocationToJson(
                                                        snapshot.data.home),
                                                "office":
                                                    convertUserLocationToJson(
                                                        snapshot.data.office),
                                              },
                                            );
                                            break;
                                          case ConnectionState.done:
                                            return Text(
                                                "The task has completed");
                                            break;
                                        }
                                        return null;
                                      },
                                    )
                                  :
                                  // IntroPage(
                                  //     user: userSnapshot.data,
                                  //   );
                                  UserInfoScreen(
                                      user: userSnapshot.data,
                                    );
                              break;
                            case ConnectionState.done:
                              return Text("The task has Completed");
                              break;
                          }
                          return null;
                        },
                      )
                    : LoginScreen(),
              );
            default:
              return Container();
          }
        },
      ),
    );
  }
}
