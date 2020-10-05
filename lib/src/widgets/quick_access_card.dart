import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class QuickAccessCard extends StatelessWidget {
  final String title, description, assetPath;
  final double iconSize;
  final Function() onTap;

  const QuickAccessCard({
    Key key,
    this.title,
    this.description,
    this.assetPath,
    this.iconSize,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: EdgeInsets.all(
        10,
      ),
      // padding: EdgeInsets.only(
      //   left: 5,
      //   right: 5,
      // ),
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
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(
            10,
          ),
          splashColor: Colors.orange[300],
          onTap: onTap,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        flex: 4,
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/background/veg.jpg",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                        // SvgPicture.asset(
                        //   assetPath,
                        //   height:
                        //       MediaQuery.of(context).size.height < 1080 ? 60 : 80,
                        //   width:
                        //       MediaQuery.of(context).size.height < 1080 ? 60 : 80,
                        //   fit: BoxFit.contain,
                        // ),
                        ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        title,
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w800,
                          fontSize: MediaQuery.of(context).size.height < 1080
                              ? 11
                              : 15,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        description,
                        textAlign: TextAlign.center,
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
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
