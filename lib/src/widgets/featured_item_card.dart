import 'package:cached_network_image/cached_network_image.dart';
import 'package:fastuserapp/src/models/item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeaturedItemCard extends StatefulWidget {
  final MenuItem item;
  final Function() addToCart;

  const FeaturedItemCard({
    Key key,
    this.item,
    this.addToCart,
  }) : super(key: key);
  @override
  _FeaturedItemCardState createState() => _FeaturedItemCardState();
}

class _FeaturedItemCardState extends State<FeaturedItemCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
          left: 7.5,
          right: 7.5,
          bottom: 15,
        ),
        child: CachedNetworkImage(
          imageUrl: widget.item.photoURI,
          imageBuilder: (context, imageProvider) => Container(
            width: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 5,
                  offset: Offset(
                    0,
                    5,
                  ),
                )
              ],
              borderRadius: BorderRadius.circular(
                5,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.addToCart,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Material(
                        elevation: 5,
                        shadowColor: Colors.black,
                        borderRadius: BorderRadius.circular(
                          5,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    widget.item.name.toUpperCase(),
                                    style: GoogleFonts.oswald(
                                      fontSize: 20,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.orange[800],
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
        // SlimyCard(
        //   topCardHeight: 150,
        //   bottomCardHeight: 100,
        //   color: Colors.orange,
        //   // slimeEnabled: false,
        //   borderRadius: 15,
        //   bottomCardWidget: SizedBox(
        //     width: 200,
        //     height: 50,
        //     child: RawMaterialButton(
        //       onPressed: widget.addToCart,
        //       fillColor: Colors.white,
        //       elevation: 10,
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(
        //           5,
        //         ),
        //       ),
        //       child: Text(
        //         "Add to cart",
        //         style: GoogleFonts.nunito(
        //           fontWeight: FontWeight.w800,
        //           fontSize: 17,
        //           color: Colors.orange,
        //         ),
        //       ),
        //     ),
        //   ),
        //   topCardWidget: CachedNetworkImage(
        //     imageUrl: widget.item.photoURI,
        //     imageBuilder: (context, imageProvider) => Stack(
        //       children: <Widget>[
        //         Container(
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(
        //               15,
        //             ),
        //             image: DecorationImage(
        //               image: imageProvider,
        //               fit: BoxFit.cover,
        //             ),
        //             boxShadow: [
        //               BoxShadow(
        //                 color: Colors.black26,
        //                 offset: Offset(
        //                   0,
        //                   2,
        //                 ),
        //                 blurRadius: 5,
        //               )
        //             ],
        //           ),
        //         ),
        //         Padding(
        //           padding: EdgeInsets.all(
        //             10,
        //           ),
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             mainAxisAlignment: MainAxisAlignment.end,
        //             children: <Widget>[
        //               Text(
        //                 widget.item.name,
        //                 style: GoogleFonts.oswald(
        //                   fontWeight: FontWeight.w800,
        //                   fontStyle: FontStyle.italic,
        //                   fontSize: 18,
        //                   shadows: [
        //                     Shadow(
        //                       color: Colors.black38,
        //                       blurRadius: 5,
        //                       offset: Offset(
        //                         0,
        //                         0,
        //                       ),
        //                     )
        //                   ],
        //                   color: Colors.white,
        //                 ),
        //               ),
        //               Text(
        //                 "Rs.${widget.item.price}",
        //                 style: GoogleFonts.oswald(
        //                   fontWeight: FontWeight.w800,
        //                   fontStyle: FontStyle.italic,
        //                   shadows: [
        //                     Shadow(
        //                       color: Colors.black38,
        //                       blurRadius: 5,
        //                       offset: Offset(
        //                         0,
        //                         0,
        //                       ),
        //                     )
        //                   ],
        //                   color: Colors.white,
        //                 ),
        //               ),
        //             ],
        //           ),
        //         )
        //       ],
        //     ),
        //   ),
        // ),
        );
  }
}
