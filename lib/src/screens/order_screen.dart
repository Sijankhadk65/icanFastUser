import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    orderCartBloc.getOrderRefs(widget.user);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: Text(
              "PENDING ORDERS",
              style: GoogleFonts.montserrat(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.orange[800].withAlpha(
                  100,
                ),
              ),
            ),
          ),
          Expanded(
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
                    return snapshot.data.isEmpty
                        ? Center(
                            child: Text(
                              "No Order have been made yet!",
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
                                  (order) => order.status.isNotEmpty
                                      ? OrderRefCard(
                                          orderRef: order,
                                        )
                                      : Slidable(
                                          actionPane:
                                              SlidableStrechActionPane(),
                                          actionExtentRatio: 0.25,
                                          child: Container(
                                            color: Colors.white,
                                            child: OrderRefCard(
                                              orderRef: order,
                                            ),
                                          ),
                                          secondaryActions: <Widget>[
                                            IconSlideAction(
                                              caption: 'Delete',
                                              color: Colors.red,
                                              icon: Icons.delete,
                                              onTap: () {
                                                orderCartBloc.deleteOrderRef(
                                                    order.refID);
                                              },
                                            ),
                                          ],
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
        ],
      ),
    );
  }
}
