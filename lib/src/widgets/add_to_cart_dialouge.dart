import 'package:fastuserapp/src/bloc/order_cart_bloc.dart';
import 'package:fastuserapp/src/models/cart_items.dart';
import 'package:fastuserapp/src/models/item.dart';
import 'package:fastuserapp/src/widgets/add_on_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddToCartDialouge extends StatefulWidget {
  final MenuItem item;
  final Map<String, dynamic> user;
  final String vendorName;

  const AddToCartDialouge({
    Key key,
    this.item,
    this.vendorName,
    this.user,
  }) : super(key: key);

  @override
  _AddToCartDialougeState createState() => _AddToCartDialougeState();
}

class _AddToCartDialougeState extends State<AddToCartDialouge> {
  List<String> _addOn = [];
  int itemQuantity = 1;
  int totalCost = 0;
  bool _checked = false;

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
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.item.name.toUpperCase(),
              style: GoogleFonts.oswald(
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              widget.item.description.toUpperCase(),
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                fontSize: 10,
              ),
            ),
            Divider(),
            Text(
              "Add On's",
              style: GoogleFonts.nunito(
                color: Colors.orange[500],
                fontWeight: FontWeight.w800,
              ),
            ),
            ListView(
              shrinkWrap: true,
              children: widget.item.addOn
                  .map((addOn) => AddOnItem(
                        addOn: addOn,
                        onChecked: (value) {
                          if (value) {
                            _addOn.add(addOn);
                          } else {
                            _addOn.remove(addOn);
                          }
                        },
                      ))
                  .toList(),
            ),
            Expanded(child: Container()),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RawMaterialButton(
                          onPressed: () {
                            this.setState(() {
                              itemQuantity++;
                            });
                          },
                          child: Icon(Icons.add),
                        ),
                      ),
                      Text(
                        itemQuantity.toString(),
                      ),
                      Expanded(
                        child: RawMaterialButton(
                          onPressed: itemQuantity == 0
                              ? null
                              : () {
                                  this.setState(() {
                                    itemQuantity--;
                                  });
                                },
                          child: Icon(Icons.remove),
                        ),
                      ),
                    ],
                  ),
                ),
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
                            widget.vendorName,
                            parseToCartItem(
                              {
                                "name": widget.item.name,
                                "totalPrice": widget.item.price * itemQuantity,
                                "quantity": itemQuantity,
                                "price": widget.item.price,
                                "addOn": _addOn,
                              },
                            ),
                            widget.user,
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
