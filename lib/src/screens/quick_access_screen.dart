import 'package:fastuserapp/src/bloc/cart_menu_bloc.dart';
import 'package:fastuserapp/src/models/item.dart';
import 'package:fastuserapp/src/widgets/add_to_cart_dialouge.dart';
import 'package:fastuserapp/src/widgets/menu_item_displayer.dart';
import 'package:fastuserapp/src/widgets/source_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class QuickAccessScreen extends StatefulWidget {
  final String type;
  final Map<String, dynamic> user;

  const QuickAccessScreen({
    Key key,
    this.type,
    this.user,
  }) : super(key: key);
  @override
  _QuickAccessScreenState createState() => _QuickAccessScreenState();
}

class _QuickAccessScreenState extends State<QuickAccessScreen>
    with SingleTickerProviderStateMixin {
  CartMenuBloc _cartMenuBloc;
  TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void didChangeDependencies() {
    _cartMenuBloc = Provider.of<CartMenuBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _cartMenuBloc.getQuickAccessList(widget.type);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.all(
          10,
        ),
        child: Column(
          children: <Widget>[
            TabBar(
              indicator: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(
                      0,
                      5,
                    ),
                  ),
                ],
                borderRadius: BorderRadius.circular(
                  5,
                ),
              ),
              controller: _controller,
              tabs: [
                Text(
                  "Food",
                ),
                Text(
                  "Resturant",
                )
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _controller,
                children: [
                  StreamBuilder<List<MenuItem>>(
                    stream: _cartMenuBloc.quickAccessMenuList,
                    builder: (context, snapshot) {
                      if (snapshot.hasError)
                        return Text("Error: ${snapshot.error}");
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
                              ? StreamBuilder(
                                  stream: _cartMenuBloc.getFavourites(
                                      "food", widget.user['email']),
                                  builder: (context, favouriteSnapshot) {
                                    if (favouriteSnapshot.hasError)
                                      return Text(
                                          "Error: ${favouriteSnapshot.error}");
                                    switch (favouriteSnapshot.connectionState) {
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
                                          shrinkWrap: true,
                                          children: snapshot.data
                                              .map<Widget>(
                                                (f) => StreamBuilder<int>(
                                                  stream: _cartMenuBloc
                                                      .getVendorMinOrder(
                                                          f.name),
                                                  builder: (context,
                                                      minOrderSnapshot) {
                                                    if (minOrderSnapshot
                                                        .hasError)
                                                      return Text(
                                                          "Error: ${minOrderSnapshot.error}");
                                                    switch (minOrderSnapshot
                                                        .connectionState) {
                                                      case ConnectionState.none:
                                                        return Text(
                                                            "Awaiting Bids...");
                                                        break;
                                                      case ConnectionState
                                                          .waiting:
                                                        return Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        );
                                                        break;
                                                      case ConnectionState
                                                          .active:
                                                        return MenuItemDisplayer(
                                                          item: f,
                                                          isFeatured:
                                                              favouriteSnapshot
                                                                  .data
                                                                  .contains(
                                                                      f.name),
                                                          onTap: () {
                                                            _cartMenuBloc
                                                                .toogleFavourite(
                                                              favouriteSnapshot
                                                                  .data
                                                                  .contains(
                                                                      f.name),
                                                              "food",
                                                              widget.user[
                                                                  'email'],
                                                              {
                                                                "name": f.name,
                                                                "createdAt":
                                                                    f.createdAt,
                                                              },
                                                            );
                                                          },
                                                          onTapped: () {
                                                            showDialog(
                                                              context: context,
                                                              builder: (context) =>
                                                                  AddToCartDialouge(
                                                                item: f,
                                                                user:
                                                                    widget.user,
                                                                vendorName:
                                                                    f.vendor,
                                                                minOrder:
                                                                    minOrderSnapshot
                                                                        .data,
                                                              ),
                                                            );
                                                          },
                                                        );
                                                        break;
                                                      case ConnectionState.done:
                                                        return Text(
                                                            "The task has completed");
                                                        break;
                                                    }
                                                    return null;
                                                  },
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
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      "assets/svg/smile.svg",
                                      height: 200,
                                      width: 200,
                                    ),
                                    Center(
                                      child: Text(
                                        "Coming Soon!",
                                        style: GoogleFonts.oswald(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                          break;
                        case ConnectionState.done:
                          return Text("The task has completed");
                          break;
                      }
                      return null;
                    },
                  ),
                  StreamBuilder(
                    stream: _cartMenuBloc.quickAccessVendorList,
                    builder: (context, snapshot) {
                      if (snapshot.hasError)
                        return Text('Error: ${snapshot.error}');
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Text('Select lot');
                        case ConnectionState.waiting:
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        case ConnectionState.active:
                          return snapshot.data.isNotEmpty
                              ? StreamBuilder<List<String>>(
                                  stream: _cartMenuBloc.getFavourites(
                                    "resturant",
                                    widget.user['email'],
                                  ),
                                  builder: (context, favouriteSnapshot) {
                                    if (favouriteSnapshot.hasError)
                                      return Text("${favouriteSnapshot.error}");
                                    switch (favouriteSnapshot.connectionState) {
                                      case ConnectionState.none:
                                        return Text("Awaiting bids...");
                                        break;
                                      case ConnectionState.waiting:
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                        break;
                                      case ConnectionState.active:
                                        return ListView(
                                          shrinkWrap: true,
                                          children: snapshot.data
                                              .map<Widget>(
                                                (vendor) => Provider(
                                                  create: (_) => CartMenuBloc(),
                                                  dispose: (context,
                                                          CartMenuBloc bloc) =>
                                                      bloc.dispose(),
                                                  child: SourceCard(
                                                    isFeatured:
                                                        favouriteSnapshot.data
                                                            .contains(
                                                      vendor.name,
                                                    ),
                                                    vendor: vendor,
                                                    user: widget.user,
                                                    onTap: () {
                                                      _cartMenuBloc
                                                          .toogleFavourite(
                                                        favouriteSnapshot.data
                                                            .contains(
                                                          vendor.name,
                                                        ),
                                                        "resturant",
                                                        widget.user['email'],
                                                        {
                                                          "name": vendor.name,
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                        );
                                        break;
                                      case ConnectionState.done:
                                        return Text("The Task has complted");
                                        break;
                                    }
                                    return null;
                                  },
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      "assets/svg/smile.svg",
                                      height: 200,
                                      width: 200,
                                    ),
                                    Center(
                                      child: Text(
                                        "Coming Soon!",
                                        style: GoogleFonts.oswald(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                        case ConnectionState.done:
                          return Text('${snapshot.data} (closed)');
                      }
                      return null;
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
