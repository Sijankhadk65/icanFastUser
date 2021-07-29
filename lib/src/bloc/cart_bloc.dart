import './cart_menu_bloc.dart';
import './order_cart_bloc.dart';

class CartBloc {
  final CartMenuBloc cartMenuBloc = CartMenuBloc();
  final OrderCartBloc orderCartBloc = OrderCartBloc();

  void dispose() {
    cartMenuBloc.dispose();
    orderCartBloc.dispose();
  }
}
