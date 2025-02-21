import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  final Widget welcomepage;
  final Widget mainpage;
  final Widget settingspage;

  const Wrapper({
    super.key,
    required this.welcomepage,
    required this.mainpage,
    required this.settingspage,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("DadouFit"),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.sports_tennis)),
              Tab(icon: Icon(Icons.settings)),
            ],
          ),
        ),
        body: TabBarView(children: [welcomepage, mainpage, settingspage],),
      ),
    );
  }
}
