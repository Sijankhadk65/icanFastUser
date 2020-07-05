import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgressItem extends StatelessWidget {
  final String name, keyword;
  final IconData icon;
  final Color color;
  final bool isDisabled;

  const ProgressItem(
      {Key key,
      this.name,
      this.keyword,
      this.icon,
      this.color,
      this.isDisabled})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(
        milliseconds: 300,
      ),
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(
          20,
        ),
        boxShadow: isDisabled
            ? []
            : [
                BoxShadow(
                  color: color,
                  offset: Offset(0, 5),
                  blurRadius: 15,
                  spreadRadius: -3,
                ),
              ],
      ),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 17,
            color: isDisabled ? Colors.black38 : Colors.white,
          ),
          Text(
            name,
            style: GoogleFonts.nunito(
              fontWeight: FontWeight.w900,
              color: isDisabled ? Colors.black38 : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
