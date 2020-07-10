import 'package:fastuserapp/src/bloc/order_cart_bloc.dart';
import 'package:fastuserapp/src/models/online_order.dart';
import 'package:fastuserapp/src/widgets/progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'cart_list.dart';
import 'custom_tab_bar.dart';

class OrderBottomSheet extends StatefulWidget {
  @override
  _OrderBottomSheetState createState() => _OrderBottomSheetState();
}

class _OrderBottomSheetState extends State<OrderBottomSheet> {
  @override
  Widget build(BuildContext context) {
    orderCartBloc.getOrders(orderCartBloc.orderRefrenceID);
    return Container(
      margin: EdgeInsets.all(
        10,
      ),
      padding: EdgeInsets.all(
        10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10,
            offset: Offset(0, 0),
          )
        ],
      ),
      child: StreamBuilder<List<OnlineOrder>>(
        stream: orderCartBloc.liveOrders,
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text("Error: ${snapshot.error}");
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text("Awaiting Bids....");
              break;
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.active:
              return Column(
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
                          ),
                        ],
                      ),
                      pageBuilder: (context, index) => Column(
                        children: <Widget>[
                          ProgressWidget(
                            status: snapshot.data[index].status.toList(),
                          ),
                          CartList(
                            job: "history",
                            items: snapshot.data[index].items.toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
              break;
            case ConnectionState.done:
              return Text("The task has completed.");
              break;
          }
          return null;
        },
      ),
    );
  }
}
