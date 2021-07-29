import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fastuserapp/src/bloc/cart_menu_bloc.dart';
import 'package:fastuserapp/src/bloc/search_bloc.dart';
import 'package:fastuserapp/src/models/item.dart';
import 'package:fastuserapp/src/models/vendor.dart';
import 'package:fastuserapp/src/widgets/menu_item_displayer.dart';
import 'package:fastuserapp/src/widgets/source_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'add_to_cart_dialouge.dart';

class FoodSearchDelegate extends StatefulWidget {
  final Map<String, dynamic> user;

  const FoodSearchDelegate({Key key, this.user}) : super(key: key);
  @override
  _FoodSearchDelegateState createState() => _FoodSearchDelegateState();
}

class _FoodSearchDelegateState extends State<FoodSearchDelegate> {
  SearchBloc _searchBloc;
  CartMenuBloc _cartMenuBloc;

  @override
  void didChangeDependencies() {
    _searchBloc = Provider.of<SearchBloc>(context);
    _cartMenuBloc = Provider.of<CartMenuBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        bottom: PreferredSize(
          child: Container(
            margin: EdgeInsets.all(
              10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 5),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Icon(
                  EvaIcons.searchOutline,
                  color: Colors.black38,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: StreamBuilder<String>(
                      stream: _searchBloc.query,
                      builder: (context, snapshot) {
                        return TextField(
                          style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w700,
                          ),
                          onChanged: _searchBloc.changeQuery,
                          decoration: InputDecoration(
                            hintText: "looking for something.........",
                            hintStyle: GoogleFonts.nunito(
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  width: 10,
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(
                        5,
                      ),
                      bottomRight: Radius.circular(
                        5,
                      ),
                    ),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Icon(
                        EvaIcons.closeOutline,
                        color: Colors.black38,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 0,
                ),
                StreamBuilder<String>(
                  stream: _searchBloc.searchFilter,
                  builder: (context, snapshot) {
                    return PopupMenuButton(
                      icon: Icon(
                        EvaIcons.options2Outline,
                        color: Colors.black38,
                      ),
                      elevation: 5,
                      initialValue: snapshot.data,
                      onSelected: _searchBloc.changeSearchFilter,
                      itemBuilder: (context) => [
                        PopupMenuItem(
                            child: Text(
                              "Resturant",
                              style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            value: "resturant"),
                        PopupMenuItem(
                            child: Text(
                              "Food",
                              style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            value: "food"),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
          preferredSize: Size.fromHeight(50),
        ),
      ),
      body: StreamBuilder<String>(
        stream: _searchBloc.query,
        builder: (context, querySnapshot) {
          return querySnapshot.hasData && querySnapshot.data != ""
              ? StreamBuilder(
                  builder: (context, snapshot) {
                    return snapshot.data == "resturant"
                        ? StreamBuilder<List<Vendor>>(
                            stream: _searchBloc.getVendors(querySnapshot.data),
                            builder: (context, snapshot) {
                              if (snapshot.hasError)
                                return Text("Erro: ${snapshot.error}");
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                  return Text("Awaiting Bids.....");
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
                                              widget.user['email']),
                                          builder:
                                              (context, favouriteSnapshot) {
                                            if (favouriteSnapshot.hasError)
                                              return Text(
                                                  "${favouriteSnapshot.error}");
                                            switch (favouriteSnapshot
                                                .connectionState) {
                                              case ConnectionState.none:
                                                return Text(
                                                    "Awaiting Bids....");
                                                break;
                                              case ConnectionState.waiting:
                                                return Center(
                                                    child:
                                                        CircularProgressIndicator());
                                                break;
                                              case ConnectionState.active:
                                                return ListView(
                                                  children: snapshot.data
                                                      .map<Widget>(
                                                        (vendor) => SourceCard(
                                                          vendor: vendor,
                                                          user: widget.user,
                                                          isFeatured:
                                                              favouriteSnapshot
                                                                  .data
                                                                  .contains(
                                                                      vendor
                                                                          .name),
                                                          onTap: () {
                                                            _cartMenuBloc.toogleFavourite(
                                                                favouriteSnapshot
                                                                    .data
                                                                    .contains(vendor.name),
                                                                "resturant",
                                                                widget.user['email'],
                                                                {
                                                                  "name": vendor
                                                                      .name
                                                                });
                                                          },
                                                        ),
                                                      )
                                                      .toList(),
                                                );
                                                break;
                                              case ConnectionState.done:
                                                return Text(
                                                    "The task has complted");
                                                break;
                                            }
                                            return null;
                                          },
                                        )
                                      : Container();
                                  break;
                                case ConnectionState.done:
                                  return Text("The task has completed");
                                  break;
                              }
                              return null;
                            },
                          )
                        : StreamBuilder<List<MenuItem>>(
                            stream:
                                _searchBloc.getMenuItems(querySnapshot.data),
                            builder: (context, snapshot) {
                              if (snapshot.hasError)
                                return Text("Error: ${snapshot.error}");
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                  return Text("Awaiting Bids.....");
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
                                              "food", widget.user['email']),
                                          builder:
                                              (context, favouriteSnapshot) {
                                            if (favouriteSnapshot.hasError)
                                              return Text(
                                                  "${favouriteSnapshot.error}");
                                            switch (favouriteSnapshot
                                                .connectionState) {
                                              case ConnectionState.none:
                                                return Text(
                                                    "Awaiting Bids....");
                                                break;
                                              case ConnectionState.waiting:
                                                return Center(
                                                    child:
                                                        CircularProgressIndicator());
                                                break;
                                              case ConnectionState.active:
                                                return GridView.count(
                                                  crossAxisCount: 2,
                                                  shrinkWrap: true,
                                                  children: snapshot.data
                                                      .map<
                                                          Widget>((f) => StreamBuilder<
                                                              int>(
                                                          stream: _cartMenuBloc
                                                              .getVendorMinOrder(
                                                                  f.vendor),
                                                          builder: (context,
                                                              minOrdersnapshot) {
                                                            if (minOrdersnapshot
                                                                .hasError)
                                                              return Text(
                                                                  "${minOrdersnapshot.error}");
                                                            switch (minOrdersnapshot
                                                                .connectionState) {
                                                              case ConnectionState
                                                                  .none:
                                                                return Text(
                                                                    "Awaiting Bids....");
                                                                break;
                                                              case ConnectionState
                                                                  .waiting:
                                                                return Center(
                                                                    child:
                                                                        CircularProgressIndicator());
                                                                break;
                                                              case ConnectionState
                                                                  .active:
                                                                return MenuItemDisplayer(
                                                                  item: f,
                                                                  isFeatured: favouriteSnapshot
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
                                                                      "resturant",
                                                                      widget.user[
                                                                          'email'],
                                                                      {
                                                                        "name":
                                                                            f.name
                                                                      },
                                                                    );
                                                                  },
                                                                  onTapped: () {
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) =>
                                                                              AddToCartDialouge(
                                                                        item: f,
                                                                        user: widget
                                                                            .user,
                                                                        vendorName:
                                                                            f.vendor,
                                                                        minOrder:
                                                                            minOrdersnapshot.data,
                                                                      ),
                                                                    );
                                                                  },
                                                                );
                                                                break;
                                                              case ConnectionState
                                                                  .done:
                                                                return Text(
                                                                    "The task has complted");
                                                                break;
                                                            }
                                                            return null;
                                                          }))
                                                      .toList(),
                                                );
                                                break;
                                              case ConnectionState.done:
                                                return Text(
                                                    "The task has complted");
                                                break;
                                            }
                                            return null;
                                          })
                                      : Container();
                                  break;
                                case ConnectionState.done:
                                  return Text("The task has completed");
                                  break;
                              }
                              return null;
                            },
                          );
                  },
                  stream: _searchBloc.searchFilter,
                )
              : Container(
                  child: Center(
                    child: Text("Please enter something for me to look for."),
                  ),
                );
        },
      ),
    );
  }
}
