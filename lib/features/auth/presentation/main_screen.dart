import 'package:distributor_retailer_app/config/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatefulWidget {
  final Widget child;
  const MainScreen({super.key, required this.child});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 2;

  void _onTabTapped(int index) {
    setState(() => _currentIndex = index);

    switch (index) {
      case 0:
        context.pushNamed(AppRoutes.home);
        break;
      case 1:
        context.pushNamed(AppRoutes.location);
        break;
      case 2:
        context.pushNamed(AppRoutes.home);
        break;
      case 3:
        context.pushNamed(AppRoutes.chart);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(AppRoutes.addDistributorRetailer);
        },
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.black12, width: 1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, -1),
              blurRadius: 6,
            ),
          ],
        ),
        child: SizedBox(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 12),
              _buildNavItem(Icons.home, 0),
              const SizedBox(width: 12),
              _buildNavItem(Icons.location_on, 1),
              const SizedBox(width: 12),
              _buildNavItem(Icons.store, 2, isCenter: true),
              const SizedBox(width: 12),
              _buildNavItem(Icons.pie_chart, 3),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index, {bool isCenter = false}) {
    final bool isSelected = _currentIndex == index;

    return InkWell(
      onTap: () => _onTabTapped(index),
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        height: isCenter ? 55 : 48,
        width: isCenter ? 55 : 48,
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.black,
          size: isCenter ? 28 : 26,
        ),
      ),
    );
  }
}
