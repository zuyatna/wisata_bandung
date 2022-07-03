import 'package:flutter/material.dart';
import 'package:wisata_bandung/model/tourism_place.dart';
import 'detail_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wisata Bandung. Size: ${MediaQuery.of(context).size.width}'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth <= 600) {
            return const TourismPlaceList();
          } else {
            return const TourismPlaceGrid();
          }
        },
      ),
    );
  }
}

class TourismPlaceList extends StatelessWidget {
  const TourismPlaceList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      final TourismPlace place = tourismPlaceList[index];
      return InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return DetailScreen(place: place, index: index,);
          }));
        },
        child: Card(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Hero(
                  tag: 'place$index',
                  child: Image.asset(place.imageAsset),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        place.name,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 10,),
                      Text(place.location)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
      itemCount: tourismPlaceList.length,
    );
  }
}

class TourismPlaceGrid extends StatelessWidget {
  const TourismPlaceGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: GridView.count(crossAxisCount: 4,
        children: tourismPlaceList.map((place) {
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DetailScreen(place: place, index: tourismPlaceList.indexOf(place));
              }));
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: Image.asset(
                    place.imageAsset,
                    fit: BoxFit.cover,
                  )),
                  const SizedBox(height: 8,),
                  Padding(padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      place.name,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                    child: Text(place.location),
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
