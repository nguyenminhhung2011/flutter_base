import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class ExScreen extends StatelessWidget {
  const ExScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ExLocation extends BeamLocation<BeamState> {
  ExLocation(RouteInformation routeInformation) : super(routeInformation);

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        child: const ExScreen(),
      ),
    ];
  }

  @override
  List<Pattern> get pathPatterns => ['/example'];
}
