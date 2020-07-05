import 'package:fastuserapp/src/bloc/login_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: Container(
            margin: EdgeInsets.all(
              10,
            ),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: Center(
                    child: Text(
                      "User Info",
                      style: GoogleFonts.oswald(
                        fontSize: 55,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: Center(
                    child: Text(
                      "Please enter the name you'd like to be called as, and a number for your verification.",
                      style: GoogleFonts.oswald(
                        fontSize: 13,
                        color: Colors.orange[300],
                      ),
                    ),
                  ),
                ),
                Material(
                  borderRadius: BorderRadius.circular(
                    5,
                  ),
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.all(
                      10,
                    ),
                    child: Column(
                      children: <Widget>[
                        StreamBuilder<String>(
                          stream: _loginBloc.name,
                          builder: (context, snapshot) {
                            return TextField(
                              keyboardType: TextInputType.text,
                              onChanged: (value) {
                                _loginBloc.changeName(value);
                              },
                              decoration: InputDecoration(
                                labelText: "Name",
                                hintText: "Enter your name here.",
                                errorText: snapshot.error,
                              ),
                            );
                          },
                        ),
                        StreamBuilder<String>(
                            stream: _loginBloc.phoneNumber,
                            builder: (context, snapshot) {
                              return TextField(
                                onChanged: (value) {
                                  _loginBloc.changePhoneNumber(value);
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "Contact Number",
                                  hintText: "Enter your number here.",
                                  errorText: snapshot.error,
                                ),
                              );
                            }),
                        StreamBuilder<bool>(
                          stream: _loginBloc.canSubmitData,
                          builder: (context, snapshot) {
                            return RawMaterialButton(
                              onPressed: snapshot.hasData
                                  ? () => _loginBloc.saveUser(widget.user)
                                  : null,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  5,
                                ),
                              ),
                              fillColor: snapshot.hasData
                                  ? Colors.orange[800]
                                  : Colors.grey,
                              child: Text(
                                "Save Info",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  color: snapshot.hasData
                                      ? Colors.white
                                      : Colors.black38,
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
