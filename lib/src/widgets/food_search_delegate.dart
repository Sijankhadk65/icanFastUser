import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fastuserapp/src/bloc/search_bloc.dart';
import 'package:fastuserapp/src/models/vendor.dart';
import 'package:fastuserapp/src/widgets/filter_dialouge.dart';
import 'package:fastuserapp/src/widgets/source_card.dart';
import 'package:flutter/material.dart';

class FoodSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(EvaIcons.close), onPressed: () => query = ""),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        EvaIcons.options2Outline,
      ),
      onPressed: () => showDialog(
        context: context,
        builder: (context) => FilterDialouge(),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<List<Vendor>>(
      stream: searchBloc.queryVendors,
      builder: (context, snapshot) {
        if (snapshot.hasError) return Text("Error: ${snapshot.error}");
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text("Awaiting bids....");
            break;
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
            break;
          case ConnectionState.active:
            return snapshot.data.isEmpty
                ? Center(
                    child: Text("Please perform a search"),
                  )
                : Container(
                    child: ListView(
                    children: snapshot.data
                        .map(
                          (vendor) => SourceCard(vendor: vendor),
                        )
                        .toList(),
                  ));
            break;
          case ConnectionState.done:
            return Text("The task has completed");
            break;
        }
        return null;
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    searchBloc.changeQuery(query);
    return Container();
  }
}
