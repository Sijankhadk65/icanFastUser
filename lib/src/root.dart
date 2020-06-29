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
      body: StreamBuilder<FirebaseUser>(
        stream: _bloc.currentUserStateStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
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
                child: snapshot.hasData
                    ? HomeScreen(
                        user: {
                          "name": snapshot.data.displayName,
                          "email": snapshot.data.email
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
