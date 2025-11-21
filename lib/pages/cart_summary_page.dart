import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart_cubit.dart';
import '../models/cart_item.dart';

class CartSummaryPage extends StatelessWidget {
  const CartSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ringkasan Keranjang')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<CartCubit, List<CartItem>>(
                builder: (context, items) {
                  if (items.isEmpty) {
                    return const Center(child: Text('Keranjang kosong'));
                  }
                  return ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, i) {
                      final it = items[i];
                      return ListTile(
                        leading: const Icon(Icons.shopping_bag),
                        title: Text(it.product.name),
                        subtitle: Text('Rp ${it.product.price.toStringAsFixed(0)}'),
                        trailing: SizedBox(
                          width: 160,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  final newQty = it.qty - 1;
                                  context.read<CartCubit>().updateQuantity(it.product, newQty);
                                },
                                icon: const Icon(Icons.remove_circle_outline),
                              ),
                              Text('${it.qty}'),
                              IconButton(
                                onPressed: () {
                                  context.read<CartCubit>().updateQuantity(it.product, it.qty + 1);
                                },
                                icon: const Icon(Icons.add_circle_outline),
                              ),
                              IconButton(
                                onPressed: () {
                                  context.read<CartCubit>().removeFromCart(it.product);
                                },
                                icon: const Icon(Icons.delete_outline),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            BlocBuilder<CartCubit, List<CartItem>>(
              builder: (context, items) {
                final totalItems = context.read<CartCubit>().totalItems;
                final totalPrice = context.read<CartCubit>().totalPrice;
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total item: $totalItems'),
                        Text('Total harga: Rp ${totalPrice.toStringAsFixed(0)}'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: items.isEmpty
                                ? null
                                : () {
                                    // Checkout (clear cart)
                                    context.read<CartCubit>().clearCart();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Checkout berhasil — keranjang dikosongkan')),
                                    );
                                  },
                            child: const Text('Checkout'),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
