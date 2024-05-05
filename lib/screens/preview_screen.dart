import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movies_up/models/movies_model.dart';
import 'package:transparent_image/transparent_image.dart';


class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key,required this.moviesModel,required this.index});
  final MoviesModel moviesModel;
  final int index;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 160.0,
            flexibleSpace: FlexibleSpaceBar(
              //titlePadding: const EdgeInsets.only(left: 20),
              title: Text('${moviesModel.type?.toUpperCase()}',style: const TextStyle(fontSize: 40,fontWeight: FontWeight.w400,color: Colors.black),),
              background: Image.asset('assets/images/placeholder_bg.jpg',fit:BoxFit.fill,),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: size.height,
              width: size.width,
              padding: EdgeInsets.only(top: size.height * 0.015),
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [Color(0xFFEEF7FF),Color(0xFFFEFAF6)])
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(child: Card(
                        clipBehavior: Clip.hardEdge,
                        child: Hero(
                          tag: 'hero$index',
                          child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: moviesModel.poster??'', height:size.height * 0.3,),
                        ),
                      )),
                      Flexible(child: SizedBox(
                        height: size.height * 0.3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: size.height * 0.01,),
                            Text('Title : ${moviesModel.title}',style: TextStyle(fontSize: size.height * 0.03,fontWeight: FontWeight.w500),maxLines: 2,overflow: TextOverflow.ellipsis,),
                            // SizedBox(height: size.height * 0.02,),
                            const Divider(indent: 5,endIndent: 5,),
                            Text('IMDb : ${moviesModel.imdbRating}/10',style: TextStyle(fontSize: size.height * 0.025),maxLines: 2,overflow: TextOverflow.ellipsis,),
                            SizedBox(height: size.height * 0.01,),
                            Text('Year : ${moviesModel.year}',style: TextStyle(fontSize: size.height * 0.025),maxLines: 2,overflow: TextOverflow.ellipsis,),
                            SizedBox(height: size.height * 0.01,),
                            Text('Director : ${moviesModel.director}',style: TextStyle(fontSize: size.height * 0.025),maxLines: 2,overflow: TextOverflow.ellipsis,),
                            SizedBox(height: size.height * 0.01,),
                            Text('Available In : ${moviesModel.language}'??'-',style: TextStyle(fontSize: size.height * 0.025),maxLines: 2,overflow: TextOverflow.ellipsis,),
                          ],
                        ),
                      ))
                    ],
                  ),
                  const Divider(),
                  Flexible(child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 3),
                    child: Text(
                      'Genre : ${moviesModel.genre}',
                      style:  TextStyle(fontSize: size.height * 0.024,fontWeight: FontWeight.w400,color: Colors.black),
                      textAlign: TextAlign.left,
                    ),
                  )),
                  SizedBox(height: size.height * 0.001,),
                  Flexible(child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 3),
                    child: Text(
                      'Actors : ${moviesModel.actors}',
                      style: TextStyle(fontSize: size.height * 0.024,fontWeight: FontWeight.w400,color: Colors.black),
                      textAlign: TextAlign.left,
                    ),
                  )),
                  SizedBox(height: size.height * 0.001,),
                  Flexible(child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 3),
                    child: Text(
                      'Actors : ${moviesModel.awards}',
                      style: TextStyle(fontSize: size.height * 0.024,fontWeight: FontWeight.w400,color: Colors.black),
                      textAlign: TextAlign.left,
                    ),
                  )),
                  const Divider(),
                   Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 3),
                    child: Text(
                      'Ratings : ',
                      style: TextStyle(fontSize: size.height * 0.024,fontWeight: FontWeight.w400,color: Colors.black),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  ListView.builder(itemBuilder: (context,index) {
                    return ListTile(
                      leading: const Icon(Icons.star),
                      title: Text(moviesModel.ratings![index].source??'-'),
                      subtitle: Text(moviesModel.ratings![index].value??'-'),
                    );
                  },itemCount: moviesModel.ratings?.length??0,shrinkWrap: true,padding: EdgeInsets.zero,physics: const NeverScrollableScrollPhysics(),),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 3),
                    child: Text(
                      'Plot : ${moviesModel.plot}',
                      style: TextStyle(fontSize: size.height * 0.024,fontWeight: FontWeight.w400,color: Colors.black),
                    ),
                  ),
                  const Divider(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
