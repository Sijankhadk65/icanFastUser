import 'package:cached_network_image/cached_network_image.dart';
import 'package:fastuserapp/src/app.dart';
import 'package:fastuserapp/src/bloc/cart_menu_bloc.dart';
import 'package:fastuserapp/src/bloc/offers_bloc.dart';
import 'package:fastuserapp/src/models/offers_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OffersScreen extends StatefulWidget {
  @override
  _OffersScreenState createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  OffersBloc _offersBloc;

  @override
  void didChangeDependencies() {
    _offersBloc = Provider.of<OffersBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _offersBloc.getOffers();
    return Scaffold(
      appBar: AppBar(
        title: Text("Offers"),
      ),
      body: StreamBuilder<List<OffersItem>>(
        stream: _offersBloc.offers,
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text("${snapshot.error}");
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text("Awaiting Bids....");
              break;
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.active:
              return ListView(
                children: snapshot.data
                    .map(
                      (offer) => Container(
                        height: 200,
                        margin: EdgeInsets.all(
                          10,
                        ),
                        child: Stack(
                          children: <Widget>[
                            CachedNetworkImage(
                              imageUrl: offer.photoURI,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    5,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black38,
                                      blurRadius: 5,
                                      offset: Offset(
                                        0,
                                        5,
                                      ),
                                    )
                                  ],
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.black12,
                                    Colors.black45,
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        offer.vendor.toUpperCase(),
                                        style: GoogleFonts.oswald(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w800,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      Text(
                                        " at just Rs.${offer.price}",
                                        style: GoogleFonts.oswald(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w800,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    offer.description,
                                    style: GoogleFonts.nunito(
                                      color: Colors.white,
                                      fontSize: 12,
                                      // fontWeight: FontWeight.w800,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                    .toList(),
              );
              break;
            case ConnectionState.done:
              return Text("The task has complted");
              break;
          }
          return null;
        },
      ),
    );
  }
}
