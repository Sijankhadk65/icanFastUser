import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/cart_items.dart';

class CartItemCard extends StatefulWidget {
  final CartItem cartItem;
  final Function() decreaseCount, increaseCount;
  final String job;

  const CartItemCard({
    Key key,
    this.cartItem,
    this.decreaseCount,
    this.increaseCount,
    this.job,
  }) : super(key: key);

  @override
  _CartItemCardState createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(
          5,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: widget.cartItem.photoURI,
                imageBuilder: (context, imageProvider) => Container(
                  margin: EdgeInsets.only(
                    right: 15,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        offset: Offset(
                          0,
                          3,
                        ),
                        blurRadius: 5,
                      ),
                    ],
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 80,
                  width: 80,
                ),
              ),
              Expanded(
                child: Text(
                  widget.cartItem.name,
                  style: GoogleFonts.oswald(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              widget.job == "history"
                  ? Expanded(
                      child: Container(
                        child: Text(
                          "x${widget.cartItem.quantity.toString()}",
                          style: GoogleFonts.nunito(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraint) {
                          return Container(
                            margin: EdgeInsets.only(
                              left: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  width: 20,
                                  height: 20,
                                  child: RawMaterialButton(
                                    fillColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                    onPressed: widget.decreaseCount,
                                    child: Icon(
                                      EvaIcons.minus,
                                      size: 10,
                                    ),
                                  ),
                                ),
                                Text(
                                  widget.cartItem.quantity.toString(),
                                  style: GoogleFonts.nunito(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 10,
                                  ),
                                  width: 20,
                                  height: 20,
                                  child: Center(
                                    child: RawMaterialButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      fillColor: Colors.white,
                                      onPressed: widget.increaseCount,
                                      child: Icon(
                                        EvaIcons.plus,
                                        size: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
              Text(
                "Rs.${widget.cartItem.totalPrice}",
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
