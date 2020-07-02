import 'package:cached_network_image/cached_network_image.dart';
import 'package:fastuserapp/src/bloc/cart_menu_bloc.dart';
import 'package:fastuserapp/src/models/offers_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OffersList extends StatefulWidget {
  @override
  _OffersListState createState() => _OffersListState();
}

class _OffersListState extends State<OffersList> {
  CartMenuBloc _cartMenuBloc;

  @override
  void didChangeDependencies() {
    _cartMenuBloc = Provider.of<CartMenuBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<OffersItem>>(
      stream: _cartMenuBloc.getOffers(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Text("Error: ${snapshot.error}");
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text("Awiating bids...");
            break;
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
            break;
          case ConnectionState.active:
            return ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: snapshot.data
                  .map(
                    (offer) => CachedNetworkImage(
                      imageUrl: offer.photoURI,
                      progressIndicatorBuilder: (context, msg, progess) =>
                          Center(
                        child: CircularProgressIndicator(),
                      ),
                      imageBuilder: (context, imageBuilder) => Container(
                        width: 150,
                        margin: EdgeInsets.only(
                          top: 10,
                          bottom: 5,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          elevation: 5,
                          child: Container(
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.black26,
                                        Colors.black54,
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                5,
                              ),
                              image: DecorationImage(
                                image: imageBuilder,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            );
            break;
          case ConnectionState.done:
            return Text("The task has completed");
            break;
        }
        return null;
      },
    );
  }
}
