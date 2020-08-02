import 'package:fastuserapp/src/bloc/cart_menu_bloc.dart';
import 'package:fastuserapp/src/bloc/liquor_bloc.dart';
import 'package:fastuserapp/src/bloc/order_cart_bloc.dart';
import 'package:fastuserapp/src/models/liquor.dart';
import 'package:fastuserapp/src/models/online_order.dart';
import 'package:fastuserapp/src/widgets/add_liquor_to_cart.dart';
import 'package:fastuserapp/src/widgets/add_to_cart_dialouge.dart';
import 'package:fastuserapp/src/widgets/custom_tab_bar.dart';
import 'package:fastuserapp/src/widgets/liquor_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'cart_screen.dart';

class LiquorScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  const LiquorScreen({Key key, this.user}) : super(key: key);
  @override
  _LiquorScreenState createState() => _LiquorScreenState();
}

class _LiquorScreenState extends State<LiquorScreen> {
  final List<String> _liquorCategories = [
    "beer",
    "wine",
    "wishkey",
    "vodka",
    "gin",
  ];

  LiquorBloc _liquorBloc;
  CartMenuBloc _cartMenuBloc;

  @override
  void didChangeDependencies() {
    _liquorBloc = Provider.of<LiquorBloc>(context);
    _cartMenuBloc = Provider.of<CartMenuBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _cartMenuBloc.getFavourites("food", widget.user['email']);
    return Scaffold(
      appBar: AppBar(
        title: Text("Liquors"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: CustomTabView(
                itemCount: _liquorCategories.length,
                tabBuilder: (context, index) => Text(
                  _liquorCategories[index].toUpperCase(),
                ),
                pageBuilder: (context, index) => StreamBuilder<List<Liquor>>(
                  stream: _liquorBloc.getLiquors(_liquorCategories[index]),
                  builder: (context, snapshot) {
                    if (snapshot.hasError)
                      return Text("Error: ${snapshot.error}");
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Text("Awaiting Bids..");
                        break;
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                        break;
                      case ConnectionState.active:
                        return snapshot.data.isNotEmpty
                            ? StreamBuilder(
                                stream: _cartMenuBloc.getFavourites(
                                    "food", widget.user['email']),
                                builder: (context, favouritesSnapshot) {
                                  if (favouritesSnapshot.hasError)
                                    return Text("${favouritesSnapshot.error}");
                                  switch (favouritesSnapshot.connectionState) {
                                    case ConnectionState.none:
                                      return Text("Awaiting Bids...");
                                      break;
                                    case ConnectionState.waiting:
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                      break;
                                    case ConnectionState.active:
                                      return GridView.count(
                                        crossAxisCount: 2,
                                        children: snapshot.data
                                            .map(
                                              (liquor) => LiquorCard(
                                                item: liquor,
                                                onTapped: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AddLiquorToCart(
                                                      item: liquor,
                                                      user: widget.user,
                                                    ),
                                                  );
                                                },
                                                onTap: () {
                                                  _cartMenuBloc.toogleFavourite(
                                                    favouritesSnapshot.data
                                                        .contains(liquor.name),
                                                    "food",
                                                    widget.user['email'],
                                                    {
                                                      "name": liquor.name,
                                                      "createdAt":
                                                          liquor.createdAt,
                                                    },
                                                  );
                                                },
                                                isFeatured: favouritesSnapshot
                                                    .data
                                                    .contains(liquor.name),
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
            ),
            StreamBuilder<List<OnlineOrder>>(
              stream: orderCartBloc.localOrder,
              builder: (context, localOrder) {
                return StreamBuilder<OnlineOrder>(
                  stream: orderCartBloc.currentOrder,
                  builder: (context, orderSnapshot) {
                    return LayoutBuilder(
                      builder: (context, constraint) {
                        return orderSnapshot.hasData
                            ? Container(
                                height: 65,
                                child: Material(
                                  color: Colors.blue[800],
                                  elevation: 10,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => CartScreen(
                                            user: widget.user,
                                            vendor: "Liquor",
                                            minOrder: 300,
                                            orderCartLength:
                                                localOrder.data.length,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            orderSnapshot.data.vendor,
                                            style: GoogleFonts.montserrat(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                          Expanded(
                                            child: Stack(
                                              alignment: Alignment.centerLeft,
                                              children: [
                                                StreamBuilder<int>(
                                                    stream: orderCartBloc
                                                        .totalLength,
                                                    builder:
                                                        (context, snapshot) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 10.0,
                                                        ),
                                                        child: Stack(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .shopping_cart,
                                                              size: 30,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            Positioned(
                                                              top: 0,
                                                              right: 0,
                                                              child: Container(
                                                                height: 15,
                                                                width: 15,
                                                                child: Material(
                                                                  color: Colors
                                                                          .orange[
                                                                      800],
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      15,
                                                                    ),
                                                                  ),
                                                                  elevation: 5,
                                                                  child: Center(
                                                                    child: Text(
                                                                      "${snapshot.data}",
                                                                      style: GoogleFonts
                                                                          .oswald(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            10,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                                Center(
                                                  child: StreamBuilder(
                                                    stream: orderCartBloc
                                                        .totalPrice,
                                                    builder:
                                                        (context, snapshot) {
                                                      return Center(
                                                        child: Text(
                                                          "Total Cost (Rs.${snapshot.data})",
                                                          style: GoogleFonts
                                                              .montserrat(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container();
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
