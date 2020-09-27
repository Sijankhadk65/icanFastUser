import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LocationPicker extends StatelessWidget {
  final String title, location;
  final IconData icon;
  final Function() onTap;
  const LocationPicker({
    Key key,
    this.onTap,
    this.title,
    this.icon,
    this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 5,
        top: 5,
      ),
      child: Material(
        elevation: location == null ? 0 : 5,
        borderRadius: BorderRadius.circular(
          5,
        ),
        child: InkWell(
          onTap: onTap,
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                margin: EdgeInsets.all(
                  10,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(
                    5,
                  ),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w800,
                      color: Colors.black38,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    location == null
                        ? "Set a location for easy delivery."
                        : location,
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w800,
                      color: Colors.black26,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
