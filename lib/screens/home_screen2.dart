import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_up/controllers/home_screen2_controller.dart';
import 'package:movies_up/screens/preview_screen.dart';
import 'package:transparent_image/transparent_image.dart';
import '../models/search_model.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  final HomeScreen2Controller hS2Controller = Get.put(HomeScreen2Controller());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies Up'),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.white,
        child: Column(
          children: [
             SearchAnchor.bar(
                barHintText: 'Search movies',
                suggestionsBuilder: (context, controller) {
                  if (controller.text.isEmpty) {
                    if (hS2Controller.searchHistory.isNotEmpty) {
                      return hS2Controller.getHistoryList(controller);
                    }
                    return <Widget>[
                      const Center(
                          child: Text('No search history.',
                              style: TextStyle(color: Colors.grey)))
                    ];
                  }
                  return hS2Controller.getSuggestions(controller);
                },
              ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Obx(
              () => recentVisitItems(size),
            ),
          ],
        ),
      ),
    );
  }

  Widget recentVisitItems(Size size) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.red.shade50,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: size.width * 0.03,
                ),
                child: Text(
                  'Recent Search',
                  style: TextStyle(fontSize: size.height * 0.023),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.chevron_right_sharp),
              )
            ],
          ),
          SizedBox(
            height: size.height * 0.30,
            width: size.width,
            child: hS2Controller.recentSearch.isNotEmpty
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Get.to(() => PreviewScreen(
                              moviesModel: hS2Controller.recentSearch[index],
                            )),
                        child: Container(
                          width: size.width * 0.4,
                          margin: const EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Card(
                                  clipBehavior: Clip.hardEdge,
                                  child: Hero(
                                      tag: hS2Controller
                                              .recentSearch[index].title ??
                                          index,
                                      child: hS2Controller.recentSearch[index].poster =="N/A"?Image.asset('assets/images/splashbg1.jpg',fit: BoxFit.fitHeight,): FadeInImage.memoryNetwork(
                                        image: hS2Controller
                                                .recentSearch[index].poster ??
                                            '-',
                                        placeholder: kTransparentImage,
                                        height: size.height * 0.25,
                                        fit: BoxFit.cover,
                                      ))),
                              Text(hS2Controller.recentSearch[index].title ??
                                  '-'),
                              Text(
                                'imdb Rating : ${hS2Controller.recentSearch[index].imdbRating}',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: hS2Controller.recentSearch.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                  )
                : const Center(
                    child: ListTile(
                    title: Text('No recent search'),
                  )),
          ),
        ],
      ),
    );
  }
}
