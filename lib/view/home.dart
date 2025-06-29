import 'package:flutter/material.dart';
import 'package:gowagr_assessment/utils/assets/colors.dart';
import 'package:gowagr_assessment/view/explore_module/explore_tab.dart';
import 'package:gowagr_assessment/widgets/customSizedBox.dart';
import 'package:provider/provider.dart';

import '../provider/event_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Tab> tabs = const [
    Tab(text: 'Explore'),
    Tab(text: 'Portfolio'),
    Tab(text: 'Activity'),
  ];

  @override
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this);
    Future.delayed(Duration.zero, () async {
      context.read<ExploreViewModel>().initialize(context);
    });

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/logo.png'),
              Spacing(15),
              TabBar(
                tabs: tabs,
                controller: _tabController,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
              ),
              Spacing(20),
              Expanded(
                child: TabBarView(
                  controller: _tabController,

                  children: [
                    ExploreTab(),
                    Center(child: Text('Portfolio Coming Soon')),
                    Center(child: Text('Activity Coming Soon')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
