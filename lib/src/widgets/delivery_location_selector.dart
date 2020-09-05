import 'package:fastuserapp/src/bloc/order_cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'location_selectors.dart';

class DeliveryLocationSelector extends StatefulWidget {
  final Map<String, dynamic> user;
  final ValueChanged<Map<String, dynamic>> setCheckoutLocation;
  const DeliveryLocationSelector({
    Key key,
    this.user,
    this.setCheckoutLocation,
  }) : super(key: key);
  @override
  _DeliveryLocationSelectorState createState() =>
      _DeliveryLocationSelectorState();
}

class _DeliveryLocationSelectorState extends State<DeliveryLocationSelector> {
  bool _chooseLocation = false;

  _switchToFavouredLocation(bool value) {
    this.setState(() {
      _chooseLocation = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              "Choose a saved location",
              style: GoogleFonts.nunito(
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
            Switch.adaptive(
              value: _chooseLocation,
              onChanged: _switchToFavouredLocation,
            ),
          ],
        ),
        _chooseLocation
            ? StreamBuilder<String>(
                stream: orderCartBloc.checkoutPhysicalLocation,
                builder: (context, snapshot) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: widget.user['home']['physicalLocation'] != null
                            ? LocationSelector(
                                name: "HOME",
                                isActive: snapshot.data ==
                                        widget.user['home']['physicalLocation']
                                    ? true
                                    : false,
                                changeLocation: snapshot.data ==
                                        widget.user['home']['physicalLocation']
                                    ? () {}
                                    : () {
                                        print(
                                            "location to be set:${widget.user['home']['physicalLocation']}");
                                        widget.setCheckoutLocation(
                                          {
                                            "coordinates": {
                                              "lat": widget.user['home']['lat'],
                                              "lang": widget.user['home']
                                                  ['lang'],
                                            },
                                            "physicalLocation":
                                                widget.user['home']
                                                    ['physicalLocation'],
                                          },
                                        );

                                        orderCartBloc.getDeliveryCharge();
                                      },
                                margins: EdgeInsets.only(
                                  right: 5,
                                ),
                              )
                            : Text("Please set a location."),
                      ),
                      Expanded(
                        child: widget.user['office']['physicalLocation'] != null
                            ? LocationSelector(
                                name: "OFFICE",
                                isActive: snapshot.data ==
                                        widget.user['office']
                                            ['physicalLocation']
                                    ? true
                                    : false,
                                changeLocation: snapshot.data ==
                                        widget.user['office']
                                            ['physicalLocation']
                                    ? () {}
                                    : () {
                                        print(
                                            "location to be set:${widget.user['office']['physicalLocation']}");
                                        widget.setCheckoutLocation(
                                          {
                                            "coordinates": {
                                              "lat": widget.user['office']
                                                  ['lat'],
                                              "lang": widget.user['office']
                                                  ['lang'],
                                            },
                                            "physicalLocation":
                                                widget.user['office']
                                                    ['physicalLocation'],
                                          },
                                        );
                                        orderCartBloc.getDeliveryCharge();
                                      },
                                margins: EdgeInsets.only(
                                  left: 5,
                                ),
                              )
                            : Text("Please set a location."),
                      ),
                    ],
                  );
                },
              )
            : Container(),
      ],
    );
  }
}
