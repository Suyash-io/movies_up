import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:movies_up/models/movies_model.dart';
import 'package:movies_up/models/search_model.dart';

final dio = Dio();
String _url = 'http://www.omdbapi.com/?apiKey=dc7fbc34&';


class ApiService {
  static Future<MoviesModel> getMovies(String movie) async {
    MoviesModel result = MoviesModel();
    String moviesUrl = '$_url&t=$movie';
    try{
      final response = await dio.get(moviesUrl);
      Map<String,dynamic> jsonData = jsonDecode(jsonEncode(response.data));
      // print(jsonData);
      if(response.statusCode==200 && !jsonData.containsKey("Error")){
        result = MoviesModel.fromJson(jsonData);
      }
    }catch(e){
      print(e);
    }
    return result;
  }

  static Future<SearchResponseModel> search(String title) async {
    SearchResponseModel result = SearchResponseModel();
    String searchUrl = '$_url&s=$title';
    try{
      final response = await dio.get(searchUrl);
      Map<String,dynamic> jsonData = jsonDecode(jsonEncode(response.data));
      if(response.statusCode==200 && !jsonData.containsKey("Error")){
        result = SearchResponseModel.fromJson(jsonData);
      }
    }catch(e){
      print(e);
    }
    return result;
  }
}