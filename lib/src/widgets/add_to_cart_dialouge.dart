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
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddToCartDialouge extends StatefulWidget {
  final MenuItem item;
  final Map<String, dynamic> user;
  final String vendorName, vendorID;
  final int minOrder;
  final bool shouldSchedule, isNight;
  final DateTime openingTime, closingTime;
  const AddToCartDialouge({
    Key key,
    this.item,
    this.vendorName,
    this.user,
    this.minOrder,
    this.vendorID,
    this.shouldSchedule = false,
    this.openingTime,
    this.closingTime,
    this.isNight,
  }) : super(key: key);

  @override
  _AddToCartDialougeState createState() => _AddToCartDialougeState();
}

class _AddToCartDialougeState extends State<AddToCartDialouge> {
  // int _itemQuantity = 1;
  // String _note = "";

  CartItemBloc _cartItemBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cartItemBloc = Provider.of<CartItemBloc>(context);
    if (widget.item.price == 0) {
      _cartItemBloc.changeCurrentUnitPrice(0);
      _cartItemBloc.changeCurrentTotalPrice(0);
    } else {
      _cartItemBloc.changeCurrentUnitPrice(widget.item.price);
      _cartItemBloc.changeCurrentTotalPrice(widget.item.price);
    }
  }

  @override
  Widget build(BuildContext context) {
    _cartItemBloc.changeCurrentItemCount(1);
    _cartItemBloc.changeCurrentSelectedAddons([]);
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 10,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(
          5,
        ),
        elevation: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LayoutBuilder(
              builder: (context, constraint) {
                return Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: widget.item.photoURI,
                      imageBuilder: (context, imageProvider) => Container(
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(
                              5,
                            ),
                            bottomRight: Radius.circular(
                              5,
                            ),
                            topLeft: Radius.circular(
                              5,
                            ),
                            topRight: Radius.circular(
                              5,
                            ),
                          ),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            EvaIcons.closeOutline,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            right: 15,
                          ),
                          child: Icon(
                            EvaIcons.heartOutline,
                            size: 20,
                          ),
                        )
                      ],
                    ),
                  ],
                );
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.item.name,
                          style: GoogleFonts.oswald(
                            fontSize: 30,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: StreamBuilder<int>(
                            initialData: 0,
                            stream: _cartItemBloc.currentItemCount,
                            builder: (context, snapshot) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    5,
                                  ),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1.5,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: RawMaterialButton(
                                        onPressed: snapshot.data == 1
                                            ? null
                                            : () {
                                                _cartItemBloc
                                                    .changeCurrentItemCount(
                                                  snapshot.data - 1,
                                                );
                                                _cartItemBloc
                                                    .changeTotalPrice();
                                              },
                                        child: Icon(
                                          EvaIcons.minus,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          "${snapshot.data.toInt()} ${widget.item.unit != null ? widget.item.unit : "Pcs"}",
                                          style: GoogleFonts.oswald(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: RawMaterialButton(
                                        onPressed: () {
                                          _cartItemBloc.changeCurrentItemCount(
                                            snapshot.data + 1,
                                          );
                                          _cartItemBloc.changeTotalPrice();
                                        },
                                        child: Icon(
                                          EvaIcons.plus,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                              // Row(
                              //   children: <Widget>[
                              //     SizedBox(
                              //       width: 50,
                              //       child: RawMaterialButton(
                              //         fillColor: Colors.orange[500],
                              //         shape: RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.circular(
                              //             5,
                              //           ),
                              //         ),
                              //         onPressed: snapshot.data == 1
                              //             ? null
                              //             : () {
                              //                 _cartItemBloc
                              //                     .changeCurrentItemCount(
                              //                   snapshot.data - 1,
                              //                 );
                              //                 _cartItemBloc.changeTotalPrice();
                              //               },
                              //         child: Icon(
                              //           EvaIcons.minus,
                              //           color: Colors.white,
                              //         ),
                              //       ),
                              //     ),
                              //     Expanded(
                              //       child: Center(
                              //         child: Text(
                              //           "${snapshot.data.toInt()} ${widget.item.unit != null ? widget.item.unit : "Pcs"}",
                              //           style: GoogleFonts.oswald(
                              //             fontSize: 18,
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       width: 50,
                              //       child: RawMaterialButton(
                              //         shape: RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.circular(
                              //             5,
                              //           ),
                              //         ),
                              //         fillColor: Colors.orange[500],
                              //         onPressed: () {
                              //           _cartItemBloc.changeCurrentItemCount(
                              //             snapshot.data + 1,
                              //           );
                              //           _cartItemBloc.changeTotalPrice();
                              //         },
                              //         child: Icon(
                              //           EvaIcons.plus,
                              //           color: Colors.white,
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  widget.item.price == 0
                      ? StreamBuilder<Varient>(
                          stream: _cartItemBloc.currentSelectedVarient,
                          builder: (context, snapshot) {
                            return VarientButtonBar(
                              selectedVarient: snapshot.data,
                              varients: widget.item.varients.toList(),
                              onChange: (varient) {
                                _cartItemBloc
                                    .changeCurrentSelectedVarient(varient);
                                _cartItemBloc
                                    .changeCurrentUnitPrice(varient.price);
                                _cartItemBloc.changeTotalPrice();
                                _cartItemBloc.changeCurrentSelectedAddons([]);
                              },
                            );
                          },
                        )
                      : Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                            border: Border.all(
                              color: Colors.orange[500],
                              width: 2,
                            ),
                          ),
                          child: Text(
                            "Rs.${widget.item.price}",
                            style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: Colors.orange[500],
                            ),
                          ),
                        ),
                  widget.item.description != null
                      ? Container(
                          margin: EdgeInsets.only(
                            top: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Description",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                  color: Colors.orange[300],
                                ),
                              ),
                              Text(
                                widget.item.description,
                                textAlign: TextAlign.left,
                                style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black45,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Text(
                          "",
                        ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: 20,
                ),
                child: Column(
                  children: [
                    widget.item.addOns != null
                        ? widget.item.addOns.isNotEmpty
                            ? StreamBuilder<List<AddOn>>(
                                initialData: [],
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
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              padding: EdgeInsets.only(
                top: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.orange.withAlpha(
                  120,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    5,
                  ),
                  topRight: Radius.circular(
                    5,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: StreamBuilder<int>(
                      initialData: 0,
                      stream: _cartItemBloc.currentTotalPrice,
                      builder: (context, snapshot) {
                        return Column(
                          children: [
                            Text(
                              "Rs.${snapshot.data.toInt()}",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "Total Payable",
                              style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w800,
                                color: Colors.black38,
                                // fontSize: 20
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  StreamBuilder<int>(
                    stream: _cartItemBloc.currentTotalPrice,
                    builder: (context, snapshot) {
                      return AnimatedContainer(
                        duration: Duration(
                          milliseconds: 150,
                        ),
                        margin: EdgeInsets.only(
                          left: 10,
                          right: 10,
                          bottom: 10,
                        ),
                        decoration: BoxDecoration(
                          color: snapshot.data == 0
                              ? Colors.black.withAlpha(
                                  60,
                                )
                              : Color(
                                  0xFF11998e,
                                ),
                          // gradient: LinearGradient(
                          //   colors: snapshot.data == 0
                          //       ? [
                          //           Colors.black.withAlpha(
                          //             60,
                          //           ),
                          //           Colors.black.withAlpha(
                          //             60,
                          //           ),
                          //         ]
                          //       : [
                          //           Color(0xFF11998e),
                          //           Color(0xFF11998e),
                          //         ],
                          // ),
                          borderRadius: BorderRadius.circular(
                            5,
                          ),
                          boxShadow: snapshot.data == 0
                              ? []
                              : [
                                  BoxShadow(
                                    color: Colors.black38,
                                    offset: Offset(
                                      0,
                                      3,
                                    ),
                                    blurRadius: 5,
                                  )
                                ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: snapshot.data == 0
                                ? null
                                : () {
                                    orderCartBloc.addNewOrder(
                                      context,
                                      minOrder: widget.minOrder,
                                      newItem: parseToCartItem(
                                        _cartItemBloc.getItem(
                                          widget.item.name,
                                          widget.item.photoURI,
                                        ),
                                      ),
                                      shouldSchedule: widget.shouldSchedule,
                                      openingTime: widget.openingTime,
                                      closingTime: widget.closingTime,
                                      isNight: widget.isNight,
                                      user: widget.user,
                                      vendor: widget.vendorName,
                                      vendorID: widget.vendorID,
                                    );
                                    Navigator.pop(context);
                                  },
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Center(
                                child: RichText(
                                  text: TextSpan(
                                    text: "Add to cart !",
                                    style: GoogleFonts.montserrat(
                                      color: snapshot.data == 0
                                          ? Colors.black.withAlpha(
                                              60,
                                            )
                                          : Colors.white,
                                      // fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                    ),
                                    children: [],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    // Dialog(
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(5),
    //   ),
    //   child: Padding(
    //     padding: const EdgeInsets.all(
    //       10,
    //     ),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: <Widget>[
    //         Center(
    //           child: CachedNetworkImage(
    //             imageUrl: widget.item.photoURI,
    //             progressIndicatorBuilder: (context, msg, progess) => Center(
    //               child: CircularProgressIndicator(),
    //             ),
    //             errorWidget: (context, msg, error) => Center(
    //               child: Text(
    //                 error.toString(),
    //               ),
    //             ),
    //             imageBuilder: (context, imageBuilder) => Container(
    //               height: 150,
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(
    //                   5,
    //                 ),
    //                 image: DecorationImage(
    //                   image: imageBuilder,
    //                   fit: BoxFit.cover,
    //                 ),
    //                 boxShadow: [
    //                   BoxShadow(
    //                     color: Colors.grey,
    //                     offset: Offset(0, 5),
    //                     blurRadius: 10,
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //         SizedBox(
    //           height: 10,
    //         ),
    //         Text(
    //           widget.item.name.toUpperCase(),
    //           style: GoogleFonts.oswald(
    //             fontSize: 25,
    //             fontWeight: FontWeight.w700,
    //           ),
    //         ),
    //         widget.item.description != null
    //             ? Text(
    //                 widget.item.description.toUpperCase(),
    //                 style: GoogleFonts.montserrat(
    //                   fontWeight: FontWeight.w500,
    //                   fontSize: 10,
    //                 ),
    //               )
    //             : Container(),
    //         Divider(),
    //         widget.item.price == 0
    //             ? StreamBuilder<Varient>(
    //                 stream: _cartItemBloc.currentSelectedVarient,
    //                 builder: (context, snapshot) {
    //                   return Container(
    //                     height: 50,
    //                     child: VarientButtonBar(
    //                       selectedVarient: snapshot.data,
    //                       varients: widget.item.varients.toList(),
    //                       onChange: (varient) {
    //                         _cartItemBloc.changeCurrentSelectedVarient(varient);
    //                         _cartItemBloc.changeCurrentUnitPrice(
    //                             varient.price.toDouble());
    //                         _cartItemBloc.changeTotalPrice();
    //                         _cartItemBloc.changeCurrentSelectedAddons([]);
    //                       },
    //                     ),
    //                   );
    //                 },
    //               )
    //             : Container(),
    //         widget.item.addOns != null
    //             ? widget.item.addOns.isNotEmpty
    //                 ? StreamBuilder<List<AddOn>>(
    //                     stream: _cartItemBloc.currentSelectedAddons,
    //                     builder: (context, snapshot) {
    //                       return AddOnList(
    //                         addOns: widget.item.addOns.toList(),
    //                         selectedAddOns: snapshot.data,
    //                         onTap: _cartItemBloc.manageAddOn,
    //                       );
    //                     },
    //                   )
    //                 : Text("")
    //             : Text(""),
    //         StreamBuilder<double>(
    //             stream: _cartItemBloc.currentItemCount,
    //             builder: (context, snapshot) {
    //               return Row(
    //                 children: <Widget>[
    //                   SizedBox(
    //                     width: 50,
    //                     child: RawMaterialButton(
    //                       fillColor: snapshot.data == 1
    //                           ? Colors.grey
    //                           : Colors.orange[800],
    //                       shape: RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.circular(
    //                           5,
    //                         ),
    //                       ),
    //                       onPressed: snapshot.data == 1
    //                           ? null
    //                           : () {
    //                               _cartItemBloc.changeCurrentItemCount(
    //                                   snapshot.data - widget.item.increaseBy);
    //                               _cartItemBloc.changeTotalPrice();
    //                             },
    //                       child: Icon(
    //                         EvaIcons.minus,
    //                         color: Colors.white,
    //                       ),
    //                     ),
    //                   ),
    //                   Expanded(
    //                     child: Center(
    //                       child: snapshot.data - snapshot.data.toInt() == 0
    //                           ? Text(
    //                               "${snapshot.data.toInt()} ${widget.item.unit}",
    //                               style: GoogleFonts.oswald(
    //                                 fontSize: 18,
    //                               ),
    //                             )
    //                           : Row(
    //                               mainAxisAlignment: MainAxisAlignment.center,
    //                               children: [
    //                                 Text(
    //                                   "${snapshot.data.toInt()} ",
    //                                   style: GoogleFonts.oswald(
    //                                     fontSize: 18,
    //                                   ),
    //                                 ),
    //                                 Column(
    //                                   children: [
    //                                     Text(
    //                                       "1",
    //                                       style: GoogleFonts.oswald(),
    //                                     ),
    //                                     Container(
    //                                         width: 10,
    //                                         height: 2,
    //                                         color: Colors.black),
    //                                     Text(
    //                                       "2",
    //                                       style: GoogleFonts.oswald(),
    //                                     ),
    //                                   ],
    //                                 ),
    //                                 Text(
    //                                   " ${widget.item.unit}",
    //                                   style: GoogleFonts.oswald(
    //                                     fontSize: 18,
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                     ),
    //                   ),
    //                   SizedBox(
    //                     width: 50,
    //                     child: RawMaterialButton(
    //                       shape: RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.circular(
    //                           5,
    //                         ),
    //                       ),
    //                       fillColor: Colors.orange[800],
    //                       onPressed: () {
    //                         _cartItemBloc.changeCurrentItemCount(
    //                             snapshot.data + widget.item.increaseBy);
    //                         _cartItemBloc.changeTotalPrice();
    //                       },
    //                       child: Icon(
    //                         EvaIcons.plus,
    //                         color: Colors.white,
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               );
    //             },),
    //         Divider(),
    //         // Text("Total: $_totalCost"),
    //         StreamBuilder<double>(
    //           stream: _cartItemBloc.currentUnitPrice,
    //           builder: (context, snapshot) {
    //             return snapshot.data == 0
    //                 ? Text("Please Select a varient of the item")
    //                 : Text('Cost: Rs.${snapshot.data}');
    //           },
    //         ),
    //         StreamBuilder<double>(
    //           stream: _cartItemBloc.currentTotalPrice,
    //           builder: (context, snapshot) {
    //             return snapshot.data == 0
    //                 ? Text("Please Select a varient of the item")
    //                 : Text('Cost: Rs.${snapshot.data}');
    //           },
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.end,
    //           children: <Widget>[
    //             RawMaterialButton(
    //               elevation: 0,
    //               fillColor: Colors.grey,
    //               shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(
    //                   5,
    //                 ),
    //               ),
    //               onPressed: () {
    //                 Navigator.pop(context);
    //               },
    //               child: Padding(
    //                 padding: const EdgeInsets.all(5),
    //                 child: Text(
    //                   "Cancel",
    //                   style: GoogleFonts.nunito(
    //                     color: Colors.white,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             SizedBox(
    //               height: 10,
    //               width: 10,
    //             ),
    //             RawMaterialButton(
    //               elevation: _itemQuantity == 0 ? 0 : 5,
    //               fillColor: _itemQuantity == 0 ? Colors.grey : Colors.blue,
    //               shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(
    //                   5,
    //                 ),
    //               ),
    //               onPressed: _itemQuantity == 0
    //                   ? null
    //                   : () {
    //                       orderCartBloc.addNewOrder(
    //                         context,
    //                         widget.vendorName,
    //                         parseToCartItem(
    //                           _cartItemBloc.getItem(widget.item.name),
    //                         ),
    //                         widget.user,
    //                         widget.minOrder,
    //                       );
    //                       Navigator.pop(context);
    //                     },
    //               child: Padding(
    //                 padding: const EdgeInsets.all(5),
    //                 child: Text(
    //                   "Add to cart!",
    //                   style: GoogleFonts.nunito(
    //                     color: Colors.white,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}
