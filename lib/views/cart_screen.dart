import 'package:flutter/material.dart';
import 'package:mini_katalog_app/components/cart_empty_box.dart';
import 'package:mini_katalog_app/components/cart_info_box.dart';
import 'package:mini_katalog_app/components/mini_card_tile.dart';

class CartScreen extends StatefulWidget {
  final List<dynamic> products;
  final Set<int> cartIds;

  const CartScreen({super.key, required this.products, required this.cartIds});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProducts = widget.products
        .where((element) => widget.cartIds.contains(element.id))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Cart"), backgroundColor: Colors.white),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: cartProducts.isEmpty
                    ? CartEmptyBox()
                    : ListView.builder(
                        itemCount: cartProducts.length,
                        itemBuilder: (context, index) {
                          final item = cartProducts[index];

                          return MiniCardTile(
                            name: item.title ?? "",
                            tagline: item.category ?? "",
                            price: item.price.toString(),
                            imageUrl: item.image ?? "",
                            onRemove: () {
                              setState(() {
                                widget.cartIds.remove(
                                  cartProducts[index].id ?? 0,
                                );
                              });
                            },
                          );
                        },
                      ),
              ),
              SizedBox(height: 4),
              CartInfoBox(),
              SizedBox(height: 14),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text("Checkout", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
