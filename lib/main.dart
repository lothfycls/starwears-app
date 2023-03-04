import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starwears/Screens/IntroScreen.dart';
import 'package:starwears/Screens/SplashScreen.dart';
import 'package:starwears/bloc/authentication_bloc.dart';
import 'package:starwears/bloc/banner_bloc.dart';
import 'package:starwears/bloc/bid_bloc.dart';
import 'package:starwears/bloc/brand_bloc.dart';
import 'package:starwears/bloc/category_bloc.dart';
import 'package:starwears/bloc/celebrity_bloc.dart';
import 'package:starwears/bloc/newlistings_bloc.dart';
import 'package:starwears/bloc/notifications_bloc.dart';
import 'package:starwears/bloc/orders_bloc.dart';
import 'package:starwears/bloc/products_bloc.dart';
import 'package:starwears/bloc/profile_bloc.dart';
import 'package:starwears/bloc/relationship_bloc.dart';
import 'package:starwears/bloc/singleproduct_bloc.dart';
import 'package:starwears/bloc/watchlist_bloc.dart';
import 'package:starwears/models/user.dart';
import 'package:starwears/services/shared_preferences_service.dart';
import 'package:starwears/stripe_page.dart';

import 'Providers/IndexProvider.dart';
import 'Screens/HomeScreen.dart';

final outerNavigator = GlobalKey<NavigatorState>();

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService().initDb();
  Stripe.publishableKey =
      "pk_test_51MYvFJHU6zFyNPkfy9hGbi6zJKlQe7OP14DcRYL5xwcK3iqaVLaoeJdvpaiIVS5aUC0HXrMyVNmae2L2K98j5sNG00x7LP5aRf";

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final AuthenticationBloc authenticationBloc = AuthenticationBloc();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => IndexProvider()),
        BlocProvider(create: (_) => authenticationBloc),
        BlocProvider(create: (_) => BrandBloc()),
        BlocProvider(
          create: (_) => BannerBloc(),
        ),
        BlocProvider(
          create: (_) => CelebrityBloc(),
        ),
        BlocProvider(create: (_) => CategoryBloc()),
        BlocProvider(
            create: (_) =>
                ProductsBloc(authenticationBloc: authenticationBloc)),
        BlocProvider(
            create: (_) => BidBloc(authenticationBloc: authenticationBloc)),
        BlocProvider(create: (_) => NewlistingsBloc()),
        BlocProvider(create: (_) => SingleproductBloc()),
        BlocProvider(create: (_) => WatchlistBloc()),
        BlocProvider(
            create: (_) =>
                RelationshipBloc(authenticationBloc: authenticationBloc)),
        BlocProvider(
            create: (_) => OrdersBloc(authenticationBloc: authenticationBloc)),
        BlocProvider(
            create: (_) => ProfileBloc(authenticationBloc: authenticationBloc)),
        BlocProvider(
            create: (_) =>
                NotificationsBloc(authenticationBloc: authenticationBloc))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, child!),
          maxWidth: 1200,
          minWidth: 450,

          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(480, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
          // background: Container(color: const Color(0xFFF5F5F5))
        ),
        title: 'starwears',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme:
              const AppBarTheme(
                iconTheme: IconThemeData(
                  color: Colors.black,)),
          fontFamily: 'Inter',
        ),
        navigatorKey: outerNavigator,
        home: const Choose(),
      ),
    );
  }
}

class Choose extends StatefulWidget {
  const Choose({
    Key? key,
  }) : super(key: key);

  @override
  State<Choose> createState() => _ChooseState();
}

class _ChooseState extends State<Choose> {
  checkPrefsForUser(context) async {
    SharedPreferencesService sharedPreferencesService =
        SharedPreferencesService();
    User? user = await sharedPreferencesService.getUser();
    if (user != null) {
      BlocProvider.of<AuthenticationBloc>(context).add(LocalAuth(
          email: user.email,
          id: user.id,
          firstName: user.firstName,
          lastName: user.lastName,
          address: user.address,
          phone: user.phone,
          username: user.username));
    }
  }

  @override
  initState() {
    super.initState();
    checkPrefsForUser(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state is AuthSuccess) {
          return HomeScreen();
        } else if (state is AuthLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.black),
          );
        } else {
          return const SplashScreen();
        }
      },
    );
  }
}
