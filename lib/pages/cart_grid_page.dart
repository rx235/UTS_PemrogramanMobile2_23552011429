import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product_model.dart';
import '../widgets/product_card.dart';
import '../blocs/cart_cubit.dart';

class CartGridPage extends StatelessWidget {
  const CartGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      Product(id: 'p1', name: 'Produk A', price: 15000, image: ''),
      Product(id: 'p2', name: 'Produk B', price: 25000, image: ''),
      Product(id: 'p3', name: 'Produk C', price: 12000, image: ''),
      Product(id: 'p4', name: 'Produk D', price: 50000, image: ''),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Produk')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.78,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemBuilder: (context, i) {
            return ProductCard(product: products[i]);
          },
        ),
      ),
    );
  }
}
