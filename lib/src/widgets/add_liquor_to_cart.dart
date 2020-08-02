import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fastuserapp/src/bloc/order_cart_bloc.dart';
import 'package:fastuserapp/src/models/cart_items.dart';
import 'package:fastuserapp/src/models/liquor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddLiquorToCart extends StatefulWidget {
  final Liquor item;
  final Map<String, dynamic> user;

  const AddLiquorToCart({
    Key key,
    this.item,
    this.user,
  }) : super(key: key);

  @override
  _AddLiquorToCartState createState() => _AddLiquorToCartState();
}

class _AddLiquorToCartState extends State<AddLiquorToCart> {
  int itemQuantity = 1;
  int totalCost = 0;
  String _note = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CachedNetworkImage(
                imageUrl: widget.item.photoURI,
                progressIndicatorBuilder: (context, msg, progess) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, msg, error) => Center(
                  child: Text(
                    error.toString(),
                  ),
                ),
                imageBuilder: (context, imageBuilder) => Container(
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      5,
                    ),
                    image: DecorationImage(
                      image: imageBuilder,
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 5),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.item.name.toUpperCase(),
              style: GoogleFonts.oswald(
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
            widget.item.description != null
                ? Text(
                    widget.item.description.toUpperCase(),
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                    ),
                  )
                : Container(),
            Divider(),
            Text(
              "Note *",
              style: GoogleFonts.nunito(
                color: Colors.orange[800],
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Container(
                height: 50,
                margin: EdgeInsets.only(top: 10, bottom: 10),
                padding: EdgeInsets.only(
                  left: 5,
                  right: 5,
                  bottom: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    )
                  ],
                ),
                child: TextField(
                  maxLength: 200,
                  maxLines: 50,
                  onChanged: (value) {
                    this.setState(
                      () {
                        _note = value;
                      },
                    );
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    hintText:
                        "Type your special instructions here.\n Less Spicy or more spicy",
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 50,
                  child: RawMaterialButton(
                    fillColor:
                        itemQuantity == 1 ? Colors.grey : Colors.orange[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                    ),
                    onPressed: itemQuantity == 1
                        ? null
                        : () {
                            this.setState(() {
                              itemQuantity--;
                            });
                          },
                    child: Icon(
                      EvaIcons.minus,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "$itemQuantity",
                      style: GoogleFonts.oswald(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: RawMaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                    ),
                    fillColor: Colors.orange[800],
                    onPressed: () {
                      this.setState(
                        () {
                          itemQuantity++;
                        },
                      );
                    },
                    child: Icon(
                      EvaIcons.plus,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RawMaterialButton(
                  elevation: 0,
                  fillColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      5,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      "Cancel",
                      style: GoogleFonts.nunito(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                  width: 10,
                ),
                RawMaterialButton(
                  elevation: itemQuantity == 0 ? 0 : 5,
                  fillColor: itemQuantity == 0 ? Colors.grey : Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      5,
                    ),
                  ),
                  onPressed: itemQuantity == 0
                      ? null
                      : () {
                          orderCartBloc.addNewOrder(
                            context,
                            "Liquor",
                            parseToCartItem(
                              {
                                "name": widget.item.name,
                                "totalPrice": widget.item.price * itemQuantity,
                                "quantity": itemQuantity,
                                "price": widget.item.price,
                                "note": _note,
                              },
                            ),
                            widget.user,
                            300,
                          );
                          Navigator.pop(context);
                        },
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      "Add to cart!",
                      style: GoogleFonts.nunito(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
