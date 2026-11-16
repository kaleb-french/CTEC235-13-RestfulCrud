
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class Album{
  //f
  final int userId;
  final int id;
  final String title;
  //c
  Album({required this.userId, required this.id, required this.title});
  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(userId: json['userId'], id: json['id'], title: json['title']);
  }
}
enum Action{
  add,delete,get
}

abstract class AAction{}

class AGet extends AAction{}

class ADelete extends AAction{
  final int id;

  ADelete(this.id);
}
abstract class AState{}

class ALoading extends AState{}

class ASuccess extends AState{
  final List<Album> albums;

  ASuccess(this.albums);
}

class AError extends AState{
  final String message;

  AError({required this.message});
}

class AlbumBloc{
  //f
  List<Album> albums = [];
  final StreamController<AAction> _input = StreamController<AAction>();
  final StreamController<AState> _output = StreamController<AState>();
  StreamSink<AAction> get input => _input.sink;
  Stream<AState> get output => _output.stream;
  //c
  AlbumBloc(){
    _input.stream.listen((AAction action) async {
        if(action is AGet){
          _output.add(ALoading());
          try{
            final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/albums"));
            if(response.statusCode == 200){
              print("Success!");
              final List<dynamic> data = jsonDecode(response.body);
              albums = data.map((json) => Album.fromJson(json)).toList();
              _output.add(ASuccess(albums));
            } else{
              print("Failed: ${response.statusCode}");
              _output.add(AError(message: e.toString()));
            }
          } catch(e){
            _output.add(AError(message: e.toString()));
          }
        }
        else if(action is ADelete){
          try{
            final id = action.id;
            final response = await http.delete(Uri.parse("https://jsonplaceholder.typicode.com/albums/$id"));
            if(response.statusCode == 200){
              print("DELETED: ${id}");
              print("Status: ${response.statusCode}");
              _output.add(ASuccess(albums));
            } else {
              print("Failed: ${response.statusCode}");
              _output.add(AError(message: e.toString()));
            }
          } catch (e){
            _output.add(AError(message: e.toString()));
          }
        }
      }
    );
    input.add(AGet());
  }
}