import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fastuserapp/src/bloc/login_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';

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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey[300],
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(
                                  5,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                  top: 5,
                                  bottom: 5,
                                ),
                                child: Text(
                                  "HOME",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    color: Colors.grey[300],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            StreamBuilder<Map<String, dynamic>>(
                                stream: _loginBloc.homeLocation,
                                builder: (context, snapshot) {
                                  return snapshot.hasData
                                      ? Expanded(
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Text(
                                                  snapshot
                                                      .data['physicalLocation']
                                                      .toString()
                                                      .toUpperCase(),
                                                  style: GoogleFonts.nunito(
                                                    color: Colors.orange,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                icon:
                                                    Icon(EvaIcons.edit2Outline),
                                                onPressed: () async {
                                                  LocationResult result =
                                                      await showLocationPicker(
                                                    context,
                                                    "AIzaSyATdr7r2cCqiNWcgv9VQSYKf7k50Qzx7IY",
                                                    automaticallyAnimateToCurrentLocation:
                                                        true,
                                                    myLocationButtonEnabled:
                                                        true,
                                                    layersButtonEnabled: true,
                                                  );
                                                  _loginBloc.changeHomeLocation(
                                                    {
                                                      "lat": result
                                                          .latLng.latitude,
                                                      "lang": result
                                                          .latLng.longitude,
                                                      "physicalLocation":
                                                          result.address,
                                                    },
                                                  );
                                                },
                                              )
                                            ],
                                          ),
                                        )
                                      : RawMaterialButton(
                                          onPressed: () async {
                                            LocationResult result =
                                                await showLocationPicker(
                                              context,
                                              "AIzaSyATdr7r2cCqiNWcgv9VQSYKf7k50Qzx7IY",
                                              automaticallyAnimateToCurrentLocation:
                                                  true,
                                              myLocationButtonEnabled: true,
                                              layersButtonEnabled: true,
                                            );
                                            _loginBloc.changeHomeLocation(
                                              {
                                                "lat": result.latLng.latitude,
                                                "lang": result.latLng.longitude,
                                                "physicalLocation":
                                                    result.address,
                                              },
                                            );
                                          },
                                          padding: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                          ),
                                          child: Text(
                                            "SELECT A LOCATION",
                                            style: GoogleFonts.nunito(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          fillColor: Colors.orange,
                                        );
                                })
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey[300],
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(
                                  5,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                  top: 5,
                                  bottom: 5,
                                ),
                                child: Text(
                                  "OFFICE",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    color: Colors.grey[300],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            StreamBuilder<Map<String, dynamic>>(
                                stream: _loginBloc.officeLocation,
                                builder: (context, snapshot) {
                                  return snapshot.hasData
                                      ? Expanded(
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Text(
                                                  snapshot
                                                      .data['physicalLocation']
                                                      .toString()
                                                      .toUpperCase(),
                                                  style: GoogleFonts.nunito(
                                                    color: Colors.orange,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                icon:
                                                    Icon(EvaIcons.edit2Outline),
                                                onPressed: () async {
                                                  LocationResult result =
                                                      await showLocationPicker(
                                                    context,
                                                    "AIzaSyATdr7r2cCqiNWcgv9VQSYKf7k50Qzx7IY",
                                                    automaticallyAnimateToCurrentLocation:
                                                        true,
                                                    myLocationButtonEnabled:
                                                        true,
                                                    layersButtonEnabled: true,
                                                  );
                                                  _loginBloc
                                                      .changeOfficeLocation(
                                                    {
                                                      "lat": result
                                                          .latLng.latitude,
                                                      "lang": result
                                                          .latLng.longitude,
                                                      "physicalLocation":
                                                          result.address,
                                                    },
                                                  );
                                                },
                                              )
                                            ],
                                          ),
                                        )
                                      : RawMaterialButton(
                                          onPressed: () async {
                                            LocationResult result =
                                                await showLocationPicker(
                                              context,
                                              "AIzaSyATdr7r2cCqiNWcgv9VQSYKf7k50Qzx7IY",
                                              automaticallyAnimateToCurrentLocation:
                                                  true,
                                              myLocationButtonEnabled: true,
                                              layersButtonEnabled: true,
                                            );
                                            _loginBloc.changeOfficeLocation(
                                              {
                                                "lat": result.latLng.latitude,
                                                "lang": result.latLng.longitude,
                                                "physicalLocation":
                                                    result.address,
                                              },
                                            );
                                          },
                                          padding: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                          ),
                                          child: Text(
                                            "SELECT A LOCATION",
                                            style: GoogleFonts.nunito(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          fillColor: Colors.orange,
                                        );
                                })
                          ],
                        ),
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
