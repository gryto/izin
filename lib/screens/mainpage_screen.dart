import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/helper/helper.dart';
import 'dashboard_screen.dart';
import 'profile_screen.dart';

class MainpageScreen extends StatefulWidget {
  const MainpageScreen({super.key});

  @override
  State<MainpageScreen> createState() => _MainpageScreenState();
}

class _MainpageScreenState extends State<MainpageScreen> {
  int _selectedIndex = 0;
  bool isLoading = false;

  // List of pages corresponding to the bottom navigation items
  final List<Widget> _pages = [
    const DashboardScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (shouldPop) async {
        bool confirmExit = false;
        if (_selectedIndex != 0) {
          setState(() {
            _selectedIndex = 0;
          });
        } else {
          confirmExit = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Konfirmasi'),
                content:
                    const Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Tidak'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Ya'),
                  ),
                ],
              );
            },
          );
        }
        if (confirmExit) {
          await Helper().deleteDataUser();
          await Helper().deleteToken();
          await Helper().deleteInitialLocation();
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        } else {
          print('Cancelled exit.');
        }
      },
      child: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          iconSize: 20,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  void logout(BuildContext context) {
    print('logout invoked');
  }
}
// BottomAppBar(shape: CircularNotchedRectangle(), child: ) // digunakan untuk 