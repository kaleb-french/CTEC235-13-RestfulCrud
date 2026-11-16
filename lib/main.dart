import 'package:ctec235_13_restful_crud/albums.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RESTful CRUD',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Albums"),
        ),
        body: MainPage(),
      ),
    );
  }
}

class MainPage extends StatelessWidget{
  MainPage({super.key});
  final AlbumBloc bloc = AlbumBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AState>(
        stream: bloc.output,
        builder: (context, snapshot) {
          final state = snapshot.data;

          if (state is ALoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ASuccess) {
            final albums = state.albums;

            return Center(
                child: ListView.builder(
                    itemCount: albums.length,
                    itemBuilder: (context, index) {
                      final album = albums[index];
                      return ListTile(
                        title: Text(album.title),
                      );
                    }
                )
            );
          }
          if (state is AError) {
            return Center(
              child: Text(state.message),
            );
          }
          else{
            return Center();
          }
        }
     );
  }
}