// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:mobile_app/screens/edit_user.dart' as _i1;
import 'package:mobile_app/screens/grid_view-page.dart' as _i2;
import 'package:mobile_app/screens/login_page.dart' as _i3;
import 'package:mobile_app/screens/register_page.dart' as _i4;

abstract class $AppRoute extends _i5.RootStackRouter {
  $AppRoute({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    EditUserRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.EditUserPage(),
      );
    },
    GridViewRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.GridViewPage(),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>();
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.LoginPage(onResult: args.onResult),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.RegisterPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.EditUserPage]
class EditUserRoute extends _i5.PageRouteInfo<void> {
  const EditUserRoute({List<_i5.PageRouteInfo>? children})
      : super(
          EditUserRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditUserRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i2.GridViewPage]
class GridViewRoute extends _i5.PageRouteInfo<void> {
  const GridViewRoute({List<_i5.PageRouteInfo>? children})
      : super(
          GridViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'GridViewRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i3.LoginPage]
class LoginRoute extends _i5.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    required dynamic Function(bool) onResult,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(onResult: onResult),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i5.PageInfo<LoginRouteArgs> page =
      _i5.PageInfo<LoginRouteArgs>(name);
}

class LoginRouteArgs {
  const LoginRouteArgs({required this.onResult});

  final dynamic Function(bool) onResult;

  @override
  String toString() {
    return 'LoginRouteArgs{onResult: $onResult}';
  }
}

/// generated route for
/// [_i4.RegisterPage]
class RegisterRoute extends _i5.PageRouteInfo<void> {
  const RegisterRoute({List<_i5.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}
