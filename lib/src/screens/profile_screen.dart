import 'package:cached_network_image/cached_network_image.dart';
import 'package:fastuserapp/src/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/login_bloc.dart';

import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  final String email;

  const ProfileScreen({Key key, this.email}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  LoginBloc _loginBloc;
  @override
  void didChangeDependencies() {
    _loginBloc = Provider.of<LoginBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: StreamBuilder<User>(
          builder: (context, snapshot) {
            if (snapshot.hasError) return Text("Error:${snapshot.error}");
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text("Awaiting Bids");
                break;
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
                break;
              case ConnectionState.active:
                return Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CachedNetworkImage(
                          imageUrl: snapshot.data.photoURI,
                          placeholder: (context, msg) => Center(
                            child: CircularProgressIndicator(),
                          ),
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(7, 7),
                                    blurRadius: 10,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(50),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  snapshot.data.name.toUpperCase(),
                                  style: GoogleFonts.oswald(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.email),
                                    Text(
                                      snapshot.data.email,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 10,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  snapshot.data.phoneNumber.toString(),
                                  style: GoogleFonts.montserrat(
                                    fontSize: 10,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                );
                break;
              case ConnectionState.done:
                return Text("The task has completed");
                break;
            }
            return null;
          },
          stream: _loginBloc.getUser(widget.email),
        ),
      ),
    );
  }
}
