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

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    orderCartBloc.getOrderRefs(widget.user);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: TabBar(
              controller: _tabController,
              tabs: [
                Text("Pending Orders"),
                Text("Closed Orders"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                Container(
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
                                                // showDialog(
                                                //   context: context,
                                                //   builder: (context) => Dialog(
                                                //     child: Container(
                                                //       height: 150,
                                                //       padding: EdgeInsets.only(
                                                //         top: 10,
                                                //       ),
                                                //       child: Column(
                                                //         children: <Widget>[
                                                //           Text(
                                                //               "Do you want to delete this order?"),
                                                //           Row(
                                                //             children: <Widget>[
                                                //               RawMaterialButton(
                                                //                 onPressed: () =>
                                                //                     Navigator.pop(
                                                //                         context),
                                                //                 child: Text(
                                                //                     "Cancle"),
                                                //               ),
                                                //               RawMaterialButton(
                                                //                 onPressed: () =>
                                                //                     orderCartBloc
                                                //                         .deleteOrderRef(
                                                //                             order.refID),
                                                //                 child: Text(
                                                //                     "Cancle"),
                                                //               ),
                                                //             ],
                                                //           )
                                                //         ],
                                                //       ),
                                                //     ),
                                                //   ),
                                                // );
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
                Container(
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
                          return snapshot.data != []
                              ? ListView(
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
                                                  orderCartBloc.deleteOrderRef(
                                                      order.refID);
                                                },
                                                background: Container(
                                                  margin: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Colors.red[800],
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "The item will be deleted!",
                                                      style: GoogleFonts
                                                          .montserrat(
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
                                )
                              : Container(
                                  child: Center(
                                    child: Text("No Orders Yet!"),
                                  ),
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
          ),
        ],
      ),
    );
  }
}
