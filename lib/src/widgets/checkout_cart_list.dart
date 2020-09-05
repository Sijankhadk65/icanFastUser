import 'package:fastuserapp/src/models/online_order.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'checkout_cart_order_card.dart';

class CheckoutCartList extends StatelessWidget {
  final List<OnlineOrder> orders;
  const CheckoutCartList({
    Key key,
    this.orders,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "My Order",
          style: GoogleFonts.oswald(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        ListView(
          shrinkWrap: true,
          children: orders
              .map<Widget>(
                (order) => CheckoutCartOrderCard(
                  order: order,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
