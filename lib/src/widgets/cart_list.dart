import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/order_cart_bloc.dart';
import '../models/cart_items.dart';
import '../widgets/cart_item_card.dart';

class CartList extends StatefulWidget {
  final List<CartItem> items;
  final String job, vendor;

  const CartList({
    Key key,
    this.items,
    this.job,
    this.vendor,
  }) : super(key: key);
  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  @override
  Widget build(BuildContext context) {
    return widget.items.isEmpty
        ? Center(
            child: Text(
              "No Items here!",
              style: GoogleFonts.pacifico(),
            ),
          )
        : ListView(
            shrinkWrap: true,
            children: widget.items
                .map(
                  (e) => Dismissible(
                    key: Key(e.name),
                    onDismissed: (direction) =>
                        orderCartBloc.removeItemFromCart(widget.vendor, e),
                    child: CartItemCard(
                      cartItem: e,
                      decreaseCount: e.quantity > 1
                          ? () =>
                              orderCartBloc.decreaseItemCount(widget.vendor, e)
                          : null,
                      increaseCount: () =>
                          orderCartBloc.increaseItemCount(widget.vendor, e),
                      job: widget.job,
                    ),
                  ),
                )
                .toList(),
          );
  }
}
