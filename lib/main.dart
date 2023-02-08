import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:starwears/Screens/connected_account/ProfileScreen.dart';
import 'package:starwears/Screens/SignUpScreen.dart';
import 'package:starwears/Screens/SplashScreen.dart';
import 'package:starwears/bloc/authentication_bloc.dart';
import 'package:starwears/bloc/banner_bloc.dart';
import 'package:starwears/bloc/bid_bloc.dart';
import 'package:starwears/bloc/brand_bloc.dart';
import 'package:starwears/bloc/category_bloc.dart';
import 'package:starwears/bloc/celebrity_bloc.dart';
import 'package:starwears/bloc/products_bloc.dart';
import 'package:starwears/stripe_page.dart';

import 'Providers/IndexProvider.dart';
import 'Screens/HomeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
            create: (_) => BidBloc(authenticationBloc: authenticationBloc))
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
        ),
        home:const SplashScreen(),
      ),
    );
  }
}
