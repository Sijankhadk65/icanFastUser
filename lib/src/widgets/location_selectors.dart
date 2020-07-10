import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LocationSelector extends StatelessWidget {
  final String name;
  final bool isActive;
  final Function() changeLocation;
  final EdgeInsets margins;

  const LocationSelector({
    Key key,
    this.name,
    this.isActive,
    this.changeLocation,
    this.margins,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: margins,
      duration: Duration(
        milliseconds: 300,
      ),
      decoration: BoxDecoration(
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 5),
                  blurRadius: 5,
                )
              ]
            : [],
        color: isActive ? Colors.orange : Colors.white,
        border: isActive
            ? Border.all(
                color: Colors.transparent,
              )
            : Border.all(
                color: Colors.orange,
                width: 2,
              ),
        borderRadius: BorderRadius.circular(
          5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: changeLocation,
          child: Padding(
            padding: const EdgeInsets.all(
              10,
            ),
            child: Center(
              child: Text(
                name,
                style: GoogleFonts.nunito(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: isActive ? Colors.white : Colors.orange,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
