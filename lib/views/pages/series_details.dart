import 'package:flutter/material.dart';

class SeriesDetailsPage extends StatelessWidget {
  const SeriesDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    print(arguments);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: Container(
        child: Text("Details"),
      ),
    );
  }
}
