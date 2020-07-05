import 'package:fastuserapp/src/bloc/order_cart_bloc.dart';
import 'package:fastuserapp/src/models/online_order.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
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
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    orderCartBloc.getLocalOrder();
    orderCartBloc.getCartsTotal();
    return Scaffold(
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
                        child: FlareActor(
                          "assets/flare/Success Check.flr",
                          animation: "check",
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
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
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
                                      return Container(
                                        padding: EdgeInsets.only(
                                          left: 5,
                                        ),
                                        child: RichText(
                                          text: TextSpan(
                                            style: GoogleFonts.nunito(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            text: snapshot.data.toString(),
                                            children: [
                                              TextSpan(
                                                text: " (change number)",
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              Dialog(
                                                            child:
                                                                LayoutBuilder(
                                                              builder: (context,
                                                                  constraint) {
                                                                return Container(
                                                                  height: 150,
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            10),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: <
                                                                          Widget>[
                                                                        Text(
                                                                          "Enter a different number",
                                                                          style:
                                                                              GoogleFonts.nunito(
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                          ),
                                                                        ),
                                                                        TextField(
                                                                          controller:
                                                                              _phoneNumberController,
                                                                          onChanged:
                                                                              _changeNewNumber,
                                                                        ),
                                                                        Row(
                                                                          children: <
                                                                              Widget>[
                                                                            RawMaterialButton(
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: Text(
                                                                                "Cancel",
                                                                                style: GoogleFonts.nunito(
                                                                                  fontWeight: FontWeight.w600,
                                                                                  color: Colors.white,
                                                                                ),
                                                                              ),
                                                                              fillColor: Colors.grey,
                                                                              shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(
                                                                                  5,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width: 10,
                                                                            ),
                                                                            RawMaterialButton(
                                                                              onPressed: () {
                                                                                orderCartBloc.changeUserPhoneNumber(_newNumber);
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: Text(
                                                                                "Change",
                                                                                style: GoogleFonts.nunito(
                                                                                  fontWeight: FontWeight.w600,
                                                                                  color: Colors.white,
                                                                                ),
                                                                              ),
                                                                              fillColor: Colors.blue,
                                                                              shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(
                                                                                  5,
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                style: GoogleFonts.nunito(
                                                  color: Colors.blue,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              StreamBuilder<Address>(
                                stream: orderCartBloc.physicalLocation,
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
                                      return Text(
                                        snapshot.data.addressLine,
                                        style: GoogleFonts.montserrat(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 12,
                                        ),
                                      );
                                      break;
                                    case ConnectionState.done:
                                      return Text("The task has completed");
                                      break;
                                  }
                                  return null;
                                },
                              )
                            ],
                          ),
                        ),
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
                                        children: snapshot.data
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
                                                            children: <Widget>[
                                                              Text(
                                                                order.vendor
                                                                    .toUpperCase(),
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                  fontSize: 20,
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
                                                                children: order
                                                                    .items
                                                                    .map(
                                                                      (item) =>
                                                                          Text(
                                                                        "${item.name},",
                                                                        style: GoogleFonts
                                                                            .nunito(
                                                                          fontSize:
                                                                              10.5,
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
                                                              margin: EdgeInsets
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
                                                                child: Padding(
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
                                                                          FontWeight
                                                                              .w800,
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
                                                                child: Padding(
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
                                                                          FontWeight
                                                                              .w800,
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
                                      ),
                                    )
                                  : Text("No data");
                            },
                          ),
                        ),
                        Divider(),
                        StreamBuilder<int>(
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
                              Text(
                                "Rs.20",
                                style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        ),
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
                                  "VAT",
                                  style: GoogleFonts.nunito(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Text(
                                "13%",
                                style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        ),
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
                                  "Service Charge",
                                  style: GoogleFonts.nunito(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Text(
                                "10%",
                                style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        ),
                        StreamBuilder<int>(
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
                                        "Total",
                                        style: GoogleFonts.nunito(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Rs.${snapshot.data + (snapshot.data * 0.1) + (snapshot.data * 0.13) + 20}",
                                      style: GoogleFonts.nunito(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                        Divider(),
                        Container(
                          height: 65,
                          child: Material(
                            color: Colors.blue[800],
                            elevation: 10,
                            child: InkWell(
                              onTap: () {
                                orderCartBloc
                                    .saveOrder(
                                      widget.user,
                                    )
                                    .whenComplete(
                                      () => orderCartBloc
                                          .changeCheckoutStatus(true),
                                    );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Center(
                                  child: Text(
                                    "Check Out!",
                                    style: GoogleFonts.oswald(
                                      color: Colors.white,
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
            }),
      ),
    );
  }
}
