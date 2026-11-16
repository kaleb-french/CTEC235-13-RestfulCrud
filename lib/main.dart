
import 'package:ctec235_13_restful_crud/albums.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final AlbumBloc bloc = AlbumBloc();

  Album? selectedAlbum;

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

          return Column(
            children: [
              // Selected Album Details
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: selectedAlbum == null
                    ? const Text(
                  "No Album Selected",
                  textAlign: TextAlign.center,
                )
                    : Column(
                  children: [
                    Text(
                      "Album ID: ${selectedAlbum!.id}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Title: ${selectedAlbum!.title}",
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: albums.length,
                  itemBuilder: (context, index) {
                    final album = albums[index];

                    return ListTile(
                      title: Text(album.title),
                      onTap: () {
                        setState(() {
                          selectedAlbum = album;
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          );
        }

        if (state is AError) {
          return Center(
            child: Text(state.message),
          );
        }

        return const Center(
          child: Text("Waiting for albums..."),
        );
      },
    );
  }
}

