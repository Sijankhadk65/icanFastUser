import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/order_cart_bloc.dart';
import '../models/order_ref.dart';
import '../widgets/order_ref_card.dart';

class OrderScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  const OrderScreen({Key key, this.user}) : super(key: key);
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    orderCartBloc.getOrderRefs(widget.user);
    return Scaffold(
      body: Container(
        child: StreamBuilder<List<OrderRef>>(
          stream: orderCartBloc.orderRefrence,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text("Awaiting Bids.....");
                break;
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
                break;
              case ConnectionState.active:
                return ListView(
                  shrinkWrap: true,
                  children: snapshot.data
                      .map(
                        (order) => order.status.isNotEmpty
                            ? OrderRefCard(
                                orderRef: order,
                              )
                            : Dismissible(
                                key: UniqueKey(),
                                onDismissed: (direction) {
                                  orderCartBloc.deleteOrderRef(order.refID);
                                },
                                background: Container(
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.red[800],
                                  ),
                                  child: Center(
                                    child: Text(
                                      "The item will be deleted!",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                child: OrderRefCard(
                                  orderRef: order,
                                ),
                              ),
                      )
                      .toList(),
                );
                break;
              case ConnectionState.done:
                return Text(snapshot.data.toString());
                break;
            }
            return null;
          },
        ),
      ),
    );
  }
}
