import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_up/ApiService.dart';
import '../models/movies_model.dart';
import '../models/search_model.dart';
import '../screens/preview_screen.dart';

class HomeScreen2Controller extends GetxController {
  final searchHistory = <SearchModel>[].obs;
  final suggestionList = <SearchModel>[].obs;

  RxList<MoviesModel> recentSearch = <MoviesModel>[].obs;

  Iterable<Widget> getHistoryList(SearchController controller) {
    return searchHistory.map(
      (SearchModel item) => ListTile(
        leading: const Icon(Icons.history),
        title: Text(item.title ?? '-'),
        trailing: IconButton(
          icon: const Icon(Icons.call_missed),
          onPressed: () {
            controller.text = item.title ?? '-';
            controller.selection =
                TextSelection.collapsed(offset: controller.text.length);
          },
        ),
      ),
    );
  }

  Future<Iterable<Widget>> getSuggestions(SearchController controller) async {
    final String input = controller.value.text;
    List<SearchModel> searchItems = [];
    if(input.length >3) {
      searchItems = await searchItem(input);
    }
    return searchItems.where((element) => element.title!.toLowerCase().contains(input.toLowerCase()))
        .map(
          (SearchModel filteredItem) => ListTile(
        leading: CircleAvatar(
            backgroundImage: filteredItem.poster! == 'N/A' ? const AssetImage('assets/images/splashbg1.jpg') as ImageProvider : NetworkImage(filteredItem.poster ?? '')),
        title: Text(filteredItem.title ?? '-'),
        trailing: IconButton(
          icon: const Icon(Icons.call_missed),
          onPressed: () {
            controller.text = filteredItem.title ?? '-';
            controller.selection =
                TextSelection.collapsed(offset: controller.text.length);
          },
        ),
        onTap: () {
          handleSelection(filteredItem);
          controller.closeView(filteredItem.title);
        },
      ),
    );
  }

  void handleSelection(SearchModel searchModel)async {
    MoviesModel moviesModel =MoviesModel();
    try{
      moviesModel = await ApiService.getMovies(searchModel.title??'');
      Get.to(() => PreviewScreen(moviesModel: moviesModel));
    }catch(e){
      print(e);
    }
    if (searchHistory.length >= 10) {
      searchHistory.removeLast();
    }
    searchHistory.insert(0, searchModel);
    recentSearch.add(moviesModel);
  }

  Future<List<SearchModel>> searchItem(String name) async {
    print('search Called with $name');
    SearchResponseModel responseModel = SearchResponseModel();
    List<SearchModel> result = [];
    try {
      responseModel = await ApiService.search(name);
      print('search response ${responseModel.response}');
      result = responseModel.search ?? [];
      print(suggestionList);
    } catch (E) {
      print(E);
    }
    return result;
  }
}
