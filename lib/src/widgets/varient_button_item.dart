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
      margin: EdgeInsets.only(left: 5, right: 5),
      child: RawMaterialButton(
        onPressed: widget.onPressed,
        fillColor: Colors.white,
        elevation: 0,
        padding: EdgeInsets.symmetric(
          vertical: 5,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            5,
          ),
          side: BorderSide(
            color: widget.isSelected ? Colors.orange[500] : Colors.black38,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Rs.${widget.varient.price}",
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.w700,
                fontSize: 15,
                color: widget.isSelected ? Colors.orange[500] : Colors.black38,
              ),
            ),
            Text(
              widget.varient.name,
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: widget.isSelected ? Colors.orange[500] : Colors.black38,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
