import 'package:auto_route/auto_route.dart';
import 'package:mobile_app/routes/app_route.gr.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    final storage = await SharedPreferences.getInstance();
    String? accessToken = await storage.getString('access_token');
    bool authenticated = false;
    if (accessToken != null) {
      authenticated = JwtDecoder.isExpired(accessToken);
    }
    if (authenticated) {
      resolver.next(true);
    } else {
      router.push(LoginRoute(onResult: (success) {
        resolver.next(success);
      }));
    }
  }
}
