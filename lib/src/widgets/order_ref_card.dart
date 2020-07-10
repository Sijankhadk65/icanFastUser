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
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: [
            Colors.orange[400],
            Colors.orange[800],
          ],
        ),
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
                  "order placed at ${_date.hour}:${_date.minute} ${_date.hour >= 12 ? "PM" : "AM"},today",
                  style: GoogleFonts.montserrat(
                    fontStyle: FontStyle.italic,
                    color: Colors.black26,
                  ),
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        widget.orderRef.user.name.toUpperCase(),
                        style: GoogleFonts.oswald(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    Text(
                      "Rs.${widget.orderRef.totalCost}",
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    )
                  ],
                ),
                // Text(
                //   "Orderd at: ${_date.hour}:${_date.minute} ${_date.hour >= 12 ? "PM" : "AM"}, ${_date.day == DateTime.now().day ? "today" : _date.day} ",
                //   style: GoogleFonts.montserrat(
                //     fontWeight: FontWeight.bold,
                //     fontStyle: FontStyle.italic,
                //     color: Colors.white,
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
