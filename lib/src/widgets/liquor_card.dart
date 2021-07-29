import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fastuserapp/src/models/liquor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/item.dart';
import 'package:toast/toast.dart';

class LiquorCard extends StatefulWidget {
  final Liquor item;
  final Function() onTapped;
  final bool isFeatured;
  final Function onTap;
  const LiquorCard({
    Key key,
    @required this.item,
    @required this.onTapped,
    this.isFeatured,
    this.onTap,
  }) : super(key: key);

  @override
  _LiquorCardState createState() => _LiquorCardState();
}

class _LiquorCardState extends State<LiquorCard> {
  bool hasNoError = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(
        milliseconds: 300,
      ),
      margin: EdgeInsets.all(10),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(5),
        child: InkWell(
          onTap: (widget.item.isAvailable && hasNoError)
              ? widget.onTapped
              : () {
                  showToast(
                    "Item not available",
                    gravity: Toast.BOTTOM,
                    duration: Toast.LENGTH_LONG,
                  );
                },
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              CachedNetworkImage(
                imageUrl: widget.item.photoURI,
                progressIndicatorBuilder: (context, url, downloadProgress) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
                imageBuilder: (context, imageProvider) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  );
                },
                placeholder: (context, string) => Container(color: Colors.grey),
                errorWidget: (context, url, error) {
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
              widget.item.isAvailable
                  ? hasNoError
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.black12,
                                Colors.black87,
                              ],
                            ),
                          ),
                        )
                      : Container()
                  : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.red[300],
                            Colors.red[600],
                          ],
                        ),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    widget.item.name,
                                    style: GoogleFonts.oswald(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
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
                              "Price: Rs.${widget.item.price}",
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 10,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
}
