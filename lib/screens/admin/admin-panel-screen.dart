import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raki_internet_cafe/components/card-tile-button.dart';
import 'package:raki_internet_cafe/providers/order-provider.dart';
import 'package:raki_internet_cafe/providers/product-provider.dart';
import 'package:raki_internet_cafe/screens/admin/category/category-screen.dart';
import 'package:raki_internet_cafe/screens/admin/order/order-screen.dart';
import 'package:raki_internet_cafe/screens/admin/profile/profile-screen.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  static const _green = Color(0xFF2E7D32);
  static const _orange = Color(0xFFF57C00);
  static const _lightGreen = Color(0xFFE8F5E9);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrderProvider>().refresh();
      context.read<ProductProvider>().refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
    final orderProvider = context.watch<OrderProvider>();
    final products = productProvider.products;
    final orders = orderProvider.orders;

    final totalProducts = products.length;
    final totalOrders = orders.length;

    final pendingOrders = orders
        .where((order) => order.status.toLowerCase() == 'pending')
        .length;
    final completedOrders = orders
        .where((order) => order.status.toLowerCase() == 'completed')
        .length;
    final processingOrders = orders
        .where((order) => order.status.toLowerCase() == 'processing')
        .length;
    final cancelledOrders = orders
        .where(
          (order) =>
              order.status.toLowerCase() == 'cancelled' ||
              order.status.toLowerCase() == 'canceled',
        )
        .length;

    final statusCounts = {
      'Pending': pendingOrders,
      'Processing': processingOrders,
      'Completed': completedOrders,
      'Cancelled': cancelledOrders,
    };

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 760;
        final cardWidth = isWide
            ? constraints.maxWidth / 3 - 16
            : double.infinity;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  _buildSummaryCard(
                    title: 'Total Products',
                    value: totalProducts.toString(),
                    icon: Icons.inventory_2,
                    color: _green,
                    width: cardWidth,
                  ),
                  _buildSummaryCard(
                    title: 'Total Orders',
                    value: totalOrders.toString(),
                    icon: Icons.receipt_long,
                    color: _orange,
                    width: cardWidth,
                  ),
                  _buildSummaryCard(
                    title: 'Pending Orders',
                    value: pendingOrders.toString(),
                    icon: Icons.pending_actions,
                    color: Colors.deepPurple,
                    width: cardWidth,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildStatusPanel(statusCounts, isWide),
              const SizedBox(height: 20),
              _buildChartCard(statusCounts, totalOrders, totalProducts),
              const SizedBox(height: 20),
              _buildActionButtons(isWide),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Admin Dashboard',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Overview of products, orders and status statistics.',
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required double width,
  }) {
    return SizedBox(
      width: width,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.16)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 12,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 26),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusPanel(Map<String, int> statusCounts, bool isWide) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Statuses',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: statusCounts.entries.map((entry) {
              final color = _statusColor(entry.key);
              return _buildStatusChip(entry.key, entry.value, color);
            }).toList(),
          ),
          if (!isWide) const SizedBox(height: 8),
          if (isWide) const SizedBox(height: 2),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String label, int count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.14),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(radius: 10, backgroundColor: color),
          const SizedBox(width: 10),
          Text(
            '$label: $count',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartCard(
    Map<String, int> statusCounts,
    int totalOrders,
    int totalProducts,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _lightGreen,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Orders statistic',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          if (totalOrders == 0)
            const Text(
              'No orders yet. Statistics will appear here once orders are created.',
            )
          else ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMetricTile(
                  'Total Orders',
                  totalOrders.toString(),
                  _green,
                ),
                _buildMetricTile('Products', totalProducts.toString(), _orange),
              ],
            ),
            const SizedBox(height: 18),
            ...statusCounts.entries
                .map(
                  (entry) =>
                      _buildStatusBar(entry.key, entry.value, totalOrders),
                )
                .toList(),
          ],
        ],
      ),
    );
  }

  Widget _buildMetricTile(String label, String value, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBar(String status, int count, int total) {
    final ratio = total > 0 ? count / total : 0.0;
    final barColor = _statusColor(status);
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(status, style: const TextStyle(fontWeight: FontWeight.w600)),
              Text(
                '$count / $total',
                style: const TextStyle(color: Colors.black54),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 12,
              color: Colors.white,
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: ratio.clamp(0.0, 1.0),
                child: Container(color: barColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(bool isWide) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: WrapAlignment.spaceBetween,
      children: [
        _buildActionCard(
          title: 'My Account',
          icon: Icons.person,
          backgroundColor: _green,
          onTap: (context) => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
          ),
          width: isWide ? 280 : double.infinity,
        ),
        _buildActionCard(
          title: 'Products',
          icon: Icons.sell,
          backgroundColor: _green,
          onTap: (context) => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CategoryScreen()),
          ),
          width: isWide ? 280 : double.infinity,
        ),
        _buildActionCard(
          title: 'Orders',
          icon: Icons.list_alt,
          backgroundColor: _orange,
          onTap: (context) => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OrderScreen()),
          ),
          width: isWide ? 280 : double.infinity,
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required String title,
    required IconData icon,
    required Color backgroundColor,
    required Function(BuildContext) onTap,
    required double width,
  }) {
    return SizedBox(
      width: width,
      child: CardTileButton(
        title: title,
        icon: icon,
        foregroundColor: Colors.white,
        backgroundColor: backgroundColor,
        onTap: () => onTap(context),
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return _orange;
      case 'processing':
        return Colors.blueAccent;
      case 'completed':
        return _green;
      case 'cancelled':
      case 'canceled':
        return Colors.redAccent;
      default:
        return Colors.grey.shade600;
    }
  }
}
