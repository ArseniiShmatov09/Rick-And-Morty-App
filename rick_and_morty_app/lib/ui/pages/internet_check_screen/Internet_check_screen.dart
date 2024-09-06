import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/domain/models/network_connection.dart';
import 'package:rick_and_morty_app/ui/navigation/main_navigation.dart';

class InternetCheckScreen extends StatefulWidget {
  const InternetCheckScreen({super.key});

  @override
  _InternetCheckScreenState createState() => _InternetCheckScreenState();
}

class _InternetCheckScreenState extends State<InternetCheckScreen> {
  final networkConnection = NetworkConnection();
  bool isLoading = false;

  Future<void> _checkConnection() async {
    setState(() {
      isLoading = true;
    });

    await networkConnection.reload();
    await Future.delayed(Duration(seconds: 1));

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
      backgroundColor: Colors.black,
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Please check your internet connection and try again",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white38),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkConnection,
              child: Text("Try again"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(MainNavigationRouteNames.mainScreen);
              },
              child: Text("Continue offline"),
            ),
          ],
        ),
      ),
    );
  }
}
