import 'dart:io';

import 'package:counter_button/counter_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raki_internet_cafe/core/ui-colors.dart';
import 'package:raki_internet_cafe/models/cart-item-model.dart';
import 'package:raki_internet_cafe/providers/cart-provider.dart';
import 'package:raki_internet_cafe/providers/order-provider.dart';
import 'package:raki_internet_cafe/screens/client/checkout-order-screen.dart';
import 'package:raki_internet_cafe/utils/gap.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartItems = context.watch<CartProvider>().cartItems;
    final totalPrice = context.watch<CartProvider>().totalPrice;
    final hasNoItems = cartItems.isEmpty;
    final orderProvider = context.watch<OrderProvider>();

    return Scaffold(
      backgroundColor: UIColors.backgroundColor,
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'My Cart',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
      ),
      body: CartScreenBody(),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(14.0),
        width: double.infinity,
        color: Colors.black,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Total: ₱${context.watch<CartProvider>().totalPrice.toStringAsFixed(2)}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            vGap(12),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: hasNoItems
                    ? Colors.grey
                    : UIColors.tertiaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () {
                if (hasNoItems) return;
                orderProvider.createOrder(cartItems, totalPrice);

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CheckoutOrderScreen(),
                  ),
                );
              },
              label: Text(
                "Finalize & Checkout",
                style: TextStyle(color: Colors.white),
              ),
              icon: const Icon(
                Icons.shopping_cart_checkout_outlined,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartScreenBody extends StatelessWidget {
  const CartScreenBody({super.key});
  @override
  Widget build(BuildContext context) {
    final cartItems = context.watch<CartProvider>().cartItems;

    return Container(
      padding: const EdgeInsets.all(12.0),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                'Added Items',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              hGap(4),
              Text(
                '(${cartItems.length})',
                style: const TextStyle(
                  color: UIColors.tertiaryColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          Divider(color: Colors.grey),

          Expanded(
            child: cartItems.isEmpty
                ? const Center(child: Text('Your cart is empty'))
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return CartItemCard(item: cartItems[index]);
                    },
                    itemCount: cartItems.length,
                  ),
          ),
        ],
      ),
    );
  }
}

class CartItemCard extends StatelessWidget {
  const CartItemCard({super.key, required this.item});
  final CartItem item;
  //
  @override
  Widget build(BuildContext context) {
    final cartProvider = context.read<CartProvider>();

    return Dismissible(
      key: ValueKey(item.productId),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        padding: const EdgeInsets.only(right: 20.0),
        alignment: Alignment.centerRight,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) {
        return showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Remove item from cart?"),
            content: Text(
              "Are you sure you want to remove ${item.productName} from your cart?",
            ),
            actions: [
              TextButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              TextButton(
                child: const Text("Remove"),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        cartProvider.removeFromCart(item);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${item.productName} removed from cart!")),
        );
      },
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: FileImage(File(item.productImagePath)),
          ),
          title: Text(
            item.productName,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            "${item.variantLabel} - ₱${item.price.toStringAsFixed(2)}",
            style: const TextStyle(color: Colors.grey),
          ),
          trailing: CounterButton(
            loading: false,
            onChange: (int val) {
              if (val < 1) return;
              item.quantity = val;
              context.read<CartProvider>().updateCartItem(item, val);
            },
            count: item.quantity,
            countColor: Colors.black,
            buttonColor: UIColors.tertiaryColor,
            progressColor: UIColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
