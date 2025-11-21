import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product_model.dart';
import '../models/cart_item.dart';

class CartCubit extends Cubit<List<CartItem>> {
  CartCubit() : super([]);

  void addToCart(Product product) {
    final items = List<CartItem>.from(state);
    final idx = items.indexWhere((c) => c.product.id == product.id);
    if (idx == -1) {
      items.add(CartItem(product: product, qty: 1));
    } else {
      items[idx].qty += 1;
    }
    emit(items);
  }

  void removeFromCart(Product product) {
    final items = List<CartItem>.from(state);
    items.removeWhere((c) => c.product.id == product.id);
    emit(items);
  }

  void updateQuantity(Product product, int qty) {
    final items = List<CartItem>.from(state);
    final idx = items.indexWhere((c) => c.product.id == product.id);
    if (idx != -1) {
      if (qty <= 0) {
        items.removeAt(idx);
      } else {
        items[idx].qty = qty;
      }
      emit(items);
    }
  }

  void clearCart() => emit([]);

  int get totalItems => state.fold(0, (sum, it) => sum + it.qty);

  double get totalPrice =>
      state.fold(0.0, (sum, it) => sum + it.totalPrice);
}
