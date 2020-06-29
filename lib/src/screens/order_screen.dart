import 'package:flutter/material.dart';

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
                        (order) => OrderRefCard(
                          orderRef: order,
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
