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
        fillColor: widget.isSelected ? Colors.orange[800] : Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            5,
          ),
        ),
        child: Text(
          widget.varient.name,
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.w700,
            color: widget.isSelected ? Colors.white : Colors.black38,
          ),
        ),
      ),
    );
  }
}
