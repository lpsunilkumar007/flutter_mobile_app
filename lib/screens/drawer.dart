import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/screens/edit_user.dart';

@RoutePage()
class Keeper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Keeper',
        theme: ThemeData(primaryColor: Colors.yellow.shade700),
        home: KeeperDrawer(),
        // Routes
        routes: <String, WidgetBuilder>{
          Notes.routeName: (BuildContext context) => const Notes()
        });
  }
}

class KeeperDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
            child: ListView(children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            leading: const Icon(Icons.lightbulb_outline),
            title: const Text('Notes'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (BuildContext context, _, __) {
                return const Notes();
              }, transitionsBuilder:
                      (_, Animation<double> animation, __, Widget child) {
                return FadeTransition(opacity: animation, child: child);
              }));
            },
          ),
        ])),
        appBar: AppBar(
          title: const Text(
            'User Profile',
            textAlign: TextAlign.center,
          ),
        ),
        body: MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (context) => const EditUserPage(),
          },
        ));
  }
}

class Notes extends StatelessWidget {
  static const String routeName = '/notes';

  const Notes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: const Center(
        child: Text('Notes', style: TextStyle(fontSize: 24.0)),
      ),
      drawer: Drawer(
          child: ListView(children: <Widget>[
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text('Drawer Header'),
        ),
        ListTile(
          leading: const Icon(Icons.lightbulb_outline),
          title: const Text('User Profile'),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (BuildContext context, _, __) {
              return KeeperDrawer();
            }, transitionsBuilder:
                    (_, Animation<double> animation, __, Widget child) {
              return FadeTransition(opacity: animation, child: child);
            }));
          },
        ),
      ])),
    );
  }
}
