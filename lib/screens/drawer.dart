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
class Keeper extends StatefulWidget {
  const Keeper({super.key});
  @override
  State<Keeper> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Keeper> {
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
    print("start22222222222");
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

  // void _logout() async {
  //   final storage = await SharedPreferences.getInstance();
  //   var accessTokens = await storage.getString('access_token');
  //   print("222222222");
  //   print(accessTokens);
  //   storage.clear();
  //   var accessToken = await storage.getString('access_token');
  //   print("111111111111111");
  //   print(accessToken);
  //   context.router.push(LoginRoute(onResult: (bool) {}));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User")),
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
                    userService.userProfile?.UserName ?? "",
                    style: TextStyle(color: Colors.white),
                  ),
                  Spacer(),
                  ListTile(
                      trailing: const Text(
                        'Log Out',
                        style: TextStyle(
                            color: Colors.white,
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
