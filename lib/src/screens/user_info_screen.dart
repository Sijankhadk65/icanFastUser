import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fastuserapp/src/bloc/login_bloc.dart';
import 'package:fastuserapp/src/widgets/onboarding_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';

import 'package:provider/provider.dart';

class UserInfoScreen extends StatefulWidget {
  final FirebaseUser user;

  const UserInfoScreen({Key key, this.user}) : super(key: key);
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  LoginBloc _loginBloc;
  PickResult _result;
  TextEditingController _nameController, _phoneNumberController;
  PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    _pageController = PageController();
    _nameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _loginBloc = Provider.of<LoginBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              pageSnapping: true,
              onPageChanged: (value) {
                this.setState(() {
                  _currentIndex = value;
                });
              },
              children: [
                OnboardingPage(
                  assetPath: "assets/svg/profile info.svg",
                  title: "Let's get you started !",
                  subtitle: "What do you want us to call you ?",
                  child: StreamBuilder<String>(
                    stream: _loginBloc.name,
                    builder: (context, snapshot) {
                      return Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 10,
                            ),
                            child: Material(
                              borderRadius: BorderRadius.circular(
                                5,
                              ),
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 5,
                                  right: 5,
                                ),
                                child: TextField(
                                  controller: _nameController,
                                  onChanged: (value) {
                                    _loginBloc.changeName(value);
                                  },
                                  decoration: InputDecoration(
                                    labelText: " Full Name",
                                    hintText: "John Doe",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                OnboardingPage(
                  assetPath: "assets/svg/phone_number.svg",
                  title: "Add a phone number!",
                  subtitle: "This so that we can contact you.",
                  child: StreamBuilder<String>(
                    stream: _loginBloc.phoneNumber,
                    builder: (context, snapshot) {
                      return Container(
                        margin: EdgeInsets.only(
                          left: 10,
                          right: 10,
                          top: 10,
                        ),
                        child: Material(
                          borderRadius: BorderRadius.circular(
                            5,
                          ),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 5,
                              right: 5,
                            ),
                            child: TextField(
                              controller: _phoneNumberController,
                              onChanged: (value) {
                                _loginBloc.changePhoneNumber(value);
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "Phone Number",
                                hintText: "98-XXX-XXX-XX",
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                OnboardingPage(
                  assetPath: "assets/svg/location_info.svg",
                  title: "Where do you want  your food ?",
                  subtitle: "Save these two locations for ease access.",
                  child: Column(
                    children: [
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
                                                    "physicalLocation": _result
                                                        .formattedAddress,
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
                            },
                          )
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
                            fillColor: Colors.orange[800],
                            child: Text(
                              "Save Info",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FlatButton(
                onPressed: _currentIndex > 0
                    ? () {
                        this.setState(
                          () {
                            _currentIndex = _currentIndex - 1;
                          },
                        );
                        _pageController.animateToPage(
                          _currentIndex,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    : () {},
                child: Text("Back"),
              ),
              Container(
                width: 100,
                child: Stack(
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return Container(
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(
                              2,
                            ),
                          ),
                        );
                      },
                    ),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return AnimatedContainer(
                          height: 10,
                          duration: Duration(
                            milliseconds: 300,
                          ),
                          width:
                              ((_currentIndex + 1) / 3) * constraints.maxWidth,
                          decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.circular(
                              2,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              FlatButton(
                onPressed: _currentIndex < 2
                    ? () {
                        this.setState(
                          () {
                            _currentIndex = _currentIndex + 1;
                          },
                        );
                        _pageController.animateToPage(
                          _currentIndex,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    : () {},
                child: Text("Next"),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
