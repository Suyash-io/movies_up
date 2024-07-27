import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_up/controllers/home_screen_controller.dart';
import 'package:movies_up/screens/preview_screen.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final homeScreenCtr = Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Movies Up'),),
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.white,
        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(colors: [Color(0xFFCDE8E5),Color(0xFFEEF7FF)],begin: Alignment.topLeft,end: Alignment.bottomRight)
        // ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // SizedBox(height: size.height*0.01,),
              Obx(()=> moviesRow(size),
              ),
              const Divider(endIndent: 10,indent: 10,),
              Obx(()=> seriesRow(size),
              ),
              const Divider(endIndent: 10,indent: 10,),
              Obx(()=> animeRow(size),
              ),
              // ElevatedButton(onPressed: () {
              //   homeScreenCtr.removeSharedData();
              // }, child: const Text('Remove key'))
            ],
          ),
        )
      ),
    );
  }
  Widget moviesRow(Size size) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.red.shade50,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Padding(
                padding: EdgeInsets.only(left: size.width * 0.03,),
                child: Text('Movies',style: TextStyle(fontSize: size.height * 0.023),),
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
            child: homeScreenCtr.moviesList.isNotEmpty ?ListView.builder(itemBuilder: (context,index) {
              return GestureDetector(
                onTap: () => Get.to(()=> PreviewScreen(moviesModel: homeScreenCtr.moviesList[index],)),
                child: Container(
                  width: size.width * 0.4,
                  margin: const EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    children: [
                      Card(clipBehavior: Clip.hardEdge,child: Hero(tag: homeScreenCtr.moviesList[index].title??index,child: FadeInImage.memoryNetwork(image:homeScreenCtr.moviesList[index].poster??'-', placeholder: kTransparentImage,height: size.height * 0.25,fit: BoxFit.cover,))),
                      Text(homeScreenCtr.moviesList[index].title??'-'),
                      Text('imdb Rating : ${homeScreenCtr.moviesList[index].imdbRating}',overflow: TextOverflow.ellipsis,),
                    ],
                  ),
                ),
              );
            },itemCount: homeScreenCtr.moviesList.length,shrinkWrap: true,scrollDirection: Axis.horizontal,padding: const EdgeInsets.symmetric(horizontal: 10),):
            const Center(child: CircularProgressIndicator(),)
            ,
          ),
        ],
      ),
    );
  }
  Widget seriesRow(Size size) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.red.shade50,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Padding(
                padding: EdgeInsets.only(left: size.width * 0.03,),
                child: Text('Series',style: TextStyle(fontSize: size.height * 0.023),),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon( Icons.chevron_right_sharp),
              )
            ],
          ),
          SizedBox(
            height: size.height * 0.30,
            width: size.width,
            child: homeScreenCtr.seriesList.isNotEmpty ?ListView.builder(itemBuilder: (context,index) {
              return GestureDetector(
                onTap: () => Get.to(()=> PreviewScreen(moviesModel: homeScreenCtr.seriesList[index],)),
                child: Container(
                  width: size.width * 0.4,
                  margin: const EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    children: [
                      Card(clipBehavior: Clip.hardEdge,child: Hero(tag: homeScreenCtr.seriesList[index].title??index,child: FadeInImage.memoryNetwork(image:homeScreenCtr.seriesList[index].poster??'-', placeholder: kTransparentImage,height: size.height * 0.25,fit: BoxFit.cover,))),
                      Text(homeScreenCtr.seriesList[index].title??'-'),
                      Text('imdb Rating : ${homeScreenCtr.seriesList[index].imdbRating}',overflow: TextOverflow.ellipsis,),
                    ],
                  ),
                ),
              );
            },itemCount: homeScreenCtr.seriesList.length,shrinkWrap: true,scrollDirection: Axis.horizontal,padding: const EdgeInsets.symmetric(horizontal: 10),):
            const Center(child: CircularProgressIndicator(),)
            ,
          ),
        ],
      ),
    );
  }
  Widget animeRow(Size size) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.red.shade50,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Padding(
                padding: EdgeInsets.only(left: size.width * 0.03,),
                child: Text('Anime',style: TextStyle(fontSize: size.height * 0.023),),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon( Icons.chevron_right_sharp),
              )
            ],
          ),
          SizedBox(
            height: size.height * 0.30,
            width: size.width,
            child: homeScreenCtr.animeList.isNotEmpty ?ListView.builder(itemBuilder: (context,index) {
              return GestureDetector(
                onTap: () => Get.to(()=> PreviewScreen(moviesModel: homeScreenCtr.animeList[index])),
                child: Container(
                  width: size.width * 0.4,
                  margin: const EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    children: [
                      Card(clipBehavior: Clip.hardEdge,child: Hero(tag: homeScreenCtr.animeList[index].title??index,child: FadeInImage.memoryNetwork(image:homeScreenCtr.animeList[index].poster??'-', placeholder: kTransparentImage,height: size.height * 0.25,fit: BoxFit.cover,))),
                      Text(homeScreenCtr.animeList[index].title??'-'),
                      Text('imdb Rating : ${homeScreenCtr.animeList[index].imdbRating}',overflow: TextOverflow.ellipsis,),
                    ],
                  ),
                ),
              );
            },itemCount: homeScreenCtr.animeList.length,shrinkWrap: true,scrollDirection: Axis.horizontal,padding: const EdgeInsets.symmetric(horizontal: 10),):
            const Center(child: CircularProgressIndicator(),)
            ,
          ),
        ],
      ),
    );
  }
}



// CustomScrollView(
// slivers: [
// SliverToBoxAdapter(),
// ],
// )