import 'package:flutter/material.dart';
import '../bloc/cart_menu_bloc.dart';
import '../models/vendor.dart';
import '../widgets/source_card.dart';
import 'package:provider/provider.dart';

class VendorsScreen extends StatefulWidget {
  final String tag;
  final Map<String, dynamic> user;

  const VendorsScreen({Key key, @required this.tag, this.user})
      : super(key: key);
  @override
  _VendorsScreenState createState() => _VendorsScreenState();
}

class _VendorsScreenState extends State<VendorsScreen> {
  CartMenuBloc _cartMenuBloc;

  @override
  void didChangeDependencies() {
    _cartMenuBloc = Provider.of<CartMenuBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _cartMenuBloc.getVendors(widget.tag);
    return Container(
      child: StreamBuilder<List<Vendor>>(
        stream: _cartMenuBloc.vendors,
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('Select lot');
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.active:
              return ListView(
                shrinkWrap: true,
                children: snapshot.data
                    .map<Widget>(
                      (vendor) => Provider(
                        create: (_) => CartMenuBloc(),
                        dispose: (context, CartMenuBloc bloc) => bloc.dispose(),
                        child: SourceCard(
                          vendor: vendor,
                          user: widget.user,
                          minOrder: vendor.minOrder,
                        ),
                      ),
                    )
                    .toList(),
              );
            case ConnectionState.done:
              return Text('${snapshot.data} (closed)');
          }
          return null;
        },
      ),
    );
  }
}
