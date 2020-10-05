import 'package:fastuserapp/src/models/varient.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VarientButtonItem extends StatefulWidget {
  final Varient varient;
  final Function() onPressed;
  final bool isSelected;

  const VarientButtonItem({
    Key key,
    this.varient,
    this.onPressed,
    this.isSelected,
  }) : super(key: key);
  @override
  _VarientButtonItemState createState() => _VarientButtonItemState();
}

class _VarientButtonItemState extends State<VarientButtonItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: 10,
      ),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(
          5,
        ),
        child: InkWell(
          onTap: widget.onPressed,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 10,
              left: 15,
              right: 15,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.varient.name,
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w900,
                    fontSize: 10,
                    color:
                        widget.isSelected ? Colors.orange[500] : Colors.black87,
                  ),
                ),
                Text(
                  "Rs.${widget.varient.price}",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      //  RawMaterialButton(
      //   onPressed: widget.onPressed,
      //   fillColor: Colors.white,
      //   elevation: 0,
      //   padding: EdgeInsets.only(
      //     bottom: 10,
      //     top: 2,
      //   ),
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(
      //       5,
      //     ),
      //   ),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       // Text(
      //       //   "Rs.${widget.varient.price}",
      //       //   style: GoogleFonts.nunito(
      //       //     fontWeight: FontWeight.w700,
      //       //     fontSize: 15,
      //       //     color: widget.isSelected ? Colors.orange[500] : Colors.black38,
      //       //   ),
      //       // ),
      //       Text(
      //         widget.varient.name,
      //         style: GoogleFonts.nunito(
      //           fontWeight: FontWeight.w900,
      //           fontSize: 13,
      //           color: widget.isSelected ? Colors.orange[500] : Colors.black87,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
