import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fastuserapp/src/bloc/order_cart_bloc.dart';
import 'package:fastuserapp/src/models/order_ref.dart';
import 'package:fastuserapp/src/models/user.dart';
import 'package:fastuserapp/src/models/user_location.dart';
import 'package:fastuserapp/src/widgets/order_ref_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';

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
  PickResult _result;

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
        child: StreamBuilder<FastUser>(
          builder: (context, userSnapshot) {
            if (userSnapshot.hasError)
              return Text("Error:${userSnapshot.error}");
            switch (userSnapshot.connectionState) {
              case ConnectionState.none:
                return Text("Awaiting Bids");
                break;
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
                break;
              case ConnectionState.active:
                _loginBloc.changeHomeLocation(
                  convertUserLocationToJson(
                    userSnapshot.data.home,
                  ),
                );
                _loginBloc.changeOfficeLocation(
                  convertUserLocationToJson(
                    userSnapshot.data.office,
                  ),
                );

                orderCartBloc.getClosedOrderRefs(
                  {
                    "name": userSnapshot.data.name,
                    "email": userSnapshot.data.email,
                  },
                );
                return Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CachedNetworkImage(
                          imageUrl: userSnapshot.data.photoURI,
                          placeholder: (context, msg) => Center(
                            child: CircularProgressIndicator(),
                          ),
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0, 5),
                                      blurRadius: 5)
                                ],
                                borderRadius: BorderRadius.circular(
                                  5,
                                ),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  userSnapshot.data.name.toUpperCase(),
                                  style: GoogleFonts.oswald(
                                    fontSize: 35,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  userSnapshot.data.email,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 10,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  userSnapshot.data.phoneNumber.toString(),
                                  style: GoogleFonts.montserrat(
                                    fontSize: 10,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 4,
                                      child: StreamBuilder<String>(
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
                                                    LinearProgressIndicator(),
                                              );
                                              break;
                                            case ConnectionState.active:
                                              return Text(
                                                snapshot.data,
                                                style: GoogleFonts.nunito(
                                                  fontSize: 13,
                                                  color: Colors.orange,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              );
                                              break;
                                            case ConnectionState.done:
                                              return Text(
                                                  "The task has completed....");
                                              break;
                                          }
                                          return null;
                                        },
                                        stream: orderCartBloc.physicalLocation,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Icon(
                                        EvaIcons.pin,
                                        size: 18,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    top: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.orange[800],
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      5,
                                    ),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        FirebaseAuth.instance.signOut();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                        ),
                                        child: Text(
                                          "Logout",
                                          style: GoogleFonts.nunito(
                                            color: Colors.orange[800],
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 10,
                      ),
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(
                          5,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(
                            10,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 60,
                                width: 5,
                                margin: EdgeInsets.only(
                                  right: 5,
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.orange,
                                      Colors.white,
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "HOME",
                                      style: GoogleFonts.montserrat(
                                        color: Colors.grey[500],
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    StreamBuilder<Map<String, dynamic>>(
                                      stream: _loginBloc.homeLocation,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasError)
                                          return Text(
                                              "Error: ${snapshot.error}");
                                        switch (snapshot.connectionState) {
                                          case ConnectionState.none:
                                            return Text("Awaiting Bids......");
                                            break;
                                          case ConnectionState.waiting:
                                            return Center(
                                              child: LinearProgressIndicator(),
                                            );
                                            break;
                                          case ConnectionState.active:
                                            return snapshot.data['lat'] ==
                                                        null &&
                                                    snapshot.data['lat'] ==
                                                        null &&
                                                    snapshot.data[
                                                            'physicalLocation'] ==
                                                        null
                                                ? RawMaterialButton(
                                                    onPressed: () async {
                                                      await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              PlacePicker(
                                                            apiKey:
                                                                "AIzaSyATdr7r2cCqiNWcgv9VQSYKf7k50Qzx7IY",
                                                            onPlacePicked:
                                                                (result) {
                                                              this.setState(
                                                                () {
                                                                  _result =
                                                                      result;
                                                                },
                                                              );
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            useCurrentLocation:
                                                                true,
                                                          ),
                                                        ),
                                                      );
                                                      _loginBloc
                                                          .updateUserHomeLocation(
                                                              {
                                                            "lat": _result
                                                                .geometry
                                                                .location
                                                                .lat,
                                                            "lang": _result
                                                                .geometry
                                                                .location
                                                                .lng,
                                                            "physicalLocation":
                                                                _result
                                                                    .formattedAddress,
                                                          },
                                                              userSnapshot
                                                                  .data.email);
                                                    },
                                                    padding: EdgeInsets.only(
                                                      left: 10,
                                                      right: 10,
                                                    ),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        5,
                                                      ),
                                                    ),
                                                    child: Text(
                                                      "SELECT A LOCATION",
                                                      style: GoogleFonts.nunito(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                      ),
                                                    ),
                                                    fillColor: Colors.orange,
                                                  )
                                                : Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                          snapshot.data[
                                                                  'physicalLocation']
                                                              .toString()
                                                              .toUpperCase(),
                                                          style: GoogleFonts
                                                              .nunito(
                                                            fontSize: 13,
                                                            color:
                                                                Colors.orange,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: IconButton(
                                                          icon: Icon(
                                                            EvaIcons
                                                                .edit2Outline,
                                                            color: Colors
                                                                .grey[700],
                                                            size: 18,
                                                          ),
                                                          onPressed: () async {
                                                            await Navigator
                                                                .push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        PlacePicker(
                                                                  apiKey:
                                                                      "AIzaSyATdr7r2cCqiNWcgv9VQSYKf7k50Qzx7IY",
                                                                  onPlacePicked:
                                                                      (result) {
                                                                    this.setState(
                                                                      () {
                                                                        _result =
                                                                            result;
                                                                      },
                                                                    );
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  useCurrentLocation:
                                                                      true,
                                                                ),
                                                              ),
                                                            );
                                                            _loginBloc
                                                                .updateUserHomeLocation(
                                                                    {
                                                                  "lat": _result
                                                                      .geometry
                                                                      .location
                                                                      .lat,
                                                                  "lang": _result
                                                                      .geometry
                                                                      .location
                                                                      .lng,
                                                                  "physicalLocation":
                                                                      _result
                                                                          .formattedAddress,
                                                                },
                                                                    userSnapshot
                                                                        .data
                                                                        .email);
                                                          },
                                                        ),
                                                      )
                                                    ],
                                                  );
                                            break;
                                          case ConnectionState.done:
                                            return Text(
                                                "The task has completed");
                                            break;
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 60,
                                width: 5,
                                margin: EdgeInsets.only(
                                  left: 5,
                                  right: 5,
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.orange,
                                      Colors.white,
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "OFFICE",
                                      style: GoogleFonts.montserrat(
                                        color: Colors.grey[500],
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    StreamBuilder<Map<String, dynamic>>(
                                      stream: _loginBloc.officeLocation,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasError)
                                          return Text(
                                              "Error: ${snapshot.error}");
                                        switch (snapshot.connectionState) {
                                          case ConnectionState.none:
                                            return Text("Awaiting Bids......");
                                            break;
                                          case ConnectionState.waiting:
                                            return Center(
                                              child: LinearProgressIndicator(),
                                            );
                                            break;
                                          case ConnectionState.active:
                                            return snapshot.data['lat'] ==
                                                        null &&
                                                    snapshot.data['lat'] ==
                                                        null &&
                                                    snapshot.data[
                                                            'physicalLocation'] ==
                                                        null
                                                ? RawMaterialButton(
                                                    onPressed: () async {
                                                      await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              PlacePicker(
                                                            apiKey:
                                                                "AIzaSyATdr7r2cCqiNWcgv9VQSYKf7k50Qzx7IY",
                                                            onPlacePicked:
                                                                (result) {
                                                              this.setState(
                                                                () {
                                                                  _result =
                                                                      result;
                                                                },
                                                              );
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            useCurrentLocation:
                                                                true,
                                                          ),
                                                        ),
                                                      );
                                                      _loginBloc
                                                          .updateUserOfficeLocation(
                                                              {
                                                            "lat": _result
                                                                .geometry
                                                                .location
                                                                .lat,
                                                            "lang": _result
                                                                .geometry
                                                                .location
                                                                .lng,
                                                            "physicalLocation":
                                                                _result
                                                                    .formattedAddress,
                                                          },
                                                              userSnapshot
                                                                  .data.email);
                                                    },
                                                    padding: EdgeInsets.only(
                                                      left: 10,
                                                      right: 10,
                                                    ),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        5,
                                                      ),
                                                    ),
                                                    child: Text(
                                                      "SELECT A LOCATION",
                                                      style: GoogleFonts.nunito(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                      ),
                                                    ),
                                                    fillColor: Colors.orange,
                                                  )
                                                : Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        flex: 4,
                                                        child: Text(
                                                          snapshot.data[
                                                                  'physicalLocation']
                                                              .toString()
                                                              .toUpperCase(),
                                                          style: GoogleFonts
                                                              .nunito(
                                                            fontSize: 13,
                                                            color:
                                                                Colors.orange,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: IconButton(
                                                          icon: Icon(
                                                            EvaIcons
                                                                .edit2Outline,
                                                            color: Colors
                                                                .grey[700],
                                                            size: 18,
                                                          ),
                                                          onPressed: () async {
                                                            await Navigator
                                                                .push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        PlacePicker(
                                                                  apiKey:
                                                                      "AIzaSyATdr7r2cCqiNWcgv9VQSYKf7k50Qzx7IY",
                                                                  onPlacePicked:
                                                                      (result) {
                                                                    this.setState(
                                                                      () {
                                                                        _result =
                                                                            result;
                                                                      },
                                                                    );
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  useCurrentLocation:
                                                                      true,
                                                                ),
                                                              ),
                                                            );
                                                            _loginBloc
                                                                .updateUserOfficeLocation(
                                                                    {
                                                                  "lat": _result
                                                                      .geometry
                                                                      .location
                                                                      .lat,
                                                                  "lang": _result
                                                                      .geometry
                                                                      .location
                                                                      .lng,
                                                                  "physicalLocation":
                                                                      _result
                                                                          .formattedAddress,
                                                                },
                                                                    userSnapshot
                                                                        .data
                                                                        .email);
                                                          },
                                                        ),
                                                      )
                                                    ],
                                                  );
                                            break;
                                          case ConnectionState.done:
                                            return Text(
                                                "The task has completed");
                                            break;
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                        ),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(
                            5,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "CLOSED ORDERS",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange[800].withAlpha(100),
                                  ),
                                ),
                                Expanded(
                                  child: StreamBuilder<List<OrderRef>>(
                                    stream: orderCartBloc.closedRefrence,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError)
                                        return Text("Error: ${snapshot.error}");
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.none:
                                          return Text('Awaiting bids...');
                                          break;
                                        case ConnectionState.waiting:
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                          break;
                                        case ConnectionState.active:
                                          return snapshot.data.isEmpty
                                              ? Center(
                                                  child: Text(
                                                    "No Order have been paid yet!",
                                                    style: GoogleFonts.pacifico(
                                                      fontSize: 25,
                                                      color: Colors.orange[600],
                                                    ),
                                                  ),
                                                )
                                              : ListView(
                                                  shrinkWrap: true,
                                                  children: snapshot.data
                                                      .map(
                                                        (order) => OrderRefCard(
                                                          orderRef: order,
                                                        ),
                                                      )
                                                      .toList(),
                                                );
                                          break;
                                        case ConnectionState.done:
                                          return Text(
                                              "The task has completed.");
                                          break;
                                      }
                                      return null;
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
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
