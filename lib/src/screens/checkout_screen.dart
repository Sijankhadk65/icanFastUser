import 'package:fastuserapp/src/bloc/order_cart_bloc.dart';
import 'package:fastuserapp/src/models/online_order.dart';
import 'package:fastuserapp/src/screens/change_phone_number_dialog.dart';
import 'package:fastuserapp/src/widgets/changable_displayer.dart';
import 'package:fastuserapp/src/widgets/location_selectors.dart';
import 'package:fastuserapp/src/widgets/order_bottom_sheet.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';

class CheckoutScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  const CheckoutScreen({Key key, @required this.user}) : super(key: key);
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  TextEditingController _phoneNumberController;
  String _newNumber = "";
  bool _chooseLocation = false;

  _switchToFavouredLocation(bool value) {
    this.setState(() {
      _chooseLocation = value;
    });
  }

  _changeNewNumber(number) {
    this.setState(() {
      _newNumber = number;
    });
  }

  @override
  void initState() {
    _phoneNumberController = TextEditingController();
    orderCartBloc.changeUserPhoneNumber(widget.user['phoneNumber'].toString());
    _phoneNumberController.text = widget.user['phoneNumber'].toString();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    orderCartBloc.getLocalOrder();
    orderCartBloc.getCartsTotal();
    orderCartBloc.getCheckoutLocation();
    orderCartBloc.getDeliveryCharge();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Checkout"),
      ),
      body: Container(
        child: StreamBuilder<bool>(
          stream: orderCartBloc.checkedOut,
          builder: (context, snapshot) {
            return snapshot.data == true
                ? Container(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: FlareActor(
                              "assets/flare/check.flr",
                              animation: "check",
                              alignment: Alignment.center,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            "Your Order has been placed, go to the order section to check it out.",
                            style: GoogleFonts.oswald(),
                          ),
                          RawMaterialButton(
                            onPressed: () {
                              showBottomSheet(
                                context: context,
                                builder: (context) => OrderBottomSheet(),
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
                              "Look at your orders",
                              style: GoogleFonts.nunito(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            fillColor: Colors.orange[800],
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(),
                          ),
                        ],
                      ),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Delivery To:"),
                            Text(
                              "${widget.user['name']},",
                              style: GoogleFonts.nunito(
                                fontSize: 23,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            StreamBuilder<String>(
                              stream: orderCartBloc.userPhoneNumber,
                              builder: (context, snapshot) {
                                return ChangableDisplayer(
                                  primaryText: snapshot.data.toString(),
                                  secondaryText: " ( change phone number ) ",
                                  displayChanger: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) =>
                                          ChangePhoneNumberDialog(
                                        phoneNumberController:
                                            _phoneNumberController,
                                        onPhoneNumberChanged: _changeNewNumber,
                                        onChangePressed: () {
                                          orderCartBloc.changeUserPhoneNumber(
                                              _newNumber);
                                          Navigator.pop(context);
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            StreamBuilder<String>(
                              stream: orderCartBloc.checkoutPhysicalLocation,
                              builder: (context, snapshot) {
                                if (snapshot.hasError)
                                  return Text("Error: ${snapshot.error}");
                                switch (snapshot.connectionState) {
                                  case ConnectionState.none:
                                    return Text("Awaiting Bids...");
                                    break;
                                  case ConnectionState.waiting:
                                    return Center(
                                      child: LinearProgressIndicator(),
                                    );
                                    break;
                                  case ConnectionState.active:
                                    return ChangableDisplayer(
                                      primaryText: snapshot.data,
                                      secondaryText: " ( change location )",
                                      displayChanger: () async {
                                        LocationResult result =
                                            await showLocationPicker(
                                          context,
                                          "AIzaSyATdr7r2cCqiNWcgv9VQSYKf7k50Qzx7IY",
                                          automaticallyAnimateToCurrentLocation:
                                              true,
                                          myLocationButtonEnabled: true,
                                          layersButtonEnabled: true,
                                        );
                                        orderCartBloc.getCheckoutLocation(
                                          coordinates: {
                                            "lat": result.latLng.latitude,
                                            "lang": result.latLng.longitude,
                                          },
                                          phycialLocation: result.address,
                                        );
                                        orderCartBloc.getDeliveryCharge();
                                      },
                                    );

                                    break;
                                  case ConnectionState.done:
                                    return Text("The task has completed");
                                    break;
                                }
                                return null;
                              },
                            ),
                            StreamBuilder<bool>(
                              stream: orderCartBloc.isScheduled,
                              builder: (context, snapshot) {
                                return snapshot.data
                                    ? StreamBuilder<String>(
                                        stream: orderCartBloc.scheduledTime,
                                        builder: (context, snapshot) {
                                          DateTime date =
                                              DateTime.parse(snapshot.data);
                                          return ChangableDisplayer(
                                            primaryText:
                                                "${date.year}/${date.month}/${date.day} at ${date.hour}:${date.minute}",
                                            secondaryText:
                                                "( change date or time )",
                                            displayChanger: () {
                                              DatePicker.showDateTimePicker(
                                                  context,
                                                  showTitleActions: true,
                                                  minTime: DateTime(2018, 3, 5),
                                                  maxTime: DateTime(2019, 6, 7),
                                                  onChanged: (date) {
                                                orderCartBloc
                                                    .changeScheduledTime(
                                                  date.toIso8601String(),
                                                );
                                              }, onConfirm: (date) {
                                                orderCartBloc
                                                    .changeSchedulingStatus(
                                                        true);
                                              },
                                                  currentTime: DateTime.now(),
                                                  locale: LocaleType.en);
                                            },
                                          );
                                        },
                                      )
                                    : RawMaterialButton(
                                        onPressed: () {
                                          DatePicker.showDateTimePicker(context,
                                              showTitleActions: true,
                                              minTime: DateTime(2018, 3, 5),
                                              maxTime: DateTime(2019, 6, 7),
                                              onChanged: (date) {
                                            orderCartBloc.changeScheduledTime(
                                              date.toIso8601String(),
                                            );
                                          }, onConfirm: (date) {
                                            orderCartBloc
                                                .changeSchedulingStatus(true);
                                          },
                                              currentTime: DateTime.now(),
                                              locale: LocaleType.en);
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                        padding: EdgeInsets.only(
                                          left: 5,
                                          right: 5,
                                        ),
                                        child: Text(
                                          "Schedule for later",
                                          style: GoogleFonts.nunito(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        fillColor: Colors.orange[800],
                                      );
                              },
                            )
                          ],
                        ),
                      ),
                      Divider(),
                      Expanded(
                        child: StreamBuilder<List<OnlineOrder>>(
                          stream: orderCartBloc.localOrder,
                          builder: (context, snapshot) {
                            return snapshot.hasData
                                ? Container(
                                    margin: EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                    ),
                                    child: ListView(
                                        shrinkWrap: true,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                            ),
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Text(
                                                      "Choose a saved location",
                                                      style: GoogleFonts.nunito(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                      ),
                                                    ),
                                                    Switch.adaptive(
                                                      value: _chooseLocation,
                                                      onChanged:
                                                          _switchToFavouredLocation,
                                                    ),
                                                  ],
                                                ),
                                                _chooseLocation
                                                    ? StreamBuilder<String>(
                                                        stream: orderCartBloc
                                                            .checkoutPhysicalLocation,
                                                        builder: (context,
                                                            snapshot) {
                                                          return Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              Expanded(
                                                                child:
                                                                    LocationSelector(
                                                                  name: "HOME",
                                                                  isActive: snapshot
                                                                              .data ==
                                                                          widget.user['home']
                                                                              [
                                                                              'physicalLocation']
                                                                      ? true
                                                                      : false,
                                                                  changeLocation:
                                                                      snapshot.data ==
                                                                              widget.user['home']['physicalLocation']
                                                                          ? () {}
                                                                          : () {
                                                                              orderCartBloc.getCheckoutLocation(
                                                                                coordinates: {
                                                                                  "lat": widget.user['home']['lat'],
                                                                                  "lang": widget.user['home']['lang'],
                                                                                },
                                                                                phycialLocation: widget.user['home']['physicalLocation'],
                                                                              );
                                                                              orderCartBloc.getDeliveryCharge();
                                                                            },
                                                                  margins:
                                                                      EdgeInsets
                                                                          .only(
                                                                    right: 5,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child:
                                                                    LocationSelector(
                                                                  name:
                                                                      "OFFICE",
                                                                  isActive: snapshot
                                                                              .data ==
                                                                          widget.user['office']
                                                                              [
                                                                              'physicalLocation']
                                                                      ? true
                                                                      : false,
                                                                  changeLocation:
                                                                      snapshot.data ==
                                                                              widget.user['office']['physicalLocation']
                                                                          ? () {}
                                                                          : () {
                                                                              orderCartBloc.getCheckoutLocation(
                                                                                coordinates: {
                                                                                  "lat": widget.user['office']['lat'],
                                                                                  "lang": widget.user['office']['lang'],
                                                                                },
                                                                                phycialLocation: widget.user['office']['physicalLocation'],
                                                                              );
                                                                              orderCartBloc.getDeliveryCharge();
                                                                            },
                                                                  margins:
                                                                      EdgeInsets
                                                                          .only(
                                                                    left: 5,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        })
                                                    : Container(),
                                              ],
                                            ),
                                          ),
                                          ...snapshot.data
                                              .map<Widget>((order) => Column(
                                                    children: <Widget>[
                                                      Divider(),
                                                      Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  order.vendor
                                                                      .toUpperCase(),
                                                                  style: GoogleFonts
                                                                      .montserrat(
                                                                    fontSize:
                                                                        20,
                                                                    letterSpacing:
                                                                        1.5,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                  ),
                                                                ),
                                                                ListView(
                                                                  shrinkWrap:
                                                                      true,
                                                                  physics:
                                                                      ClampingScrollPhysics(),
                                                                  children: order
                                                                      .items
                                                                      .map(
                                                                        (item) =>
                                                                            RichText(
                                                                          text:
                                                                              TextSpan(
                                                                            text:
                                                                                item.name,
                                                                            children: [
                                                                              TextSpan(
                                                                                text: " x${item.quantity}",
                                                                                style: GoogleFonts.nunito(
                                                                                  fontSize: 10,
                                                                                  color: Colors.black,
                                                                                  fontWeight: FontWeight.w800,
                                                                                ),
                                                                              ),
                                                                              TextSpan(
                                                                                text: ",",
                                                                              ),
                                                                            ],
                                                                            style:
                                                                                GoogleFonts.nunito(
                                                                              fontSize: 10,
                                                                              color: Colors.black,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                                      .toList(),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              Container(
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  bottom: 7.5,
                                                                ),
                                                                child: Material(
                                                                  color: Colors
                                                                          .orange[
                                                                      800],
                                                                  elevation: 5,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .only(
                                                                      left: 10,
                                                                      right: 10,
                                                                      top: 5,
                                                                      bottom: 5,
                                                                    ),
                                                                    child: Text(
                                                                      "Total Items: ${order.cartLength}",
                                                                      style: GoogleFonts
                                                                          .nunito(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.w800,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                child: Material(
                                                                  color: Colors
                                                                          .orange[
                                                                      800],
                                                                  elevation: 5,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .only(
                                                                      left: 10,
                                                                      right: 10,
                                                                      top: 5,
                                                                      bottom: 5,
                                                                    ),
                                                                    child: Text(
                                                                      "Total Price: ${order.totalPrice}",
                                                                      style: GoogleFonts
                                                                          .nunito(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.w800,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      Divider(),
                                                    ],
                                                  ))
                                              .toList(),
                                        ]),
                                  )
                                : Text("No data");
                          },
                        ),
                      ),
                      Divider(),
                      Container(
                        margin: EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(
                                  right: 10,
                                ),
                                child: Material(
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(
                                    5,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                    ),
                                    child: StreamBuilder<String>(
                                        stream: orderCartBloc.promoCode,
                                        builder: (context, snapshot) {
                                          return TextField(
                                            onChanged:
                                                orderCartBloc.changePromoCode,
                                            decoration: InputDecoration(
                                              hintText:
                                                  "Enter the promo code here...",
                                              hintStyle: GoogleFonts.nunito(
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                              ),
                            ),
                            StreamBuilder<bool>(
                                stream: orderCartBloc.promoCodeIsUsed,
                                builder: (context, snapshot) {
                                  if (snapshot.hasError)
                                    return Text("Error: ${snapshot.error}");
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.none:
                                      return Text("Awaiting bids....");
                                      break;
                                    case ConnectionState.waiting:
                                      return Center(
                                          child: CircularProgressIndicator());
                                      break;
                                    case ConnectionState.active:
                                      return RawMaterialButton(
                                        fillColor: snapshot.data
                                            ? Colors.grey
                                            : Colors.blue[800],
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                        onPressed: snapshot.data
                                            ? null
                                            : () {
                                                orderCartBloc.applyPromoCode(
                                                    widget.user['email']);
                                              },
                                        child: Text(
                                          "Apply Code",
                                          style: GoogleFonts.nunito(
                                            color: snapshot.data
                                                ? Colors.black26
                                                : Colors.white,
                                          ),
                                        ),
                                      );
                                      break;
                                    case ConnectionState.done:
                                      return Text("The task has completed");
                                      break;
                                  }
                                }),
                          ],
                        ),
                      ),
                      StreamBuilder<bool>(
                        stream: orderCartBloc.promoCodeIsUsed,
                        builder: (context, snapshot) {
                          if (snapshot.hasError)
                            return Text("Error: ${snapshot.error}");
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return Text("Awaiting Bids...");
                              break;
                            case ConnectionState.waiting:
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                              break;
                            case ConnectionState.active:
                              return snapshot.data
                                  ? Text(
                                      "You have used a promo code!",
                                      style: GoogleFonts.nunito(
                                        color: Colors.green,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : Container();
                              break;
                            case ConnectionState.done:
                              return Text("The task has completed");
                              break;
                          }
                          return null;
                        },
                      ),
                      Divider(),
                      StreamBuilder<double>(
                          stream: orderCartBloc.cartsTotal,
                          builder: (context, snapshot) {
                            return Container(
                              margin: EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 5,
                                bottom: 5,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      "Subtotal",
                                      style: GoogleFonts.nunito(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Rs.${snapshot.data.toString()}",
                                    style: GoogleFonts.nunito(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16,
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                      Container(
                        margin: EdgeInsets.only(
                          left: 10,
                          right: 10,
                          top: 5,
                          bottom: 5,
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Delivery Charge",
                                style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            StreamBuilder<double>(
                                stream: orderCartBloc.deliveryCharge,
                                builder: (context, snapshot) {
                                  return Text(
                                    "Rs.${snapshot.data.toStringAsFixed(2)}",
                                    style: GoogleFonts.nunito(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16,
                                    ),
                                  );
                                })
                          ],
                        ),
                      ),
                      StreamBuilder<double>(
                        stream: orderCartBloc.cartsTotal,
                        builder: (context, totalAmount) {
                          if (totalAmount.hasError)
                            return Text("Error: ${totalAmount.error}");
                          switch (totalAmount.connectionState) {
                            case ConnectionState.none:
                              return Text("Awaiting bids....");
                              break;
                            case ConnectionState.waiting:
                              return LinearProgressIndicator();
                              break;
                            case ConnectionState.active:
                              return StreamBuilder<double>(
                                  stream: orderCartBloc.deliveryCharge,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError)
                                      return (Text("Error: ${snapshot.error}"));
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.none:
                                        return Text("Awaiting bids....");
                                        break;
                                      case ConnectionState.waiting:
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                        break;
                                      case ConnectionState.active:
                                        return Container(
                                          margin: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 5,
                                            bottom: 5,
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Text(
                                                  "Total",
                                                  style: GoogleFonts.nunito(
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "Rs.${double.parse((snapshot.data + totalAmount.data).toStringAsFixed(2))}",
                                                style: GoogleFonts.nunito(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 16,
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                        break;
                                      case ConnectionState.done:
                                        return Text("The task has completed.");
                                        break;
                                    }
                                  });
                              break;
                            case ConnectionState.done:
                              return Text("The task has completed");
                              break;
                          }
                          return null;
                        },
                      ),
                      Divider(),
                      Container(
                        height: 65,
                        child: Material(
                          color: Colors.blue[800],
                          elevation: 10,
                          child: InkWell(
                            onTap: () {
                              orderCartBloc.changeTransactionStatus(true);
                              orderCartBloc
                                  .saveOrder(
                                widget.user,
                              )
                                  .whenComplete(
                                () {
                                  orderCartBloc.changeTransactionStatus(false);
                                  orderCartBloc.changeCheckoutStatus(true);
                                },
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Center(
                                child: StreamBuilder<bool>(
                                  initialData: false,
                                  stream: orderCartBloc.transactionStatus,
                                  builder: (context, snapshot) {
                                    return snapshot.data
                                        ? CircularProgressIndicator(
                                            backgroundColor: Colors.green,
                                          )
                                        : Text(
                                            "Check Out!",
                                            style: GoogleFonts.oswald(
                                              color: Colors.white,
                                              fontSize: 25,
                                            ),
                                          );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
          },
        ),
      ),
    );
  }
}
