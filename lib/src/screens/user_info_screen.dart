import 'package:fastuserapp/src/bloc/login_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserInfoScreen extends StatefulWidget {
  final FirebaseUser user;

  const UserInfoScreen({Key key, this.user}) : super(key: key);
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  LoginBloc _loginBloc;

  @override
  void didChangeDependencies() {
    _loginBloc = Provider.of<LoginBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Material(
          child: Column(
            children: <Widget>[
              StreamBuilder<String>(
                  stream: _loginBloc.name,
                  builder: (context, snapshot) {
                    return TextField(
                      onChanged: _loginBloc.changeName,
                    );
                  }),
              StreamBuilder<String>(
                  stream: _loginBloc.phoneNumber,
                  builder: (context, snapshot) {
                    return TextField(
                      onChanged: _loginBloc.changePhoneNumber,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(),
                    );
                  }),
              StreamBuilder<bool>(
                  stream: _loginBloc.canSubmitData(),
                  builder: (context, snapshot) {
                    return RawMaterialButton(
                      onPressed: snapshot.hasData
                          ? () => _loginBloc.saveUser(widget.user)
                          : null,
                      fillColor:
                          snapshot.hasData ? Colors.orange[800] : Colors.grey,
                      child: Text("Save Info"),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
