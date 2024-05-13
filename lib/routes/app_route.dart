import 'package:auto_route/auto_route.dart';
import 'package:mobile_app/routes/gaurd/auth_gaurd.dart';
import 'app_route.gr.dart';

@AutoRouterConfig()
class AppRoute extends $AppRoute {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: EditUserRoute.page, guards: [AuthGuard()]),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: GridViewRoute.page, guards: [AuthGuard()]),
        AutoRoute(page: DrawerRoute.page, initial: true, guards: [AuthGuard()]),
      ];
}
