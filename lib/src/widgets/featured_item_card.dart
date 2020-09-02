import 'package:cached_network_image/cached_network_image.dart';
import 'package:fastuserapp/src/models/item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeaturedItemCard extends StatefulWidget {
  final MenuItem item;
  final Function() addToCart;

  const FeaturedItemCard({
    Key key,
    this.item,
    this.addToCart,
  }) : super(key: key);
  @override
  _FeaturedItemCardState createState() => _FeaturedItemCardState();
}

class _FeaturedItemCardState extends State<FeaturedItemCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(
        right: 10,
      ),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(
          5,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: widget.item.photoURI,
                  imageBuilder: (context, imageProvider) => Container(
                    height: constraints.maxHeight * 0.65,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 5,
                    right: 5,
                  ),
                  child: Text(
                    widget.item.name.toUpperCase(),
                    style: GoogleFonts.oswald(
                      fontSize: widget.item.name.length > 20 ? 15 : 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 5,
                    right: 5,
                  ),
                  child: Text(
                    widget.item.category.toUpperCase(),
                    style: GoogleFonts.oswald(
                        // fontSize: widget.item.name.length > 20 ? 15 : 18,
                        // fontWeight: FontWeight.w800,
                        ),
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.only(
                    left: 5,
                    right: 5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      5,
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF11998e),
                        Color(0xFF38ef7d),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF38ef7d).withAlpha(
                          150,
                        ),
                        offset: Offset(
                          0,
                          3,
                        ),
                        blurRadius: 5,
                      )
                    ],
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rs.${widget.item.price.toString()}",
                        style: GoogleFonts.nunito(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Order",
                        style: GoogleFonts.nunito(
                          fontStyle: FontStyle.italic,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
