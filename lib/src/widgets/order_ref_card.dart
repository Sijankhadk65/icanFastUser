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
    "JAN",
    "FEB",
    "MAR",
    "APR",
    "MAY",
    "JUN",
    "JUL",
    "AUG",
    "SEP",
    "OCT",
    "NOV",
    "DEC",
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
        left: 10,
        right: 10,
        top: 20,
        bottom: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            offset: Offset(5, 5),
            blurRadius: 12,
          )
        ],
        color: Colors.white,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(5),
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
                  widget.orderRef.user.name.toUpperCase(),
                  style: GoogleFonts.oswald(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  widget.orderRef.physicalLocation,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    color: Colors.orange.withAlpha(
                      190,
                    ),
                  ),
                ),
                Text(
                  "${_date.hour}:${_date.minute} ${_date.hour >= 12 ? "PM" : "AM"}, ${_date.day == DateTime.now().day ? "today" : _date.day} ${_months[_date.month - 1]}",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.orange.withAlpha(
                      150,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
