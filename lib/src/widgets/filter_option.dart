import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterOption extends StatelessWidget {
  final EdgeInsets margin;
  final bool isActive;
  final Function() onTap;
  final IconData icon;
  final String name;
  const FilterOption({
    Key key,
    this.margin,
    this.isActive,
    this.onTap,
    this.icon,
    this.name,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(
        milliseconds: 300,
      ),
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          5,
        ),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isActive
                ? [
                    Colors.orange[200],
                    Colors.orange[800],
                  ]
                : [
                    Colors.grey,
                    Colors.grey,
                  ]),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5,
                  offset: Offset(0, 5),
                )
              ]
            : [],
      ),
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(
                5,
              ),
              child: Center(
                child: Text(
                  name.toUpperCase(),
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    color: isActive ? Colors.white : Colors.black26,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: -15,
            right: 35,
            child: SizedBox(
              height: 55,
              width: 55,
              child: Material(
                elevation: isActive ? 10 : 0,
                type: MaterialType.circle,
                color: Colors.white,
                child: Center(
                  child: Icon(
                    icon,
                    color: isActive ? Colors.orange[500] : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
