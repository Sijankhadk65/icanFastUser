import 'package:eva_icons_flutter/eva_icons_flutter.dart';
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

  @override
  void didChangeDependencies() {
    _searchBloc = Provider.of<SearchBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        actions: <Widget>[
          // Material(
          //   child: IconButton(
          //     icon: Icon(EvaIcons.options2Outline),
          //     onPressed: () {},
          //   ),
          // )
        ],
        bottom: PreferredSize(
          child: Container(
            margin: EdgeInsets.all(
              10,
            ),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(
                5,
              ),
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
                                  return ListView(
                                    children: snapshot.data
                                        .map<Widget>(
                                          (vendor) => SourceCard(
                                            vendor: vendor,
                                            user: widget.user,
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
                          )
                        : StreamBuilder<List<MenuItem>>(
                            stream:
                                _searchBloc.getMenuItems(querySnapshot.data),
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
                                  return GridView.count(
                                    crossAxisCount: 2,
                                    shrinkWrap: true,
                                    children: snapshot.data
                                        .map<Widget>(
                                          (f) => MenuItemDisplayer(
                                            item: f,
                                            onTapped: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AddToCartDialouge(
                                                  item: f,
                                                  user: widget.user,
                                                  vendorName: f.vendor,
                                                ),
                                              );
                                            },
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
