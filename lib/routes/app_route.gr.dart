// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;
import 'package:mobile_app/screens/drawer.dart' as _i3;
import 'package:mobile_app/screens/edit_user.dart' as _i1;
import 'package:mobile_app/screens/grid_view-page.dart' as _i2;
import 'package:mobile_app/screens/login_page.dart' as _i4;
import 'package:mobile_app/screens/register_page.dart' as _i5;

abstract class $AppRoute extends _i6.RootStackRouter {
  $AppRoute({super.navigatorKey});

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    EditUserRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.EditUserPage(),
      );
    },
    GridViewRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.GridViewPage(),
      );
    },
    Keeper.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.Keeper(),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>();
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.LoginPage(
          key: args.key,
          onResult: args.onResult,
        ),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.RegisterPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.EditUserPage]
class EditUserRoute extends _i6.PageRouteInfo<void> {
  const EditUserRoute({List<_i6.PageRouteInfo>? children})
      : super(
          EditUserRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditUserRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i2.GridViewPage]
class GridViewRoute extends _i6.PageRouteInfo<void> {
  const GridViewRoute({List<_i6.PageRouteInfo>? children})
      : super(
          GridViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'GridViewRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i3.Keeper]
class Keeper extends _i6.PageRouteInfo<void> {
  const Keeper({List<_i6.PageRouteInfo>? children})
      : super(
          Keeper.name,
          initialChildren: children,
        );

  static const String name = 'Keeper';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i4.LoginPage]
class LoginRoute extends _i6.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i7.Key? key,
    required dynamic Function(bool) onResult,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(
            key: key,
            onResult: onResult,
          ),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i6.PageInfo<LoginRouteArgs> page =
      _i6.PageInfo<LoginRouteArgs>(name);
}

class LoginRouteArgs {
  const LoginRouteArgs({
    this.key,
    required this.onResult,
  });

  final _i7.Key? key;

  final dynamic Function(bool) onResult;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onResult: $onResult}';
  }
}

/// generated route for
/// [_i5.RegisterPage]
class RegisterRoute extends _i6.PageRouteInfo<void> {
  const RegisterRoute({List<_i6.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}
