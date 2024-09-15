// ignore_for_file: file_names, library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/domain/utils/network_connection.dart';
import 'package:rick_and_morty_app/presentation/app_colors/app_colors.dart';
import 'package:rick_and_morty_app/presentation/navigation/main_navigation.dart';

import '../widgets/loading_indicator_widget.dart';

class InternetCheckPage extends StatefulWidget {
  const InternetCheckPage({super.key});

  @override
  _InternetCheckPageState createState() => _InternetCheckPageState();
}

class _InternetCheckPageState extends State<InternetCheckPage> {
  final networkConnection = NetworkConnection();
  bool isLoading = false;

  Future<void> _checkConnection() async {
    setState(() {
      isLoading = true;
    });

    await networkConnection.reload();
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isLoading = false;
    });

    if (!networkConnection.isOffline) {
      Navigator.of(context).pushNamed(MainNavigationRouteNames.mainScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBlack,
      body: Center(
        child: isLoading
        ? const LoadingIndicatorWidget()
        : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Please check your internet connection and try again",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: AppColors.mainGrey),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkConnection,
              child: const Text("Try again"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(MainNavigationRouteNames.mainScreen);
              },
              child: const Text("Continue offline"),
            ),
          ],
        ),
      ),
    );
  }
}


