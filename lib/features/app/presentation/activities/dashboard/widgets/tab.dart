import 'package:flutter/material.dart';

class MyTab extends StatefulWidget {
  const MyTab({super.key});

  @override
  State<MyTab> createState() => _MyTabState();
}

class _MyTabState extends State<MyTab> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
            controller: _tabController,
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(width: 2.0, color: Colors.black),
              insets: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
            ),
            tabs: const [
              Tab(text: "Tab 1"),
              Tab(text: "Tab 2"),
            ],
          ),
          TabBarView(
            controller: _tabController,
            children: const [
              Text("data"),
              Text("data"),
            ],
          ),
        ],
      ),
    );
  }
}
