import 'package:dotted_line/dotted_line.dart';
import 'package:fastuserapp/src/bloc/order_cart_bloc.dart';
import 'package:fastuserapp/src/models/online_order.dart';
import 'package:fastuserapp/src/screens/change_phone_number_dialog.dart';
import 'package:fastuserapp/src/widgets/changable_displayer.dart';
import 'package:fastuserapp/src/widgets/checkout_cart_list.dart';
import 'package:fastuserapp/src/widgets/delivery_location_selector.dart';
import 'package:fastuserapp/src/widgets/order_bottom_sheet.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckoutScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  const CheckoutScreen({Key key, @required this.user}) : super(key: key);
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  TextEditingController _phoneNumberController;
  String _newNumber = "";

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
  Widget build(BuildContext context) {
    orderCartBloc.getLocalOrder();
    orderCartBloc.getCartsTotal();
    orderCartBloc.getDeliveryCharge();
    orderCartBloc.getCheckoutLocation(null);
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
                            // StreamBuilder<bool>(
                            //   initialData: false,
                            //   stream: orderCartBloc.isScheduled,
                            //   builder: (context, snapshot) {
                            //     return snapshot.data
                            //         ? StreamBuilder<String>(
                            //             initialData: "",
                            //             stream: orderCartBloc.scheduledTime,
                            //             builder: (context, snapshot) {
                            //               DateTime date =
                            //                   DateTime.parse(snapshot.data);
                            //               return ChangableDisplayer(
                            //                 primaryText:
                            //                     "${date.year}/${date.month}/${date.day} at ${date.hour}:${date.minute}",
                            //                 secondaryText:
                            //                     "( change date or time )",
                            //                 displayChanger: () {
                            //                   DatePicker.showDateTimePicker(
                            //                       context,
                            //                       showTitleActions: true,
                            //                       minTime: DateTime(2018, 3, 5),
                            //                       maxTime: DateTime(2019, 6, 7),
                            //                       onChanged: (date) {
                            //                     orderCartBloc
                            //                         .changeScheduledTime(
                            //                       date.toIso8601String(),
                            //                     );
                            //                   }, onConfirm: (date) {
                            //                     orderCartBloc
                            //                         .changeSchedulingStatus(
                            //                             true);
                            //                   },
                            //                       currentTime: DateTime.now(),
                            //                       locale: LocaleType.en);
                            //                 },
                            //               );
                            //             },
                            //           )
                            //         : RawMaterialButton(
                            //             onPressed: () {
                            //               DatePicker.showDateTimePicker(context,
                            //                   showTitleActions: true,
                            //                   minTime: DateTime(2018, 3, 5),
                            //                   maxTime: DateTime(2019, 6, 7),
                            //                   onChanged: (date) {
                            //                 orderCartBloc.changeScheduledTime(
                            //                   date.toIso8601String(),
                            //                 );
                            //               }, onConfirm: (date) {
                            //                 orderCartBloc
                            //                     .changeSchedulingStatus(true);
                            //               },
                            //                   currentTime: DateTime.now(),
                            //                   locale: LocaleType.en);
                            //             },
                            //             shape: RoundedRectangleBorder(
                            //               borderRadius: BorderRadius.circular(
                            //                 5,
                            //               ),
                            //             ),
                            //             padding: EdgeInsets.only(
                            //               left: 5,
                            //               right: 5,
                            //             ),
                            //             child: Text(
                            //               "Schedule for later",
                            //               style: GoogleFonts.nunito(
                            //                 color: Colors.white,
                            //                 fontWeight: FontWeight.w800,
                            //               ),
                            //             ),
                            //             fillColor: Colors.orange[800],
                            //           );
                            //   },
                            // )
                            DeliveryLocationSelector(
                              user: widget.user,
                              setCheckoutLocation:
                                  orderCartBloc.getCheckoutLocation,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: StreamBuilder<List<OnlineOrder>>(
                            stream: orderCartBloc.localOrder,
                            builder: (context, snapshot) {
                              return snapshot.hasData
                                  ? Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      child: CheckoutCartList(
                                        orders: snapshot.data.toList(),
                                      ),
                                    )
                                  : Text("No data");
                            },
                          ),
                        ),
                      ),
                      // This is for applying promo code.
                      // Container(
                      //   margin: EdgeInsets.only(
                      //     left: 10,
                      //     right: 10,
                      //   ),
                      //   child: Row(
                      //     children: <Widget>[
                      //       // Expanded(
                      //       //   child: Container(
                      //       //     margin: EdgeInsets.only(
                      //       //       right: 10,
                      //       //     ),
                      //       //     child: Material(
                      //       //       elevation: 5,
                      //       //       borderRadius: BorderRadius.circular(
                      //       //         5,
                      //       //       ),
                      //       //       child: Padding(
                      //       //         padding: const EdgeInsets.only(
                      //       //           left: 10,
                      //       //           right: 10,
                      //       //         ),
                      //       //         child: StreamBuilder<String>(
                      //       //             stream: orderCartBloc.promoCode,
                      //       //             builder: (context, snapshot) {
                      //       //               return TextField(
                      //       //                 onChanged:
                      //       //                     orderCartBloc.changePromoCode,
                      //       //                 decoration: InputDecoration(
                      //       //                   hintText:
                      //       //                       "Enter the promo code here...",
                      //       //                   hintStyle: GoogleFonts.nunito(
                      //       //                     fontStyle: FontStyle.italic,
                      //       //                   ),
                      //       //                 ),
                      //       //               );
                      //       //             }),
                      //       //       ),
                      //       //     ),
                      //       //   ),
                      //       // ),
                      //       // StreamBuilder<bool>(
                      //       //   stream: orderCartBloc.promoCodeIsUsed,
                      //       //   builder: (context, snapshot) {
                      //       //     if (snapshot.hasError)
                      //       //       return Text("Error: ${snapshot.error}");
                      //       //     switch (snapshot.connectionState) {
                      //       //       case ConnectionState.none:
                      //       //         return Text("Awaiting bids....");
                      //       //         break;
                      //       //       case ConnectionState.waiting:
                      //       //         return Center(
                      //       //             child: CircularProgressIndicator());
                      //       //         break;
                      //       //       case ConnectionState.active:
                      //       //         return RawMaterialButton(
                      //       //           fillColor: snapshot.data
                      //       //               ? Colors.grey
                      //       //               : Colors.blue[800],
                      //       //           shape: RoundedRectangleBorder(
                      //       //             borderRadius: BorderRadius.circular(
                      //       //               5,
                      //       //             ),
                      //       //           ),
                      //       //           onPressed: snapshot.data
                      //       //               ? null
                      //       //               : () {
                      //       //                   orderCartBloc.applyPromoCode(
                      //       //                       widget.user['email']);
                      //       //                 },
                      //       //           child: Text(
                      //       //             "Apply Code",
                      //       //             style: GoogleFonts.nunito(
                      //       //               color: snapshot.data
                      //       //                   ? Colors.black26
                      //       //                   : Colors.white,
                      //       //             ),
                      //       //           ),
                      //       //         );
                      //       //         break;
                      //       //       case ConnectionState.done:
                      //       //         return Text("The task has completed");
                      //       //         break;
                      //       //     }
                      //       //   },
                      //       // ),
                      //     ],
                      //   ),
                      // ),

                      // This is for displaying if the code is applied or not.
                      // StreamBuilder<bool>(
                      //   stream: orderCartBloc.promoCodeIsUsed,
                      //   builder: (context, snapshot) {
                      //     if (snapshot.hasError)
                      //       return Text("Error: ${snapshot.error}");
                      //     switch (snapshot.connectionState) {
                      //       case ConnectionState.none:
                      //         return Text("Awaiting Bids...");
                      //         break;
                      //       case ConnectionState.waiting:
                      //         return Center(
                      //           child: CircularProgressIndicator(),
                      //         );
                      //         break;
                      //       case ConnectionState.active:
                      //         return snapshot.data
                      //             ? Text(
                      //                 "You have used a promo code!",
                      //                 style: GoogleFonts.nunito(
                      //                   color: Colors.green,
                      //                   fontStyle: FontStyle.italic,
                      //                   fontWeight: FontWeight.bold,
                      //                 ),
                      //               )
                      //             : Container();
                      //         break;
                      //       case ConnectionState.done:
                      //         return Text("The task has completed");
                      //         break;
                      //     }
                      //     return null;
                      //   },
                      // ),

                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFFF6A8C),
                          borderRadius: BorderRadius.circular(
                            5,
                          ),
                        ),
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        child: Column(
                          children: [
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
                                    return Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Delivery Address",
                                                  style: GoogleFonts.nunito(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  snapshot.data,
                                                  style: GoogleFonts.nunito(
                                                    fontWeight: FontWeight.w800,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                    // ChangableDisplayer(
                                    //   primaryText: snapshot.data,
                                    //   secondaryText: " ( change location )",
                                    //   displayChanger: () async {
                                    //     LocationResult result =
                                    //         await showLocationPicker(
                                    //       context,
                                    //       "AIzaSyATdr7r2cCqiNWcgv9VQSYKf7k50Qzx7IY",
                                    //       automaticallyAnimateToCurrentLocation: true,
                                    //       myLocationButtonEnabled: true,
                                    //       layersButtonEnabled: true,
                                    //     );
                                    //     orderCartBloc.getCheckoutLocation(
                                    //       {
                                    //         "coordinates": {
                                    //           "lat": result.latLng.latitude,
                                    //           "lang": result.latLng.longitude,
                                    //         },
                                    //         "phycialLocation": result.address,
                                    //       },
                                    //     );
                                    //     orderCartBloc.getDeliveryCharge();
                                    //   },
                                    // );

                                    break;
                                  case ConnectionState.done:
                                    return Text("The task has completed");
                                    break;
                                }
                                return null;
                              },
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                bottom: 10,
                              ),
                              child: DottedLine(
                                dashColor: Colors.white24,
                                lineThickness: 2,
                                dashRadius: 5,
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
                                          return (Text(
                                              "Error: ${snapshot.error}"));
                                        switch (snapshot.connectionState) {
                                          case ConnectionState.none:
                                            return Text("Awaiting bids....");
                                            break;
                                          case ConnectionState.waiting:
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                            break;
                                          case ConnectionState.active:
                                            return Container(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    child: Container(
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              "Delivery Charge",
                                                              style: GoogleFonts
                                                                  .nunito(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                fontSize: 16,
                                                                color: Color(
                                                                  0xFFAB304C,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            "Rs.${snapshot.data.toStringAsFixed(2)}",
                                                            style: GoogleFonts
                                                                .nunito(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                              // fontSize: 18,
                                                              color: Color(
                                                                0xFFAB304C,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Text(
                                                            "Total",
                                                            style: GoogleFonts
                                                                .nunito(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                              fontSize: 16,
                                                              color: Color(
                                                                0xFFAB304C,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          "Rs.${double.parse((snapshot.data + totalAmount.data).toStringAsFixed(2))}",
                                                          style: GoogleFonts
                                                              .nunito(
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            // fontSize: 18,
                                                            color: Color(
                                                              0xFFAB304C,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                            break;
                                          case ConnectionState.done:
                                            return Text(
                                                "The task has completed.");
                                            break;
                                        }
                                        return null;
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
                          ],
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFF11998e),
                          borderRadius: BorderRadius.circular(
                            5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              offset: Offset(
                                0,
                                5,
                              ),
                              blurRadius: 5,
                            )
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
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
                      )
                    ],
                  );
          },
        ),
      ),
    );
  }
}
