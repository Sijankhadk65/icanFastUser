import 'package:fastuserapp/src/models/online_order.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckoutCartOrderCard extends StatelessWidget {
  final OnlineOrder order;
  const CheckoutCartOrderCard({
    Key key,
    this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(
          5,
        ),
        elevation: 5,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(
            5,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            order.vendor.toUpperCase(),
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          ListView(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            children: order.items
                                .map(
                                  (item) => RichText(
                                    text: TextSpan(
                                      text: item.name,
                                      children: [
                                        TextSpan(
                                          text: ",",
                                        ),
                                      ],
                                      style: GoogleFonts.nunito(
                                        fontSize: 10,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: RichText(
                            text: TextSpan(
                              text: "x",
                              style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: Colors.black,
                              ),
                              children:
                                  order.cartLength - order.cartLength.toInt() ==
                                          0
                                      ? [
                                          TextSpan(
                                            text: "${order.cartLength.toInt()}",
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          )
                                        ]
                                      : [],
                            ),
                          )
                          // (order.cartLength - order.cartLength.toInt() == 0)
                          //     ? Text(
                          //         "x ${order.cartLength.toInt()}",
                          //         style: GoogleFonts.nunito(
                          //           fontWeight: FontWeight.w600,
                          //         ),
                          //       )
                          //     : Row(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         children: [
                          //           Text(
                          //             "${order.cartLength.toInt()} ",
                          //             style: GoogleFonts.oswald(
                          //               fontSize: 18,
                          //             ),
                          //           ),
                          //           Column(
                          //             children: [
                          //               Text(
                          //                 "1",
                          //                 style: GoogleFonts.oswald(),
                          //               ),
                          //               Container(
                          //                   width: 10,
                          //                   height: 2,
                          //                   color: Colors.black),
                          //               Text(
                          //                 "2",
                          //                 style: GoogleFonts.oswald(),
                          //               ),
                          //             ],
                          //           ),
                          //         ],
                          //       ),
                          ),
                    ),
                    Text(
                      "Rs. ${order.totalPrice}",
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
