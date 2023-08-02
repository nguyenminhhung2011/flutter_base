import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/string_extensions.dart';
import 'package:flutter_base_clean_architecture/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class ApplicationBeamer extends StatefulWidget {
  final AdaptiveThemeMode? savedThemeMode;
  final String initialRoute;
  final bool isMobile;
  final List<BlocProvider> providers;

  const ApplicationBeamer({
    super.key,
    required this.savedThemeMode,
    required this.isMobile,
    required this.initialRoute,
    required this.providers,
  });

  @override
  State<ApplicationBeamer> createState() => _ApplicationBeamerState();
}

class _ApplicationBeamerState extends State<ApplicationBeamer>
    with WidgetsBindingObserver {
  Widget _builteMaterialApp({
    required Locale locale,
  }) {
    return MaterialApp.router(
      routeInformationParser: BeamerParser(),
      routerDelegate: BeamerDelegate(
        initialPath: widget.initialRoute,
        notFoundPage: BeamPage(
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: const Center(child: Text('Not found')),
          ),
        ),
        locationBuilder: RoutesLocationBuilder(
          routes: {},
        ),
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: locale,
      theme: ThemeData(
        primaryColor: '#07AEAF'.toColor(),
        primaryColorDark: '#07AEAF'.toColor(),
        // fontFamily: 'Montserrat',
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: '#07AEAF'.toColor(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData.light(),
      dark: ThemeData.dark(),
      initial: widget.savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (
        ThemeData light,
        ThemeData dark,
      ) =>
          MultiBlocProvider(
        providers: widget.providers,
        child: const SizedBox(),
      ),
    );
  }
}
