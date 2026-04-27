import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:raki_internet_cafe/providers/cart-provider.dart';
import 'package:raki_internet_cafe/providers/order-provider.dart';
import 'package:raki_internet_cafe/screens/layout/product-screen.dart';
import 'package:raki_internet_cafe/utils/gap.dart';

class CheckoutOrderScreen extends StatelessWidget {
  const CheckoutOrderScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final order = context.watch<OrderProvider>().order;
    final cartProvider = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            cartProvider.clearCart();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const ProductScreen()),
              (route) => false,
            );
          },
        ),
        title: const Text('Order Summary'),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'ORDER NO: ',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: '${order.orderNumber}',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Order Date: ${DateFormat('mm/dd/yyyy').format(DateTime.parse(order.createdAt))}',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              Text('-------------------'),
              order.items.isEmpty
                  ? const Text(
                      'Your cart is empty.',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    )
                  : Column(
                      children: order.items.map((item) {
                        return ListTile(
                          leading: Image.file(
                            File(item.productImagePath),
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            item.productName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text('Quantity: ${item.quantity}'),
                          trailing: Text(
                            '₱${(item.price * item.quantity).toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
              Text('-------------------'),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Total: ₱${order.totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              vGap(20),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Your order has been placed successfully!\n',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    TextSpan(
                      text: 'Thank you for ordering!',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
