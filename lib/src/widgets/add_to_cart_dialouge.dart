import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fastuserapp/src/bloc/cart_item_bloc.dart';
import 'package:fastuserapp/src/bloc/order_cart_bloc.dart';
import 'package:fastuserapp/src/models/add_on.dart';
import 'package:fastuserapp/src/models/cart_items.dart';
import 'package:fastuserapp/src/models/item.dart';
import 'package:fastuserapp/src/models/varient.dart';
import 'package:fastuserapp/src/widgets/addon_list.dart';
import 'package:fastuserapp/src/widgets/varient_button_bar.dart';
import 'package:flutter/material.dart';
import 'package:fraction/fraction.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddToCartDialouge extends StatefulWidget {
  final MenuItem item;
  final Map<String, dynamic> user;
  final String vendorName;
  final int minOrder;

  const AddToCartDialouge({
    Key key,
    this.item,
    this.vendorName,
    this.user,
    this.minOrder,
  }) : super(key: key);

  @override
  _AddToCartDialougeState createState() => _AddToCartDialougeState();
}

class _AddToCartDialougeState extends State<AddToCartDialouge> {
  int _itemQuantity = 1;
  String _note = "";

  CartItemBloc _cartItemBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cartItemBloc = Provider.of<CartItemBloc>(context);
    if (widget.item.price == 0) {
      _cartItemBloc.changeCurrentUnitPrice(0);
      _cartItemBloc.changeCurrentTotalPrice(0);
    } else {
      _cartItemBloc.changeCurrentUnitPrice(widget.item.price.toDouble());
      _cartItemBloc.changeCurrentTotalPrice(widget.item.price.toDouble());
    }
  }

  @override
  Widget build(BuildContext context) {
    _cartItemBloc.changeCurrentItemCount(1);
    _cartItemBloc.changeCurrentSelectedAddons([]);
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
                  height: 150,
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
            widget.item.price == 0
                ? StreamBuilder<Varient>(
                    stream: _cartItemBloc.currentSelectedVarient,
                    builder: (context, snapshot) {
                      return Container(
                        height: 50,
                        child: VarientButtonBar(
                          selectedVarient: snapshot.data,
                          varients: widget.item.varients.toList(),
                          onChange: (varient) {
                            _cartItemBloc.changeCurrentSelectedVarient(varient);
                            _cartItemBloc.changeCurrentUnitPrice(
                                varient.price.toDouble());
                            _cartItemBloc.changeTotalPrice();
                            _cartItemBloc.changeCurrentSelectedAddons([]);
                          },
                        ),
                      );
                    },
                  )
                : Container(),
            widget.item.addOns != null
                ? widget.item.addOns.isNotEmpty
                    ? StreamBuilder<List<AddOn>>(
                        stream: _cartItemBloc.currentSelectedAddons,
                        builder: (context, snapshot) {
                          return AddOnList(
                            addOns: widget.item.addOns.toList(),
                            selectedAddOns: snapshot.data,
                            onTap: _cartItemBloc.manageAddOn,
                          );
                        },
                      )
                    : Text("")
                : Text(""),
            StreamBuilder<double>(
                stream: _cartItemBloc.currentItemCount,
                builder: (context, snapshot) {
                  return Row(
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                        child: RawMaterialButton(
                          fillColor: snapshot.data == 1
                              ? Colors.grey
                              : Colors.orange[800],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                          ),
                          onPressed: snapshot.data == 1
                              ? null
                              : () {
                                  _cartItemBloc.changeCurrentItemCount(
                                      snapshot.data - widget.item.increaseBy);
                                  _cartItemBloc.changeTotalPrice();
                                },
                          child: Icon(
                            EvaIcons.minus,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: snapshot.data - snapshot.data.toInt() == 0
                              ? Text(
                                  "${snapshot.data.toInt()} ${widget.item.unit}",
                                  style: GoogleFonts.oswald(
                                    fontSize: 18,
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${snapshot.data.toInt()} ",
                                      style: GoogleFonts.oswald(
                                        fontSize: 18,
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "1",
                                          style: GoogleFonts.oswald(),
                                        ),
                                        Container(
                                            width: 10,
                                            height: 2,
                                            color: Colors.black),
                                        Text(
                                          "2",
                                          style: GoogleFonts.oswald(),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      " ${widget.item.unit}",
                                      style: GoogleFonts.oswald(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
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
                            _cartItemBloc.changeCurrentItemCount(
                                snapshot.data + widget.item.increaseBy);
                            _cartItemBloc.changeTotalPrice();
                          },
                          child: Icon(
                            EvaIcons.plus,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
            Divider(),
            // Text("Total: $_totalCost"),
            StreamBuilder<double>(
              stream: _cartItemBloc.currentUnitPrice,
              builder: (context, snapshot) {
                return snapshot.data == 0
                    ? Text("Please Select a varient of the item")
                    : Text('Cost: Rs.${snapshot.data}');
              },
            ),
            StreamBuilder<double>(
              stream: _cartItemBloc.currentTotalPrice,
              builder: (context, snapshot) {
                return snapshot.data == 0
                    ? Text("Please Select a varient of the item")
                    : Text('Cost: Rs.${snapshot.data}');
              },
            ),
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
                  elevation: _itemQuantity == 0 ? 0 : 5,
                  fillColor: _itemQuantity == 0 ? Colors.grey : Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      5,
                    ),
                  ),
                  onPressed: _itemQuantity == 0
                      ? null
                      : () {
                          orderCartBloc.addNewOrder(
                            context,
                            widget.vendorName,
                            parseToCartItem(
                              _cartItemBloc.getItem(widget.item.name),
                            ),
                            widget.user,
                            widget.minOrder,
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
