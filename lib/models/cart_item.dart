import 'product_model.dart';

class CartItem {
  final Product product;
  int qty;

  CartItem({
    required this.product,
    this.qty = 1,
  });

  double get totalPrice => product.price * qty;

  Map<String, dynamic> toMap() => {
        'product': product.toMap(),
        'qty': qty,
      };

  factory CartItem.fromMap(Map<String, dynamic> m) => CartItem(
        product: Product.fromMap(Map<String, dynamic>.from(m['product'])),
        qty: m['qty'] as int,
      );
}
