import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:tourism_app_flutter/data/api/api_service.dart';
import 'package:tourism_app_flutter/data/model/tourism.dart';
import 'package:tourism_app_flutter/data/model/tourism_list_response.dart';
import 'package:tourism_app_flutter/provider/home/tourism_list_provider.dart';
import 'package:tourism_app_flutter/screen/home/tourism_card_widget.dart';
import 'package:tourism_app_flutter/static/NavigationRoute.dart';
import 'package:tourism_app_flutter/static/tourism_list_result_state.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<TourismListProvider>().fetchTourismList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tourism List"),
      ),
      body: Consumer<TourismListProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            TourismListLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
            TourismListLoadedState(data: var tourismList) => ListView.builder(
              itemCount: tourismList.length,
              itemBuilder: (context, index) {
                final tourism = tourismList[index];

                return TourismCard(
                  tourism: tourism,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      NavigationRoute.detailRoute.name,
                      arguments: tourism.id,
                    );
                  },
                );
              },
            ),
            TourismListErrorState(error: var message) => Center(
              child: Text(message),
            ),
            _ => const SizedBox(),
          };
        },
      ),

    );
  }
}