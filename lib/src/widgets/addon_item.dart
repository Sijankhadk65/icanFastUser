import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fastuserapp/src/models/add_on.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddOnItem extends StatefulWidget {
  final AddOn addOn;
  final bool isAdded;
  final Function() onTap;

  const AddOnItem({
    Key key,
    this.addOn,
    this.isAdded,
    this.onTap,
  }) : super(key: key);
  @override
  _AddOnItemState createState() => _AddOnItemState();
}

class _AddOnItemState extends State<AddOnItem> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(
        milliseconds: 150,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: widget.isAdded
              ? [
                  Colors.orange[700],
                  Colors.orange[500],
                ]
              : [
                  Colors.white,
                  Colors.white,
                ],
        ),
        borderRadius: BorderRadius.circular(
          5,
        ),
        boxShadow: widget.isAdded
            ? [
                BoxShadow(
                  color: Colors.black38,
                  offset: Offset(0, 3),
                  blurRadius: 5,
                ),
              ]
            : [],
      ),
      margin: EdgeInsets.all(
        5,
      ),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.only(
            right: 10,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  widget.isAdded
                      ? EvaIcons.checkmarkCircle2
                      : EvaIcons.plusCircleOutline,
                  color: widget.isAdded ? Colors.white : Colors.black,
                ),
                onPressed: widget.onTap,
              ),
              Expanded(
                child: Text(
                  widget.addOn.name,
                  style: GoogleFonts.nunito(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: widget.isAdded ? Colors.white : Colors.black,
                  ),
                ),
              ),
              Text(
                "Rs.${widget.addOn.price}",
                style: GoogleFonts.nunito(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: widget.isAdded ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
