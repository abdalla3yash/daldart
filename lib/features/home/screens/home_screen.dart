import 'package:deldart/core/resources/resources.dart';
import 'package:deldart/features/home/screens/view/hot_view.dart';
import 'package:deldart/features/home/screens/view/new_view.dart';
import 'package:deldart/features/home/screens/view/rising_view.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.lightGrey,
        appBar: AppBar(
          title: const Text('/r/FlutterDev'),
          backgroundColor: AppColors.white,
          bottom: const TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: AppColors.primary,
            unselectedLabelColor: AppColors.grey,
            labelColor: AppColors.black,
            tabs: [Tab(text: "Hot"), Tab(text: "New"), Tab(text: "Rising")],
          ),
        ),
        body: const TabBarView(
          children: [HotView(), NewView(), RisingView()],
        ),
      ),
    );
  }
}
