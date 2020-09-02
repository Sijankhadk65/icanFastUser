import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesCard extends StatelessWidget {
  final String category, assetPath, message;
  final Function() onTap;

  const CategoriesCard({
    Key key,
    this.category,
    this.assetPath,
    this.message,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 5,
        left: 5,
        right: 5,
        bottom: 15,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(
              0,
              5,
            ),
            // spreadRadius: -15,
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(
            13,
          ),
          splashColor: Colors.orange[300],
          child: Padding(
            padding: EdgeInsets.only(
              left: 15,
              right: 15,
              top: 8,
              bottom: 8,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SvgPicture.asset(
                  assetPath,
                  height: 50,
                  width: 50,
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          category,
                          style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          message,
                          style: GoogleFonts.montserrat(
                            fontSize: MediaQuery.of(context).size.height < 1080
                                ? 8
                                : 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.withAlpha(
                              110,
                            ),
                          ),
                        ),
                      )
                    ],
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
