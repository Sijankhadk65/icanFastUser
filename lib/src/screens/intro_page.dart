import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fastuserapp/src/bloc/login_bloc.dart';
import 'package:fastuserapp/src/models/user.dart';
import 'package:fastuserapp/src/screens/user_info_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:provider/provider.dart';

class IntroPage extends StatefulWidget {
  final FirebaseUser user;

  IntroPage({Key key, this.user}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final _pageNameList = [
    {"pageName": "HOME", "asset": "home_screen"},
    {"pageName": "VENDOR", "asset": "vendor_screen"},
    {"pageName": "ITEM", "asset": "add_item"},
    {"pageName": "TRACKING", "asset": "order_tracking"},
  ];

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
      body: IntroViewsFlutter(
        [
          ..._pageNameList
              .map(
                (name) => PageViewModel(
                  pageColor: Colors.orange[800],
                  iconColor: Colors.yellow,
                  bubbleBackgroundColor: Colors.orange,
                  body: Text(
                    '',
                  ),
                  title: Text(name['pageName']),
                  mainImage: AspectRatio(
                    aspectRatio: 9 / 16,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFF07414),
                            blurRadius: 10,
                          )
                        ],
                        image: DecorationImage(
                          image: AssetImage("assets/ss/${name['asset']}.jpg"),
                        ),
                      ),
                    ),
                  ),
                  titleTextStyle: GoogleFonts.oswald(),
                ),
              )
              .toList(),
          PageViewModel(
            mainImage: Material(
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
                                              snapshot.data['physicalLocation']
                                                  .toString()
                                                  .toUpperCase(),
                                              style: GoogleFonts.nunito(
                                                color: Colors.orange,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(EvaIcons.edit2Outline),
                                            onPressed: () async {
                                              await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      PlacePicker(
                                                    apiKey:
                                                        "AIzaSyATdr7r2cCqiNWcgv9VQSYKf7k50Qzx7IY",
                                                    onPlacePicked: (result) {
                                                      this.setState(
                                                        () {
                                                          _result = result;
                                                        },
                                                      );
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    useCurrentLocation: true,
                                                  ),
                                                ),
                                              );
                                              _loginBloc.changeHomeLocation(
                                                {
                                                  "lat": _result
                                                      .geometry.location.lat,
                                                  "lang": _result
                                                      .geometry.location.lng,
                                                  "physicalLocation":
                                                      _result.formattedAddress,
                                                },
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                    )
                                  : RawMaterialButton(
                                      onPressed: () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => PlacePicker(
                                              apiKey:
                                                  "AIzaSyATdr7r2cCqiNWcgv9VQSYKf7k50Qzx7IY",
                                              onPlacePicked: (result) {
                                                this.setState(
                                                  () {
                                                    _result = result;
                                                  },
                                                );
                                                Navigator.of(context).pop();
                                              },
                                              useCurrentLocation: true,
                                            ),
                                          ),
                                        );
                                        _loginBloc.changeHomeLocation(
                                          {
                                            "lat":
                                                _result.geometry.location.lat,
                                            "lang":
                                                _result.geometry.location.lng,
                                            "physicalLocation":
                                                _result.formattedAddress,
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
                                              snapshot.data['physicalLocation']
                                                  .toString()
                                                  .toUpperCase(),
                                              style: GoogleFonts.nunito(
                                                color: Colors.orange,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(EvaIcons.edit2Outline),
                                            onPressed: () async {
                                              await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      PlacePicker(
                                                    apiKey:
                                                        "AIzaSyATdr7r2cCqiNWcgv9VQSYKf7k50Qzx7IY",
                                                    onPlacePicked: (result) {
                                                      this.setState(
                                                        () {
                                                          _result = result;
                                                        },
                                                      );
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    useCurrentLocation: true,
                                                  ),
                                                ),
                                              );
                                              _loginBloc.changeOfficeLocation(
                                                {
                                                  "lat": _result
                                                      .geometry.location.lat,
                                                  "lang": _result
                                                      .geometry.location.lng,
                                                  "physicalLocation":
                                                      _result.formattedAddress,
                                                },
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                    )
                                  : RawMaterialButton(
                                      onPressed: () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => PlacePicker(
                                              apiKey:
                                                  "AIzaSyATdr7r2cCqiNWcgv9VQSYKf7k50Qzx7IY",
                                              onPlacePicked: (result) {
                                                this.setState(
                                                  () {
                                                    _result = result;
                                                  },
                                                );
                                                Navigator.of(context).pop();
                                              },
                                              useCurrentLocation: true,
                                            ),
                                          ),
                                        );
                                        _loginBloc.changeOfficeLocation(
                                          {
                                            "lat":
                                                _result.geometry.location.lat,
                                            "lang":
                                                _result.geometry.location.lng,
                                            "physicalLocation":
                                                _result.formattedAddress,
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
            title: Text("User Info"),
            body: Text(""),
          )
        ],
        onTapDoneButton: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => Provider(
                create: (_) => LoginBloc(),
                dispose: (context, LoginBloc bloc) => bloc.dispose(),
                child: UserInfoScreen(
                  user: widget.user,
                ),
              ),
            ),
          );
        },
        showSkipButton: true,
        pageButtonTextStyles: new TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontFamily: "Regular",
        ),
        background: Colors.orange[800],
      ),
//       IntroScreens(
//         onDone: () {},
//         onSkip: () => print('Skipping the intro slides'),
//         // footerBgColor: TinyColor(Colors.blue).lighten().color,
//         activeDotColor: Colors.white,
//         footerRadius: 18.0,
// //      indicatorType: IndicatorType.CIRCLE,
//         slides: [
//           IntroScreen(
//             title: 'Search',
//             imageAsset: 'assets/ss/home_screen.jpg',
//             description: 'Quickly find all your messages',
//             headerBgColor: Colors.white,
//           ),
//           IntroScreen(
//             title: 'Search',
//             imageAsset: 'assets/ss/vendor_screen.jpg',
//             description: 'Quickly find all your messages',
//             headerBgColor: Colors.white,
//           ),
//           IntroScreen(
//             title: 'Search',
//             imageAsset: 'assets/ss/add_item.jpg',
//             description: 'Quickly find all your messages',
//             headerBgColor: Colors.white,
//           ),
//           IntroScreen(
//             title: 'Search',
//             imageAsset: 'assets/ss/order_tracking.jpg',
//             description: 'Quickly find all your messages',
//             headerBgColor: Colors.white,
//           ),
//         ],
//       ),
    );
  }
}
