import 'package:flutter/material.dart';
import 'package:network_library_provider/home_page.dart';
import 'package:network_library_provider/providers/album_details_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AlbumDetailsProvider>(
            create: (context) => AlbumDetailsProvider()),
      ],
      child: MaterialApp(
          theme: ThemeData(
            brightness: Brightness.light,
          ),
          home: HomePage()),
    );
  }
}
