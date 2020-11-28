import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/order_ref.dart';
import '../screens/order_detail_screen.dart';

class OrderRefCard extends StatefulWidget {
  final OrderRef orderRef;

  const OrderRefCard({Key key, @required this.orderRef}) : super(key: key);

  @override
  _OrderRefCardState createState() => _OrderRefCardState();
}

class _OrderRefCardState extends State<OrderRefCard> {
  List<String> _months = [
    "JANUARY",
    "FEBRUARY",
    "MARCH",
    "APRIL",
    "MAY",
    "JUNE",
    "JULY",
    "AUGUST",
    "SEPTEMBER",
    "OCTOBER",
    "NOVEMBER",
    "DECEMBER",
  ];
  DateTime _date;
  @override
  void initState() {
    _date = DateTime.parse(widget.orderRef.createdAt);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          // left: 10,
          // right: 10,
          // top: 20,
          // bottom: 20,
          ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.deepOrangeAccent[700],
          highlightColor: Colors.greenAccent[700],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => OrderDetailScreen(
                  orderRef: widget.orderRef.refID,
                ),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.only(
              top: 5,
              left: 10,
              bottom: 5,
              right: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.orderRef.refID}",
                  style: GoogleFonts.montserrat(
                    fontStyle: FontStyle.italic,
                    color: Colors.orange[800],
                  ),
                ),
                Text(
                  widget.orderRef.physicalLocation.toUpperCase(),
                  style: GoogleFonts.montserrat(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "${_months[_date.month - 1]} ${_date.day == DateTime.now().day ? "today" : _date.day} ${_date.year}, ${_date.hour}:${_date.minute} ${_date.hour >= 12 ? "PM" : "AM"}",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    color: Colors.black.withAlpha(
                      150,
                    ),
                  ),
                ),
                // Text(
                //   widget.orderRef.user.name ?? "No Location was found",
                //   style: GoogleFonts.notoSerif(
                //     fontStyle: FontStyle.italic,
                //   ),
                // ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
