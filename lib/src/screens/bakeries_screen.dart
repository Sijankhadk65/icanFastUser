import 'package:fastuserapp/src/bloc/bakeries_bloc.dart';
import 'package:fastuserapp/src/bloc/cart_menu_bloc.dart';
import 'package:fastuserapp/src/models/vendor.dart';
import 'package:fastuserapp/src/widgets/source_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BakeriesScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  const BakeriesScreen({
    Key key,
    this.user,
  }) : super(key: key);
  @override
  _BakeriesScreenState createState() => _BakeriesScreenState();
}

class _BakeriesScreenState extends State<BakeriesScreen> {
  BakeriesBloc _bakeriesBloc;
  CartMenuBloc _cartMenuBloc;

  @override
  void didChangeDependencies() {
    _bakeriesBloc = Provider.of<BakeriesBloc>(context);
    _cartMenuBloc = Provider.of<CartMenuBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _bakeriesBloc.getBakeries();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bakeries",
        ),
      ),
      body: Container(
        child: StreamBuilder<List<Vendor>>(
          stream: _bakeriesBloc.bakeries,
          builder: (context, snapshot) {
            if (snapshot.hasError) return Text("Error: ${snapshot.error}");
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text("Awaiting Bids...");
                break;
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
                break;
              case ConnectionState.active:
                return snapshot.data.isNotEmpty
                    ? StreamBuilder<List<String>>(
                        stream: _cartMenuBloc.getFavourites(
                          "resturant",
                          widget.user['email'],
                        ),
                        builder: (context, favouriteSnapshot) {
                          if (favouriteSnapshot.hasError)
                            return Text("Error: ${favouriteSnapshot.error}");
                          switch (favouriteSnapshot.connectionState) {
                            case ConnectionState.none:
                              return Text("Awating bids...");
                              break;
                            case ConnectionState.waiting:
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                              break;
                            case ConnectionState.active:
                              return ListView(
                                children: snapshot.data
                                    .map(
                                      (bakery) => SourceCard(
                                        vendor: bakery,
                                        isFeatured: favouriteSnapshot.data
                                            .contains(bakery.name),
                                        user: widget.user,
                                        onTap: () {
                                          _cartMenuBloc.toogleFavourite(
                                            favouriteSnapshot.data
                                                .contains(bakery.name),
                                            "resturant",
                                            widget.user['email'],
                                            {
                                              "name": bakery.name,
                                            },
                                          );
                                        },
                                      ),
                                    )
                                    .toList(),
                              );
                              break;
                            case ConnectionState.done:
                              return Text("The task  has complted");
                              break;
                          }
                          return null;
                        },
                      )
                    : Center(
                        child: Text("Coming Soon"),
                      );
                break;
              case ConnectionState.done:
                return Text("The task has completed");
                break;
            }
            return null;
          },
        ),
      ),
    );
  }
}
