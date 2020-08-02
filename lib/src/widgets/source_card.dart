import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/cart_menu_bloc.dart';
import '../models/vendor.dart';
import '../screens/vendor_screen.dart';
import 'package:provider/provider.dart';

class SourceCard extends StatefulWidget {
  final Vendor vendor;
  final Map<String, dynamic> user;
  final Function() onTap;
  final bool isFeatured;
  const SourceCard({
    Key key,
    @required this.vendor,
    this.user,
    this.onTap,
    this.isFeatured,
  }) : super(key: key);

  @override
  _SourceCardState createState() => _SourceCardState();
}

class _SourceCardState extends State<SourceCard> {
  bool hasError = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: EdgeInsets.all(10),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(5),
        child: InkWell(
          onTap: widget.vendor.isAway
              ? () {}
              : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Provider(
                        create: (_) => CartMenuBloc(),
                        dispose: (context, CartMenuBloc bloc) => bloc.dispose(),
                        child: VendorScreen(
                          vendorRating: widget.vendor.averageRating,
                          vendorName: widget.vendor.name,
                          categories: widget.vendor.categories.toList(),
                          user: widget.user,
                          minOrder: widget.vendor.minOrder,
                        ),
                      ),
                    ),
                  );
                },
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              CachedNetworkImage(
                imageUrl: widget.vendor.photoURI,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(),
                imageBuilder: (context, imageProvider) {
                  if (hasError) {
                    hasError = false;
                  }
                  return Container(
                    // height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  );
                },
                placeholder: (context, string) => Container(color: Colors.grey),
                errorWidget: (context, url, error) {
                  this.setState(
                    () {
                      if (!hasError) {
                        hasError = true;
                      }
                    },
                  );
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Text(
                        error.toString(),
                      ),
                    ),
                  );
                },
              ),
              !hasError
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.transparent,
                            Colors.black26,
                            Colors.black45,
                          ],
                        ),
                      ),
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.orange[300],
                            Colors.orange[900],
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            offset: Offset(7, 7),
                            blurRadius: 5,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(
                          5,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Min.",
                              style: GoogleFonts.oswald(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Rs.${widget.vendor.minOrder}",
                              style: GoogleFonts.oswald(
                                  fontSize: 13, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            widget.vendor.name.toUpperCase(),
                            style: GoogleFonts.oswald(
                              fontSize: 23,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            widget.isFeatured
                                ? EvaIcons.bookmark
                                : EvaIcons.bookmarkOutline,
                            color: Colors.white,
                          ),
                          onPressed: widget.onTap,
                        )
                      ],
                    ),
                    Text(
                      "${widget.vendor.physicalLocation}",
                      style: GoogleFonts.montserrat(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic),
                    ),
                    Text(
                      "Opens at ${widget.vendor.openTime} & Closes at ${widget.vendor.closeTime} ",
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 10,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    widget.vendor.isBusy
                        ? Row(
                            children: <Widget>[
                              Icon(
                                EvaIcons.alertCircle,
                                color: Colors.red[700],
                                size: 20,
                              ),
                              Expanded(
                                child: Text(
                                  "The vendor is currently busy which may lead to delayed delivery.",
                                  style: GoogleFonts.montserrat(
                                    color: Colors.red[700],
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    widget.vendor.isAway
                        ? Row(
                            children: <Widget>[
                              Icon(
                                EvaIcons.alertCircle,
                                color: Colors.red[700],
                                size: 20,
                              ),
                              Expanded(
                                child: Text(
                                  "The vendor is currently unavailable..",
                                  style: GoogleFonts.montserrat(
                                    color: Colors.red[700],
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container()
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
