
import 'package:XLNT_APP/business_logic/blocs/item/item_bloc.dart';
import 'package:XLNT_APP/business_logic/blocs/module/module_bloc.dart';
import 'package:XLNT_APP/presentation/router/app_router.dart';
import 'package:XLNT_APP/presentation/screens/splash_screen.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

import 'data/constans/constans.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: [
        Locale('vi', 'VN'),
        Locale('en', 'US'),
      ],
      path: 'assets/locale',
      fallbackLocale: Locale('vi', 'VN'),
      startLocale: Locale('vi', 'VN'),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
        providers: [
          BlocProvider<ItemBloc>(
            create: (BuildContext context) => ItemBloc(),
          ),
          BlocProvider<ModuleBloc>(
              create: (BuildContext context) => ModuleBloc()
          )
        ],
        child: MaterialApp(
            theme: ThemeData(
                primaryColor: colorMain,
                fontFamily: 'Nunito',
                primaryTextTheme:
                    TextTheme(headline6: TextStyle(color: Colors.white))),
            debugShowCheckedModeBanner: false,
            onGenerateRoute: _appRouter.onGenerateRoute,
            builder: BotToastInit(),
            navigatorObservers: [BotToastNavigatorObserver()],
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            home: SplashScreen()));
  }
}
