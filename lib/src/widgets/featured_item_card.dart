import 'package:cached_network_image/cached_network_image.dart';
import 'package:fastuserapp/src/bloc/cart_item_bloc.dart';
import 'package:fastuserapp/src/models/item.dart';
import 'package:fastuserapp/src/widgets/add_to_cart_dialouge.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FeaturedItemCard extends StatefulWidget {
  final MenuItem item;
  final Function() addToCart;
  final int minOrder;
  final String vendorName;
  final Map<String, dynamic> user;
  const FeaturedItemCard({
    Key key,
    this.item,
    this.addToCart,
    this.minOrder,
    this.vendorName,
    this.user,
  }) : super(key: key);
  @override
  _FeaturedItemCardState createState() => _FeaturedItemCardState();
}

class _FeaturedItemCardState extends State<FeaturedItemCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        margin: EdgeInsets.only(
          right: 10,
        ),
        child: CachedNetworkImage(
          imageUrl: widget.item.photoURI,
          imageBuilder: (context, imageProvider) => Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
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
                        blurRadius: 10,
                      )
                    ]),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    5,
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black87,
                    ],
                  ),
                ),
                padding: EdgeInsets.only(
                  left: 5,
                  right: 5,
                  bottom: 5,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.item.name.toUpperCase(),
                                  style: GoogleFonts.montserrat(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 5,
                            ),
                            child: Text(
                              "Price: Rs.${widget.item.price}",
                              style: GoogleFonts.montserrat(
                                color: Colors.white.withAlpha(
                                  180,
                                ),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => Provider(
                        create: (_) => CartItemBloc(),
                        child: AddToCartDialouge(
                          item: widget.item,
                          minOrder: widget.minOrder,
                          vendorName: widget.vendorName,
                          user: widget.user,
                        ),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(
                    5,
                  ),
                ),
              ),
            ],
          ),
        )
        // return Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     CachedNetworkImage(
        //       imageUrl: widget.item.photoURI,
        //       imageBuilder: (context, imageProvider) => Container(
        //         height: constraints.maxHeight * 0.65,
        //         width: double.infinity,
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(
        //             5,
        //           ),
        //           image: DecorationImage(
        //             image: imageProvider,
        //             fit: BoxFit.cover,
        //           ),
        //         ),
        //       ),
        //     ),
        //     Container(
        //       margin: EdgeInsets.only(
        //         left: 5,
        //         right: 5,
        //       ),
        //       child: Text(
        //         widget.item.name.toUpperCase(),
        //         style: GoogleFonts.oswald(
        //           fontSize: widget.item.name.length > 20 ? 15 : 18,
        //           fontWeight: FontWeight.w800,
        //         ),
        //       ),
        //     ),
        //     Container(
        //       margin: EdgeInsets.only(
        //         left: 5,
        //         right: 5,
        //       ),
        //       child: Text(
        //         widget.item.category.toUpperCase(),
        //         style: GoogleFonts.oswald(),
        //       ),
        //     ),
        //     AnimatedContainer(
        //       duration: Duration(milliseconds: 300),
        //       margin: EdgeInsets.only(
        //         left: 5,
        //         right: 5,
        //       ),
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(
        //           5,
        //         ),
        //         gradient: LinearGradient(
        //           begin: Alignment.topLeft,
        //           end: Alignment.bottomRight,
        //           colors: [
        //             Color(0xFF11998e),
        //             Color(0xFF38ef7d),
        //           ],
        //         ),
        //         boxShadow: [
        //           BoxShadow(
        //             color: Color(0xFF38ef7d).withAlpha(
        //               150,
        //             ),
        //             offset: Offset(
        //               0,
        //               3,
        //             ),
        //             blurRadius: 5,
        //           )
        //         ],
        //       ),
        //       padding: EdgeInsets.symmetric(
        //         horizontal: 10,
        //       ),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             "Rs.${widget.item.price.toString()}",
        //             style: GoogleFonts.nunito(
        //               fontSize: 16,
        //               fontStyle: FontStyle.italic,
        //               fontWeight: FontWeight.w600,
        //               color: Colors.white,
        //             ),
        //           ),
        //           Text(
        //             "Order",
        //             style: GoogleFonts.nunito(
        //               fontStyle: FontStyle.italic,
        //               fontSize: 12,
        //               color: Colors.white,
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // );

        );
  }
}
