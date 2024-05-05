import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:movies_up/ApiService.dart';
import 'package:movies_up/global_variables.dart';
import 'package:movies_up/models/movies_model.dart';
import 'package:shared_preferences/shared_preferences.dart';



class HomeScreenController extends GetxController{
  RxList<MoviesModel> moviesList = <MoviesModel>[].obs;
  RxList<MoviesModel> seriesList = <MoviesModel>[].obs;
  RxList<MoviesModel> animeList = <MoviesModel>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadMovies();
    loadSeries();
    loadAnime();
  }

  Future<List<MoviesModel>> fetchListDataPrefs(Map<String,dynamic> json) async{
    return await compute(MoviesModel.getImdbItemListFromJson,json);
  }

  Future<List<MoviesModel>> fetchDataApi(List<String> titles) async {
    List<MoviesModel> result = [];
    try{
      for(String item in titles){
        MoviesModel tempMovie = await ApiService.getMovies(item);
        result.add(tempMovie);
      }
    }catch(e){
      print(e);
    }
    return result;
  }

  void loadMovies() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();


    print('loadMovies called');
    if(prefs.containsKey(GlobalVars.moviesPrefKey)) {
      String jsonData = prefs.getString(GlobalVars.moviesPrefKey)??'';
      print(jsonData);
      moviesList.value = await fetchListDataPrefs(jsonDecode(jsonData));//MoviesModel.getMoviesListFromJson(jsonDecode(jsonData));
    }else{
      // await compute(fetchDataApi, GlobalVars.mostPopularMovies);
       for(String movie in GlobalVars.mostPopularMovies){
        MoviesModel tempMovie = await ApiService.getMovies(movie);
        moviesList.add(tempMovie);
       }
    }
    var data ={
      "imdbItems" :moviesList
    };
    prefs.setString(GlobalVars.moviesPrefKey, jsonEncode(data));
  }

  void loadSeries() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();


    print('loadSeries called');
    if(prefs.containsKey(GlobalVars.seriesPrefKey)) {
      String jsonData = prefs.getString(GlobalVars.seriesPrefKey)??'';
      print(jsonData);
      seriesList.value = await fetchListDataPrefs(jsonDecode(jsonData));//MoviesModel.getMoviesListFromJson(jsonDecode(jsonData));
    }else{
      // await compute(fetchDataApi, GlobalVars.mostPopularMovies);
       for(String movie in GlobalVars.mostPopularSeries){
        MoviesModel tempSeries = await ApiService.getMovies(movie);
        seriesList.add(tempSeries);
       }
    }
    GlobalVars.popularMovies = seriesList;
    var data ={
      "imdbItems" :seriesList
    };
    prefs.setString(GlobalVars.seriesPrefKey, jsonEncode(data));
  }

  void loadAnime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();


    print('load anime called');
    if(prefs.containsKey(GlobalVars.animePrefKey)) {
      String jsonData = prefs.getString(GlobalVars.animePrefKey)??'';
      print(jsonData);
      animeList.value = await fetchListDataPrefs(jsonDecode(jsonData));//MoviesModel.getMoviesListFromJson(jsonDecode(jsonData));
    }else{
      // await compute(fetchDataApi, GlobalVars.mostPopularMovies);
       for(String movie in GlobalVars.mostPopularAnime){
        MoviesModel tempAnime = await ApiService.getMovies(movie);
        animeList.add(tempAnime);
       }
    }
    var data ={
      "imdbItems" :animeList
    };
    prefs.setString(GlobalVars.animePrefKey, jsonEncode(data));
  }

  void removeSharedData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool movie = await prefs.remove(GlobalVars.moviesPrefKey);
    bool series = await prefs.remove(GlobalVars.seriesPrefKey);
    bool anime = await prefs.remove(GlobalVars.animePrefKey);
    print('shared data removed movie: $movie, series: $series, anime: $anime');
  }

}