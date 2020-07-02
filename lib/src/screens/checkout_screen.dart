import 'package:fastuserapp/src/bloc/order_cart_bloc.dart';
import 'package:fastuserapp/src/models/online_order.dart';
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
                        child: Text("Your Order has been Placed!"),
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
                              Text(
                                "${widget.user['name']},",
                                style: GoogleFonts.nunito(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w700,
                                ),
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
                        Divider(),
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
                                        "Total",
                                        style: GoogleFonts.nunito(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Rs.${snapshot.data + 20}",
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
