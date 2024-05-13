import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/routes/app_route.gr.dart';
import 'package:mobile_app/screens/edit_user.dart';
import 'package:mobile_app/screens/grid_view-page.dart';
import 'package:mobile_app/screens/register_page.dart';
import 'package:mobile_app/values/app_colors.dart';
import 'package:mobile_app/values/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});
  @override
  State<DrawerPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DrawerPage> {
  final userService = UserService();

  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    EditUserPage(),
    GridViewPage(),
    RegisterPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await userService.getData();
    setState(() {});
  }

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await context.router.push(LoginRoute(onResult: (bool) {}));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: AppColors.primaryColor,
      //   title: Text(
      //       "${userService.userProfile?.FirstName ?? ""} ${userService.userProfile?.LastName ?? ""}",
      //       overflow: TextOverflow.ellipsis,
      //       selectionColor: AppColors.primaryColor),
      // ),
      appBar: AppBar(
        title: Text(
          "${userService.userProfile?.FirstName ?? ""} ${userService.userProfile?.LastName ?? ""}",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                ),
                child: Column(children: [
                  Text(
                    "${userService.userProfile?.FirstName ?? ""} ${userService.userProfile?.LastName ?? ""}",
                    style: const TextStyle(color: Colors.black),
                  ),
                  const Spacer(),
                  ListTile(
                      trailing: const Text(
                        'Log Out',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      selected: _selectedIndex == 0,
                      onTap: () {
                        _logout(context);
                      }),
                ])),
            ListTile(
              title: const Text('User Profile'),
              selected: _selectedIndex == 0,
              onTap: () {
                // Update the state of the app
                _onItemTapped(0);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Grid View'),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(1);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Register'),
              selected: _selectedIndex == 2,
              onTap: () {
                // Update the state of the app
                _onItemTapped(2);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
