import 'package:fastuserapp/src/screens/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/order_cart_bloc.dart';
import '../models/online_order.dart';
import '../widgets/cart_list.dart';
import '../widgets/custom_tab_bar.dart';

class CartScreen extends StatefulWidget {
  final String vendor;
  final Map<String, dynamic> user;
  final int minOrder;
  final int orderCartLength;
  const CartScreen({
    Key key,
    this.vendor,
    this.minOrder,
    this.orderCartLength,
    this.user,
  }) : super(key: key);
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    orderCartBloc.getCartsTotal();
    orderCartBloc.getLocalOrder();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart",
          style: GoogleFonts.oswald(
            fontSize: 18,
          ),
        ),
      ),
      body: StreamBuilder<List<OnlineOrder>>(
        stream: orderCartBloc.localOrder,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text("Awating Bids....");
              break;
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.active:
              return snapshot.data.isNotEmpty
                  ? Column(
                      children: <Widget>[
                        Expanded(
                          child: CustomTabView(
                            itemCount: snapshot.data.length,
                            tabBuilder: (context, index) => Column(
                              children: <Widget>[
                                Text(
                                  snapshot.data[index].vendor,
                                ),
                                Text(
                                  "Subtotal: Rs.${snapshot.data[index].totalPrice}",
                                  style: GoogleFonts.nunito(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black38,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                            pageBuilder: (context, index) => CartList(
                              items: snapshot.data[index].items.toList(),
                              vendor: snapshot.data[index].vendor,
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          duration: Duration(
                            milliseconds: 300,
                          ),
                          height: 65,
                          color: snapshot.data
                                  .map(
                                    (order) {
                                      return order.totalPrice >= order.minOrder;
                                    },
                                  )
                                  .toList()
                                  .contains(
                                    false,
                                  )
                              ? Colors.red[800]
                              : Colors.blue[800],
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: snapshot.data
                                      .map(
                                        (order) {
                                          return order.totalPrice >=
                                              order.minOrder;
                                        },
                                      )
                                      .toList()
                                      .contains(
                                        false,
                                      )
                                  ? null
                                  : () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => CheckoutScreen(
                                            user: widget.user,
                                          ),
                                        ),
                                      );
                                    },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                      child: AnimatedContainer(
                                        duration: Duration(
                                          milliseconds: 300,
                                        ),
                                        child: Center(
                                          child: StreamBuilder(
                                            stream: orderCartBloc.cartsTotal,
                                            builder: (context, snapshot) {
                                              return Text(
                                                "Total Cost (Rs.${snapshot.data})",
                                                style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    snapshot.data
                                            .map((order) {
                                              return order.totalPrice >=
                                                  order.minOrder;
                                            })
                                            .toList()
                                            .contains(false)
                                        ? Expanded(
                                            child: AnimatedContainer(
                                              duration: Duration(
                                                milliseconds: 300,
                                              ),
                                              child: Text(
                                                "Minimum Order Not ${snapshot.data.where((order) => order.minOrder > order.totalPrice).toList().map((faultyOrder) => faultyOrder.vendor)} Met !",
                                                style: GoogleFonts.montserrat(
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.white38,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  : Container(
                      child: Center(
                        child: Text(
                          "No orders in the cart yet, check the order section if any orders were placed.",
                          style: GoogleFonts.oswald(),
                        ),
                      ),
                    );
              break;
            case ConnectionState.done:
              return Text("The task has completed");
              break;
          }
          return null;
        },
      ),
    );
  }
}
